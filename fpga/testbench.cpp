#include <stdlib.h>
#include <typeinfo>
#include <iostream>
#include "checker.h"
#include "kernel.cpp"

using real = float;

// template <typename real> void kernel(real *v, bool *convFPGA, unsigned int *numIter);

int main(){
	real vFPGA[NX*NY],fFPGA[NX*NY];
	bool converged=false;
	unsigned int numIter=0;


	kernel<real> (vFPGA, &converged, &numIter);


	if (!converged){
		std::cout << "ERROR: Failed to converge\n";
		return 1;
	}

	// Compute error between types
	double vFPGA_double [NX * NY];
	double error;
	bool converged_double=false;
	unsigned int numIter_double=0;

	kernel<double> (vFPGA_double, &converged_double, &numIter_double);

	error = sqm(vFPGA_double, vFPGA, NX*NY);
	std::cout << "L'errore tra double e " << typeid(vFPGA[0]).name() << " è: " << error << std::endl;

	if(compareToFile(vFPGA_double,NX,NY,NMAX,EPS)!=0){
		printf("ERROR: Converged to a wrong solution\n");
		return 2;
	}

	std::cout << "Converged after " << numIter << " iterations (nx= " << NX << ", ny= " << NY << ", e=BHO)\n" << std::endl;

	return 0;
}
