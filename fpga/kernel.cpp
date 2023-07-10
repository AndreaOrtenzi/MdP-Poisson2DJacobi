// #include "string.h"
#include "math.h"

#ifndef NX
#define NX 16
#endif
#ifndef NY
#define NY 16
#endif
#define NMAX 200000
#define EPS 1e-5


void initialization(double *f/*, unsigned int NX, unsigned int NY*/){

	// Initialize input
    for (int iy = 0; iy < NY; iy++) {
        for (int ix = 0; ix < NX; ix++) {
          const double x = 2.0 * ix / (NX - 1.0) - 1.0;
          const double y = 2.0 * iy / (NY - 1.0) - 1.0;
          // forcing term is a sinusoid
          f[NX * iy + ix] = sin(x + y);
        }
    }
}

void creating(double *v) {
	for (int iy = 0; iy < NY; iy++) {
	        for (int ix = 0; ix < NX; ix++) {
	        	v[NX*iy + ix] = 0.0;
	        }
	}
}



void kernel(double *v/*, unsigned int NX, unsigned int NY, double EPS, unsigned int NMAX*/, bool *convFPGA, unsigned int *numIter){

#pragma HLS INTERFACE m_axi depth=100 port=v bundle=gmem0
#pragma HLS INTERFACE m_axi depth=100 port=convFPGA bundle=gmem1
#pragma HLS INTERFACE m_axi depth=100 port=numIter bundle=gmem1

#pragma HLS INTERFACE s_axilite port=v
#pragma HLS INTERFACE s_axilite port=convFPGA
#pragma HLS INTERFACE s_axilite port=numIter
/*#pragma HLS INTERFACE s_axilite port=NX
#pragma HLS INTERFACE s_axilite port=NY
#pragma HLS INTERFACE s_axilite port=EPS
#pragma HLS INTERFACE s_axilite port=NMAX*/
#pragma HLS INTERFACE s_axilite port=return

//#pragma HLS ARRAY_PARTITION variable=c_local type=complete dim=1

	//memcpy(b_local,b, sizeof(float)*N);


	double f[NX*NY],vp[NX*NY];

	initialization(f);

	unsigned int n = 0;
	double e = 2. * EPS;

	while ((e > EPS) && (n < NMAX))
	{
		e = 0.0;

		for( int ix = 1; ix < (NX-1); ix++ )
		{
			for (int iy = 1; iy < (NY-1); iy++)
			{
				double d;

				vp[iy*NX+ix] = -0.25 * (f[iy*NX+ix] -
					(v[NX*iy     + ix+1] + v[NX*iy     + ix-1] +
					 v[NX*(iy+1) + ix  ] + v[NX*(iy-1) + ix  ]));

				d = fabs(vp[NX*iy+ix] - v[NX*iy+ix]);
				e = (d > e) ? d : e;
			}
		}

		// Update v and compute error as well as error weight factor

		double w = 0.0;

		for (int ix = 1; ix < (NX-1); ix++)
		{
			for (int iy = 1; iy < (NY-1); iy++)
			{
				v[NX*iy+ix] = vp[NX*iy+ix];
				w += fabs(v[NX*iy+ix]);
			}
		}

		for (int ix = 1; ix < (NX-1); ix++)
		{
			v[NX*0      + ix] = v[NX*(NY-2) + ix];
			v[NX*(NY-1) + ix] = v[NX*1      + ix];
			w += fabs(v[NX*0+ix]) + fabs(v[NX*(NY-1)+ix]);
		}

		for (int iy = 1; iy < (NY-1); iy++)
		{
			v[NX*iy + 0]      = v[NX*iy + (NX-2)];
			v[NX*iy + (NX-1)] = v[NX*iy + 1     ];
			w += fabs(v[NX*iy+0]) + fabs(v[NX*iy+(NX-1)]);
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

