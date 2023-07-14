#include <stdio.h>
#include <stdlib.h>
#include "checker.h"
#include "kernel.cpp"

using real = double;

// template <typename real> void kernel(real *v, bool *convFPGA, unsigned int *numIter);

int main(){
	real vCPU[NX*NY],fCPU[NX*NY];
	real vFPGA[NX*NY],fFPGA[NX*NY];
	bool converged=false;
	unsigned int numIter=0;


	kernel<real> (vFPGA, &converged, &numIter);

	if (!converged){
		printf("ERROR: Failed to converge\n");
		return 1;
	}

	if(compareToFile(vFPGA,NX,NY,NMAX,EPS)!=0){
		printf("ERROR: Converged to a wrong solution\n");
		return 2;
	}

	printf("Converged after %d iterations (nx=%d, ny=%d, e=BHO)\n", numIter, NX, NY);

	return 0;
}
