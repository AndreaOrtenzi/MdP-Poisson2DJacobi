#include <math.h>

void kernel_double(double *v, unsigned int nx, unsigned int ny, double EPS, unsigned int NMAX, bool *convFPGA, unsigned int *numIter){


	double f[nx*ny],vp[nx*ny];

	// Initialize input
	for (unsigned int iy = 0; iy < ny; iy++) {
		for (unsigned int ix = 0; ix < nx; ix++) {
		  const double x = 2.0 * ix / (nx - 1.0) - 1.0;
		  const double y = 2.0 * iy / (ny - 1.0) - 1.0;
		  // forcing term is a sinusoid
		  f[nx * iy + ix] = std::sin(x + y);
		}
	}

	for (unsigned int iy = 0; iy < ny; iy++) {
		for (int ix = 0; ix < nx; ix++) {
			v[nx*iy + ix] = 0.0;
		}
	}


	unsigned int n = 0;
	double e = 2. * EPS;

	constexpr double quart = -0.25;
	const double invh2 = 1.0/(nx*ny); // 1/(n^2)

	while ((e > EPS) && (n < NMAX))
	{
		e = 0.0;

		for( int ix = 1; ix < (nx-1); ix++ )
		{
			for (int iy = 1; iy < (ny-1); iy++)
			{
				double d;

				vp[iy*nx+ix] = quart * (invh2*f[iy*nx+ix] -
					(v[nx*iy     + ix+1] + v[nx*iy     + ix-1] +
					 v[nx*(iy+1) + ix  ] + v[nx*(iy-1) + ix  ]));

				d = std::fabs(vp[nx*iy+ix] - v[nx*iy+ix]);
				e = (d > e) ? d : e;
			}
		}

		// Update v and compute error as well as error weight factor

		double w = 0.0;

		for (int ix = 1; ix < (nx-1); ix++)
		{
			for (int iy = 1; iy < (ny-1); iy++)
			{
				v[nx*iy+ix] = vp[nx*iy+ix];
				w += std::fabs(v[nx*iy+ix]);
			}
		}

		for (int ix = 1; ix < (nx-1); ix++)
		{
			v[nx*0      + ix] = v[nx*(ny-2) + ix];
			v[nx*(ny-1) + ix] = v[nx*1      + ix];

			w += std::fabs(v[nx*0+ix]) + std::fabs(v[nx*(ny-1)+ix]);
		}

		for (int iy = 1; iy < (ny-1); iy++)
		{
			v[nx*iy + 0]      = v[nx*iy + (nx-2)];
			v[nx*iy + (nx-1)] = v[nx*iy + 1     ];

			w += std::fabs(v[nx*iy+0]) + std::fabs(v[nx*iy+(nx-1)]);
		}

		w /= (nx * ny);
		e /= w;

		//if ((n % 10) == 0)
		//    printf("%5d, %0.4e\n", n, e);

		n++;
	}

	*numIter = n;
	*convFPGA = (e < EPS ? true : false);

}
