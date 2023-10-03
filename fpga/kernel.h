#ifndef N
#define N 16
#endif

#ifndef NX
#define NX N
#endif
#ifndef NY
#define NY N
#endif

#ifndef KERNEL_INCL
#define KERNEL_INCL

#define NMAX 200000
#define EPS 1.e-5

#ifndef FIXED
#define FIXED true
#endif

#if FIXED
#include "ap_fixed.h"
#define REAL ap_fixed<32, 5> // < , I> I: integer bits
#include "hls_math.h"
#else
#include "math.h"
#ifndef REAL
#define REAL float // change also BYTES_REAL
#endif // REAL
#endif // FIXED

#include <cstring>

void kernel(REAL *v/*, unsigned int NX, unsigned int NY, double EPS, unsigned int NMAX*/, bool *convFPGA, unsigned int *numIter);

#endif // KERNEL_INCL
