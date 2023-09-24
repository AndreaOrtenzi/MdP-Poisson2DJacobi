#ifndef N
#define N 128
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
#define EPS 1e-5

#ifndef FIXED
#define FIXED false
#endif

#if FIXED
#include "ap_fixed.h"
#define REAL ap_fixed<32, 10> // < , I> I: integer bits
#include "hls_math.h"
#else
#include "math.h"
#ifndef REAL
#define REAL float // change also BYTES_REAL
#endif
#endif
#endif

#include <cstring>

void kernel(REAL *v/*, unsigned int NX, unsigned int NY, double EPS, unsigned int NMAX*/, bool *convFPGA, unsigned int *numIter);

#endif // KERNEL_INCL
