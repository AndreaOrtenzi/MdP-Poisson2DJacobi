#include "kernel.h"


void initialization(REAL *f){

	// Initialize input
    for (int iy = 0; iy < NY; iy++) {
        for (int ix = 0; ix < NX; ix++) {
          const REAL x = 2.0 * ix / (NX - 1.0) - 1.0;
          const REAL y = 2.0 * iy / (NY - 1.0) - 1.0;
          // forcing term is a sinusoid
#if FIXED
		  f[NX * iy + ix] = hls::sin(x + y);
#else
		  f[NX * iy + ix] = sin(x + y);
#endif
        }
    }
}


void creation(REAL *v) {
	for (int iy = 0; iy < NY; iy++) {
		for (int ix = 0; ix < NX; ix++) {
			v[NX*iy + ix] = 0.0;
		}
	}
}


void kernel(REAL *v, bool *convFPGA, unsigned int *numIter) {

#pragma HLS INTERFACE m_axi depth=NX*NY port=v bundle=gmem0
#pragma HLS INTERFACE m_axi depth=1 port=convFPGA bundle=gmem1
#pragma HLS INTERFACE m_axi depth=1 port=numIter bundle=gmem1

#pragma HLS INTERFACE s_axilite port=v
#pragma HLS INTERFACE s_axilite port=convFPGA
#pragma HLS INTERFACE s_axilite port=numIter
#pragma HLS INTERFACE s_axilite port=return

//#pragma HLS ARRAY_PARTITION variable=c_local type=complete dim=1

	//memcpy(b_local,b, sizeof(float)*N);

	REAL f[NX*NY],vp[NX*NY];

	initialization(f);

	creation(v);
	unsigned int n = 0;
	REAL e = 2. * EPS;
	const REAL quart = -0.25;

	while ((e > EPS) && (n < NMAX))
	{
		e = 0.0;

		for(unsigned int ix = 1; ix < (NX-1); ix++ )
		{
			for (unsigned int iy = 1; iy < (NY-1); iy++)
			{
				REAL d;

				vp[iy*NX+ix] = quart * (f[iy*NX+ix] -
					(v[NX*iy     + ix+1] + v[NX*iy     + ix-1] +
					 v[NX*(iy+1) + ix  ] + v[NX*(iy-1) + ix  ]));

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

		for (unsigned int ix = 1; ix < (NX-1); ix++)
		{
			for (unsigned int iy = 1; iy < (NY-1); iy++)
			{
				v[NX*iy+ix] = vp[NX*iy+ix];
#if FIXED
					w += hls::fabs(v[NX*iy+ix]);
#else
					w += std::fabs(v[NX*iy+ix]);
#endif
			}
		}

		for (unsigned int ix = 1; ix < (NX-1); ix++)
		{
			v[NX*0      + ix] = v[NX*(NY-2) + ix];
			v[NX*(NY-1) + ix] = v[NX*1      + ix];
#if FIXED
				w += hls::fabs(v[NX*0+ix]) + hls::fabs(v[NX*(NY-1)+ix]);
#else
				w += std::fabs(v[NX*0+ix]) + std::fabs(v[NX*(NY-1)+ix]);
#endif
		}

		for (unsigned int iy = 1; iy < (NY-1); iy++)
		{
			v[NX*iy + 0]      = v[NX*iy + (NX-2)];
			v[NX*iy + (NX-1)] = v[NX*iy + 1     ];
#if FIXED
				w += hls::fabs(v[NX*iy+0]) + hls::fabs(v[NX*iy+(NX-1)]);
#else
				w += std::fabs(v[NX*iy+0]) + std::fabs(v[NX*iy+(NX-1)]);
#endif
		}

		w /= (NX * NY);
		e /= w;

		//if ((n % 10) == 0)
		//    printf("%5d, %0.4e\n", n, e);

		n++;
	}

	*numIter = n;
	*convFPGA = (e < EPS ? true : false);

}



