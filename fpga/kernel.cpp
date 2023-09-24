#include "kernel.h"

constexpr unsigned int unroll_factor = 1<<4;

inline void initialization(REAL *f, REAL *v){

	// Initialize input
	init_loop:for (int iy = 0; iy < NY; iy++) {
		in_init_loop:for (int ix = 0; ix < NX; ix++) {
		#pragma HLS PIPELINE
		#pragma HLS UNROLL factor=unroll_factor
          const REAL x = 2.0 * ix / (NX - 1.0) - 1.0;
          const REAL y = 2.0 * iy / (NY - 1.0) - 1.0;
          // forcing term is a sinusoid
#if FIXED
		  f[NX * iy + ix] = hls::sin(x + y);
#else
		  f[NX * iy + ix] = sin(x + y);
#endif
		  v[NX * iy + ix] = 0.0;
        }
    }
}

template <unsigned int size, class T>
inline void mycpy(T *from,T *to){

	mycpy:for (unsigned int i = 0; i<size; ++i){
#pragma HLS UNROLL factor=unroll_factor
		to[i]=from[i];
	}
}


void kernel(REAL *v_out, bool *convFPGA, unsigned int *numIter) {

#pragma HLS INTERFACE m_axi depth=NX*NY port=v_out bundle=gmem0
#pragma HLS INTERFACE m_axi depth=1 port=convFPGA bundle=gmem1
#pragma HLS INTERFACE m_axi depth=1 port=numIter bundle=gmem1

#pragma HLS INTERFACE s_axilite port=v_out
#pragma HLS INTERFACE s_axilite port=convFPGA
#pragma HLS INTERFACE s_axilite port=numIter
#pragma HLS INTERFACE s_axilite port=return

	REAL f[NX*NY],vp[NX*NY],v[NX*NY]; // *temp; // *vp=vp_arr,*v=v_arr;

#pragma HLS ARRAY_PARTITION variable=f type=complete dim=1
#pragma HLS ARRAY_PARTITION variable=vp type=complete dim=1
#pragma HLS ARRAY_PARTITION variable=v type=complete dim=1

	initialization(f,v);

	vp[0]=0.0;
	vp[NX-1]=0.0;
	vp[NX*(NY-1)]=0.0;
	vp[NX*NY-1]=0.0;

	unsigned int n = 0;
	REAL e = 2. * EPS;
	constexpr REAL quart = -0.25;
	constexpr REAL invh2 = 1.0/(N*N); // 1/(n^2)

	while_loop: while ((e > EPS) && (n < NMAX)) //
	{

		// Do an iteration without computing e
		no_e_first_loop:for(unsigned int iy = 1; iy < (NY-1); iy++ )
		{
			no_e_in_first_loop:for (unsigned int ix = 1; ix < (NX-1); ix++)
			{
				vp[iy*NX+ix] = quart * (f[iy*NX+ix]*invh2 -
					(v[NX*iy     + ix+1] + v[NX*iy     + ix-1] +
					 v[NX*(iy+1) + ix  ] + v[NX*(iy-1) + ix  ]));

/*
				#if (NX-2)%2==0
					ix++;
					vp[iy*NX+ix] = quart * (f[iy*NX+ix] - // Inferring partial write operation for 'vp'
										(v[NX*iy     + ix+1] + v[NX*iy     + ix-1] + // bus read operation on v
										 v[NX*(iy+1) + ix  ] + v[NX*(iy-1) + ix  ])); // unable to schedule bus read operation on port gmem0 due to
									// limited memory ports (II = 3). Please consider using a memory core with more ports or partitioning the array

					#if FIXED
						d = hls::fabs(vp[NX*iy+ix] - v[NX*iy+ix]);
					#else
						d = std::fabs(vp[NX*iy+ix] - v[NX*iy+ix]);
					#endif
					e = (d > e) ? d : e;
				#endif
*/
			}
		}

		#if NX==NY
			no_e_cpy_third_and_fourth_loop: for (unsigned int i = 1; i < (NX-1); i++)
			{
				vp[NX*0      + i] = vp[NX*(NY-2) + i];
				vp[NX*(NY-1) + i] = vp[NX*1      + i];
				vp[NX*i + 0]      = vp[NX*i + (NX-2)];
				vp[NX*i + (NX-1)] = vp[NX*i + 1     ];
			}
		#else
			no_e_cpy_third_loop: for (unsigned int ix = 1; ix < (NX-1); ix++)
			{
				vp[NX*0      + ix] = vp[NX*(NY-2) + ix];
				vp[NX*(NY-1) + ix] = vp[NX*1      + ix];
			}

			no_e_cpy_fourth_loop: for (unsigned int iy = 1; iy < (NY-1); iy++)
			{
				vp[NX*iy + 0]      = vp[NX*iy + (NX-2)];
				vp[NX*iy + (NX-1)] = vp[NX*iy + 1     ];
			}
		#endif

		// Do another iteration computing e
		e = 0.0;

		first_loop:for(unsigned int iy = 1; iy < (NY-1); iy++ ) // flattering a loop nest
		{
			in_first_loop:for (unsigned int ix = 1; ix < (NX-1); ix++)
			{
				REAL d;

				v[iy*NX+ix] = quart * ( f[iy*NX+ix]*invh2 - // Inferring partial write operation for 'vp'
					(vp[NX*iy     + ix+1] + vp[NX*iy     + ix-1] + // bus read operation on v
					 vp[NX*(iy+1) + ix  ] + vp[NX*(iy-1) + ix  ])); // unable to schedule bus read operation on port gmem0 due to
				// limited memory ports (II = 3). Please consider using a memory core with more ports or partitioning the array

#if FIXED
					d = hls::fabs(v[NX*iy+ix] - vp[NX*iy+ix]);
#else
					d = std::fabs(v[NX*iy+ix] - vp[NX*iy+ix]);
#endif
				e = (d > e) ? d : e;
			}
		}

#if NX==NY
		cpy_third_and_fourth_loop: for (unsigned int i = 1; i < (NX-1); i++)
		{
			v[NX*0      + i] = v[NX*(NY-2) + i];
			v[NX*(NY-1) + i] = v[NX*1      + i];
			v[NX*i + 0]      = v[NX*i + (NX-2)];
			v[NX*i + (NX-1)] = v[NX*i + 1     ];
		}
#else
		cpy_third_loop: for (unsigned int ix = 1; ix < (NX-1); ix++)
		{
			v[NX*0      + ix] = v[NX*(NY-2) + ix];
			v[NX*(NY-1) + ix] = v[NX*1      + ix];
		}

		cpy_fourth_loop: for (unsigned int iy = 1; iy < (NY-1); iy++)
		{
			v[NX*iy + 0]      = v[NX*iy + (NX-2)];
			v[NX*iy + (NX-1)] = v[NX*iy + 1     ];
		}
#endif

		/*out_mycpy:for (unsigned int iy = 1; iy<NY-1; ++iy){
		#pragma HLS dependence variable=v type=inter false
			mycpy<NX-2>(&vp[NX*iy+1],&v[NX*iy+1]);
		}*/



		REAL w = 0.0;
		w_second_loop: for (unsigned int iy = 0; iy < NY; iy++)
		{
			REAL w_local = 0.0;
			w_in_second_loop:for (unsigned int ix = 0; ix < unroll_factor; ix++)
			{
			#pragma HLS UNROLL
#if FIXED
					w_local += hls::fabs(v[unroll_factor*iy+ix]); // dependency here on w load and store
#else
					w_local += std::fabs(v[unroll_factor*iy+ix]);
#endif
			}
			w += w_local;
		}


		w /= (NX * NY);
		e /= w;

		//if ((n % 10) == 0)
		//    printf("%5d, %0.4e\n", n, e);
		n+=2;
	}

	*numIter = n;
	*convFPGA = (e <= EPS ? true : false);

	/* TO FIX
	 * final_mycpy:for(unsigned int iy = 0; iy<NY; ++iy){
	#pragma HLS dependence variable=v_out type=inter false
		mycpy<NX>(v,v_out);
	}*/
	memcpy(v_out,v,sizeof(REAL)*NX*NY); // Loop_1

}



