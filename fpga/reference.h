#include <math.h>

void kernel_double(double *v, unsigned int NX, unsigned int NY, double EPS, unsigned int NMAX, bool *convFPGA, unsigned int *numIter){


	double f[NX*NY],vp[NX*NY];

	// Initialize input
	for (unsigned int iy = 0; iy < NY; iy++) {
		for (unsigned int ix = 0; ix < NX; ix++) {
		  const double x = 2.0 * ix / (NX - 1.0) - 1.0;
		  const double y = 2.0 * iy / (NY - 1.0) - 1.0;
		  // forcing term is a sinusoid
		  f[NX * iy + ix] = std::sin(x + y);
		}
	}

	for (unsigned int iy = 0; iy < NY; iy++) {
		for (int ix = 0; ix < NX; ix++) {
			v[NX*iy + ix] = 0.0;
		}
	}


	unsigned int n = 0;
	double e = 2. * EPS;
	const double quart = -0.25;

	while ((e > EPS) && (n < NMAX))
	{
		e = 0.0;

		for( int ix = 1; ix < (NX-1); ix++ )
		{
			for (int iy = 1; iy < (NY-1); iy++)
			{
				double d;

				vp[iy*NX+ix] = quart * (f[iy*NX+ix] -
					(v[NX*iy     + ix+1] + v[NX*iy     + ix-1] +
					 v[NX*(iy+1) + ix  ] + v[NX*(iy-1) + ix  ]));

				d = std::fabs(vp[NX*iy+ix] - v[NX*iy+ix]);
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
				w += std::fabs(v[NX*iy+ix]);
			}
		}

		for (int ix = 1; ix < (NX-1); ix++)
		{
			v[NX*0      + ix] = v[NX*(NY-2) + ix];
			v[NX*(NY-1) + ix] = v[NX*1      + ix];

			w += std::fabs(v[NX*0+ix]) + std::fabs(v[NX*(NY-1)+ix]);
		}

		for (int iy = 1; iy < (NY-1); iy++)
		{
			v[NX*iy + 0]      = v[NX*iy + (NX-2)];
			v[NX*iy + (NX-1)] = v[NX*iy + 1     ];

			w += std::fabs(v[NX*iy+0]) + std::fabs(v[NX*iy+(NX-1)]);
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
