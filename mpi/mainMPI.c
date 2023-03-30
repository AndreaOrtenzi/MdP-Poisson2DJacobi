/*
 * Copyright (c) 2021, Dirk Pleiter, KTH
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *  * Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *  * Neither the name of NVIDIA CORPORATION nor the names of its
 *    contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "helper.h"
#include <string.h>
#include <omp.h>
#include <mpi.h>

#ifndef NX
#define NX 128
#endif
#ifndef NY
#define NY 128
#endif
#define NMAX 2000000
#define EPS 1e-5

int solver_transposed_mpi(double *,double *, double *, int, int, double, int,MPI_Comm,int,int);
int solver_transposed_mpi_avx(double *,double *, double *, int, int, double, int,MPI_Comm,int,int);

void printArr(double *v, size_t nx, size_t ny){
    return;
    for (size_t y = 0; y < ny; y++)
    {
        for (size_t x = 0; x < nx; x++)
        {
            printf("%.4f, ",v[y*nx+x]);
        }
        printf("\n");
    }
        printf("\n");
    
}
#define IF_MASTER if(rank==0)

int main(int argc, char** argv)
{
    MPI_Init(&argc, &argv);
    int world_size;
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);
    int rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    IF_MASTER printf("OMP-Threads: %d\n", omp_get_max_threads());
    IF_MASTER printf("MPI-tasks:  %d\n", world_size);



     // Ask MPI to decompose our processes in a 2D cartesian grid for us
    int dims[2] = {0, 0};
    MPI_Dims_create(world_size, 2, dims);
    IF_MASTER printf("DIMS (%d, %d)\n",dims[0],dims[1]);
    // Make both dimensions periodic
    int periods[2] = {true, true};
    // Let MPI assign arbitrary ranks if it deems it necessary
    int reorder = true;
    // Create a communicator given the 2D torus topology.
    MPI_Comm new_communicator;
    MPI_Cart_create(MPI_COMM_WORLD, 2, dims, periods, reorder, &new_communicator);    
    // My rank in the new communicator
    int my_rank;
    MPI_Comm_rank(new_communicator, &my_rank);
    // Get my coordinates in the new communicator
    int my_coords[2];
    MPI_Cart_coords(new_communicator, my_rank, 2, my_coords);


    int mpiSizeX = dims[0];
    int mpiSizeY = dims[1];
    size_t NX_true = NX - 2;
    size_t NY_true = NY - 2;
    size_t NXL = NX_true/mpiSizeX;
    size_t NYL = NY_true/mpiSizeY;
    // printf("NYL: %d\n",NYL);
    size_t NXLRest = NX_true%mpiSizeX;
    size_t NYLRest = NY_true%mpiSizeY;
    if(my_coords[0]<NXLRest)NXL++;
    if(my_coords[1]<NYLRest)NYL++;
    size_t NXLStart = (NX_true/mpiSizeX) * my_coords[0];
    size_t NYLStart = (NY_true/mpiSizeY) * my_coords[1];
    if(my_coords[0]<NXLRest)NXLStart+=my_coords[0];
    else NXLStart+=NXLRest;
    if(my_coords[1]<NYLRest)NYLStart+=my_coords[1];
    else NYLStart+=NYLRest;

    // printf("NXLStart=%d \n",NXLStart);


    double *v,*v_tmp;
    double *f;

    // Allocate memory
    v = (double *) malloc((NXL+2) * (NYL+2) * sizeof(double));
    v_tmp = (double *) malloc((NXL+2) * (NYL+2) * sizeof(double));
    f = (double *) malloc((NXL+2) * (NYL+2) * sizeof(double));
	// v = aligned_alloc(64, (NXL+2) * (NYL+2) * sizeof(double));
	// v_tmp = aligned_alloc(64, (NXL+2) * (NYL+2) * sizeof(double));
	// f = aligned_alloc(64, (NXL+2) * (NYL+2) * sizeof(double));




    // Initialise input
    for (int iy = 0; iy < (NYL+2); iy++)
        for (int ix = 0; ix < (NXL+2); ix++)
        {
            v[(NXL+2)*iy+ix] = 0.0;

            const double x = 2.0 * (ix+NXLStart) / (NX - 1.0) - 1.0;
            const double y = 2.0 * (iy+NYLStart) / (NY - 1.0) - 1.0;
            f[(NXL+2)*iy+ix] = sin(x + y);
        }
    // Call solver

    memset(v,0.0,(NXL+2) * (NYL+2)* sizeof(double));

    IF_MASTER printf("Solver:\n");
    double start = getTime();
    solver_transposed_mpi(v,v_tmp, f, NX, NY, EPS, NMAX,new_communicator,NXL,NYL);
    double end = getTime();
    IF_MASTER printf("Took %f sec\n", end-start);
    
    memset(v,0.0,(NXL+2) * (NYL+2)* sizeof(double));
    memset(v_tmp,0.0,(NXL+2) * (NYL+2)* sizeof(double));
    IF_MASTER printf("Solver AVX:\n");
    start = getTime();
    solver_transposed_mpi_avx(v,v_tmp, f, NX, NY, EPS, NMAX,new_communicator,NXL,NYL);
    end = getTime();
    IF_MASTER printf("Took %f sec\n", end-start);


    writeGnuPlotFile(v,NX,NY,NXLStart,NYLStart,NXL+2,NYL+2,rank,world_size,new_communicator);

    free(v);
    free(v_tmp);
    free(f);
    MPI_Finalize();
    return 0;
}