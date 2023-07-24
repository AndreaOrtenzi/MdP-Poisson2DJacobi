#include <stdlib.h>
#include <typeinfo>
#include <iostream>

#if not FIXED
#include "checker.h"
#endif

#include "reference.h"
#include <limits.h>

#include "kernel.h"

// template <typename real> void kernel(real *v, bool *convFPGA, unsigned int *numIter);

using real = REAL;

int main(){
	real vFPGA[NX*NY],fFPGA[NX*NY];
	bool converged=false;
	unsigned int numIter=0;


	kernel (vFPGA, &converged, &numIter);


	if (!converged){
		std::cout << "ERROR: Failed to converge\n";
		return 1;
	}
	std::cout << "Converged after " << numIter << " iterations (nx= " << NX << ", ny= " << NY << ", e=BHO)\n" << std::endl;


	// Compute error between types
	double vFPGA_double [NX * NY];
	double error;
	bool converged_double=false;
	unsigned int numIter_double=0;

	kernel_double(vFPGA_double, NX, NY, EPS, NMAX, &converged_double, &numIter_double);

#if not FIXED
	error = sqm(vFPGA_double, vFPGA, NX*NY);
	// error = 0.0;
	std::cout << "L'errore tra double e " << typeid(vFPGA[0]).name() << " è: " << error << ", correct iter num: " << numIter_double << std::endl;
#endif
/*
	if(compareToFile(vFPGA_double,NX,NY,NMAX,EPS)!=0){
		printf("ERROR: Converged to a wrong solution\n");
		return 2;
	}
*/
	// Compute max and min values
    double minE = LONG_MAX, maxE = 0.0;

    // Traverse the given array
    for (unsigned int i = 0; i < NX*NY; i++) {

    	// Min
        if (vFPGA_double[i] != 0.0 && abs(vFPGA_double[i]) < minE) {
            minE = vFPGA_double[i];
        }

        // Max
        if (abs(vFPGA_double[i]) > maxE) {
            maxE = vFPGA_double[i];
        }
    }

    // Print the minimum and maximum element
    std::cout << "The minimum element is " << minE << std::endl;
    std::cout << "The maximum element is " << maxE << std::endl;


    // print
#if FIXED
    ap_fixed<32, 5> test = -3.25;
    std::cout << "Rappresentazione: " << std::endl;
    for (int i = 31; i >= 0; i--) {

    	std::cout << test[i] << " ";

    }
	std::cout << std::endl;
#endif

	return 0;
}
