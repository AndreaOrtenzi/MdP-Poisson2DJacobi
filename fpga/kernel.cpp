#include "kernel.h"


inline void initialization(REAL *f, REAL *v){

	// Initialize input
	init_loop:for (int iy = 0; iy < NY; iy++) {
		in_init_loop:for (int ix = 0; ix < NX; ix++) {
          const REAL x = 2.0 * ix / (NX - 1.0) - 1.0;
          const REAL y = 2.0 * iy / (NY - 1.0) - 1.0;
          // forcing term is a sinusoid
#if FIXED
		  f[NX * iy + ix] = hls::sin(x + y);
#else
		  f[NX * iy + ix] = sin(x + y);
#endif
		  // v[NX * iy + ix] = 0.0;
        }
    }
}


inline void creation(REAL *v) {
	creation_loop:for (int i = 0; i < NY*NX; i++) { // flattering a loop nest
		// for (int ix = 0; ix < NX; ix++) {
			v[i] = 0.0;
		// }
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

	//memcpy(b_local,b, sizeof(float)*N);

	REAL f[NX*NY],vp[NX*NY],v[NX*NY];

#pragma HLS ARRAY_PARTITION variable=f type=complete dim=1
#pragma HLS ARRAY_PARTITION variable=v type=complete dim=1
#pragma HLS ARRAY_PARTITION variable=vp type=complete dim=1

	initialization(f,v);

	creation(v);
	unsigned int n = 0;
	REAL e = 2. * EPS;
	const REAL quart = -0.25;

	while_loop: while ((e > EPS) && (n < NMAX)) //
	{
		n++;
		e = 0.0;

		first_loop:for(unsigned int ix = 1; ix < (NX-1); ix++ ) // flattering a loop nest
		{
			in_first_loop:for (unsigned int iy = 1; iy < (NY-1); iy++)
			{
				REAL d;

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
			}
		}

		// Update v and compute error as well as error weight factor

		REAL w = 0.0;

		cpy_second_loop: for (unsigned int ix = 1; ix < (NX-1); ix++)
		{
			cpy_in_second_loop:for (unsigned int iy = 1; iy < (NY-1); iy++)
			{
				v[NX*iy+ix] = vp[NX*iy+ix];
			}
		}

		cpy_third_loop: for (unsigned int ix = 1; ix < (NX-1); ix++)
		{
			v[NX*0      + ix] = vp[NX*(NY-2) + ix];
			v[NX*(NY-1) + ix] = vp[NX*1      + ix];
		}
		/*w_third_loop: for (unsigned int ix = 1; ix < (NX-1); ix++)
		{
		#pragma HLS unroll
#if FIXED
				w += hls::fabs(v[NX*0+ix]) + hls::fabs(v[NX*(NY-1)+ix]);
#else
				w += std::fabs(v[NX*0+ix]) + std::fabs(v[NX*(NY-1)+ix]);
#endif
		}*/

		cpy_fourth_loop: for (unsigned int iy = 1; iy < (NY-1); iy++)
		{
			v[NX*iy + 0]      = vp[NX*iy + (NX-2)];
			v[NX*iy + (NX-1)] = vp[NX*iy + 1     ];
		}

		/*w_fourth_loop:for (unsigned int iy = 1; iy < (NY-1); iy++)
		{
		#pragma HLS unroll // factor=2
#if FIXED
				w += hls::fabs(vp[NX*iy+0]) + hls::fabs(vp[NX*iy+(NX-1)]);
#else
				w += std::fabs(vp[NX*iy+0]) + std::fabs(vp[NX*iy+(NX-1)]);
#endif
		}*/

		constexpr unsigned int unroll_factor = NY;
		w_second_loop: for (unsigned int ix = 0; ix < NX*NY; ix+=unroll_factor)
		{
			REAL w_local = 0.0;
			w_in_second_loop:for (unsigned int iy = 0; iy < unroll_factor; iy++)
			{
			#pragma HLS unroll
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
		//    printf("%5d, %0.4e\n", n-1, e);
	}

	*numIter = n;
	*convFPGA = (e < EPS ? true : false);

	memcpy(v_out,v,sizeof(REAL)*NX*NY); // Loop_1

}



