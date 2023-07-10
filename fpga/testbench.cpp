#ifndef NX
#define NX 16
#endif
#ifndef NY
#define NY 16
#endif
#define NMAX 200000
#define EPS 1e-5

#include <stdio.h>
#include <stdlib.h>
#include "checker.h"

void kernel(double *v, bool *convFPGA, unsigned int *numIter);

int main(){
	double vCPU[NX*NY],fCPU[NX*NY];
	double vFPGA[NX*NY],fFPGA[NX*NY];
	bool converged=false;
	unsigned int numIter=0;




	kernel(vFPGA, &converged, &numIter);

	if (!converged){
		printf("ERROR: Failed to converge\n");
		return 1;
	}

	if(compareToFile(vFPGA,NX,NY,NMAX,EPS)!=0){
		printf("ERROR: Converged to a wrong solution\n");
		return 2;
	}

	printf("Converged after %d iterations (nx=%d, ny=%d, e=BHO)\n", numIter, NX, NY);
	// check correctness of the results:
	//for(int i = 0; i<N; i++){
		//if (aCPU[i] != aFPGA[i]){
			//printf("Error at index %d: %f != %f\n",i,aCPU[i],aFPGA[i]);
			//return 1;
		//}
//	}

	return 0;
}
