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
#include "helperMPI.h"
#include <string.h>
// #include <omp.h>
#include <mpi.h>
#include <iostream>
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <thrust/transform_reduce.h>
#include <thrust/functional.h>
#include <mpi-ext.h>
#include <nvml.h>
// #include <nvidia/gdk/nvml.h>
#ifndef NX
#define NX 1024
#endif
#ifndef NY
#define NY 1024
#endif
#define NMAX 2000000
#define EPS 1e-5
#define N_SKIP 100

int solver_mpi(double *,double *, double *, int, int, double, int,MPI_Comm,int,int);

#define IF_MASTER if(rank==0)

int main(int argc, char** argv)
{
    MPI_Init(&argc, &argv);
    if (MPIX_Query_cuda_support()) {
        printf("This MPI library has CUDA-aware support.\n");
    } else {
        printf("This MPI library does not have CUDA-aware support.\n");
        exit(EXIT_FAILURE);
    }
    int world_size;
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);
    int rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    // IF_MASTER printf("OMP-Threads: %d\n", omp_get_max_threads());
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
    size_t bytes = (NXL+2) * (NYL+2) * sizeof(double);
	// cudaMallocManaged(&vp, bytes);
	// cudaMallocManaged(&v, bytes);
	// cudaMallocManaged(&v_tmp, bytes);
	// cudaMallocManaged(&f, bytes);
    // CHECK_CUDA_ERROR(cudaMalloc(&ds, bytes));
    v = (double *) malloc((NXL+2) * (NYL+2) * sizeof(double));
    v_tmp = (double *) malloc((NXL+2) * (NYL+2) * sizeof(double));
    f = (double *) malloc((NXL+2) * (NYL+2) * sizeof(double));
	// v = aligned_alloc(64, (NXL+2) * (NYL+2) * sizeof(double));
	// v_tmp = aligned_alloc(64, (NXL+2) * (NYL+2) * sizeof(double));
	// f = aligned_alloc(64, (NXL+2) * (NYL+2) * sizeof(double));

    // if(rank == 0)
    // for (int iy = 0; iy < NY; iy++){
    //     for (int ix = 0; ix < NX; ix++)
    //     {
    //         const double x = 2.0 * ix / (NX - 1.0) - 1.0;
    //         const double y = 2.0 * iy / (NY - 1.0) - 1.0;
    //         double res = sin(x + y);
    //         printf("f[%d,%d]=%f, ",iy,ix,res);
    //     }
    //     printf("\n");
    // }


    // Initialise input
    for (int iy = 0; iy < (NYL+2); iy++)
        for (int ix = 0; ix < (NXL+2); ix++)
        {
            v[(NXL+2)*iy+ix] = 0.0;

            const double x = 2.0 * (ix+NXLStart) / (NX - 1.0) - 1.0;
            const double y = 2.0 * (iy+NYLStart) / (NY - 1.0) - 1.0;
            f[(NXL+2)*iy+ix] = sin(x + y);
            // printf("f[%d,%d]=%f\n",NYLStart + iy, NXLStart + ix,sin(x + y));
        }
    // Call solver
    // return 0;

    memset(v,0.0,(NXL+2) * (NYL+2)* sizeof(double));
    //     for (size_t i = 0; i < world_size; i++)
    // {
    //     MPI_Barrier(new_communicator);
    //     IF_MASTER printf("\n");
    //     MPI_Barrier(new_communicator);
    //     if(my_rank == i)printArr(f,NXL+2,NYL+2);
    // }
    IF_MASTER printf("Solver:\n");
    double start = getTime();
    solver_mpi(v,v_tmp, f, NX, NY, EPS, NMAX,new_communicator,NXL,NYL);
    double end = getTime();
    IF_MASTER printf("Took %f sec\n", end-start);
    
    // memset(v,0.0,(NXL+2) * (NYL+2)* sizeof(double));
    // memset(v_tmp,0.0,(NXL+2) * (NYL+2)* sizeof(double));
    // IF_MASTER printf("Solver AVX:\n");
    // start = getTime();
    // // solver_transposed_mpi_avx(v,v_tmp, f, NX, NY, EPS, NMAX,new_communicator,NXL,NYL);
    // end = getTime();
    // IF_MASTER printf("Took %f sec\n", end-start);
    // compareToFile(v,NX,NY,NMAX,EPS);
    
    // IF_MASTER printf("Writing to file...\n");
    writeGnuPlotFile(v,NX,NY,NXLStart,NYLStart,NXL+2,NYL+2,rank,world_size,new_communicator);
    // MPI_Barrier(new_communicator);
    // IF_MASTER printf("Writing complete\n");
    // for (size_t i = 0; i < world_size; i++)
    // {
    //     MPI_Barrier(new_communicator);
    //     // IF_MASTER printf("\n");
    //     MPI_Barrier(new_communicator);
    //     if(my_rank == i)printArr(v,NXL+2,NYL+2);
    // }
    cudaFree(v);
    cudaFree(v_tmp);
    cudaFree(f);
    MPI_Finalize();
    return 0;
}


#define CHECK_CUDA_ERROR(val) check((val), #val, __FILE__, __LINE__)
template <typename T>
void check(T err, char const* const func, char const* const file,
		int const line)
{
	if (err != cudaSuccess)
	{
		std::cerr << "CUDA Runtime Error at: " << file << ":" << line
				<< std::endl;
		std::cerr << cudaGetErrorString(err) << " " << func << std::endl;
		std::exit(EXIT_FAILURE);
	}
}
#define CHECK_LAST_CUDA_ERROR() checkLast(__FILE__, __LINE__)
void checkLast(char const* const file, int const line)
{
	cudaError_t err{cudaGetLastError()};
	if (err != cudaSuccess)
	{
		std::cerr << "CUDA Runtime Error at: " << file << ":" << line
				<< std::endl;
		std::cerr << cudaGetErrorString(err) << std::endl;
		std::exit(EXIT_FAILURE);
	}
}


__global__
void jacobi(double *v, double *vp, double *f, int X, int Y){
	int tid = threadIdx.x + blockIdx.x* blockDim.x;
	// if(tid >= X*Y) return;
	int x = tid % X;
	int y = tid / X;
	if(x == 0 || y == 0 || y >= Y-1 || x >= X-1) return;
    vp[y*X+x] = -0.25 * (f[y*X+x] - (v[X*y+x+1] + v[X*y+x-1] + v[X*(y+1) + x  ] + v[X*(y-1) + x  ]));
    
    // __syncthreads();
    // if(x==1)
    //     vp[X*y + (X-1)] = vp[X*y + 1     ];
    // if(y==1)
    //     vp[X*(Y-1) + x] = vp[X*1      + x];
    // if(x==X-2)
    //     vp[X*y + 0]      = vp[X*y + (X-2)];
    // if(y==Y-2)
    //     vp[X*0      + x] = vp[X*(Y-2) + x];
    // printf("(%d, %d)=%f\n", x,y,vp[y*X+x]);
	// grid_new[y*X+x]=(grid_old[(y-1)*X+x]+grid_old[(y+1)*X+x]+grid_old[y*X+x-1]+grid_old[y*X+x+1]);
}
__global__
void jacobi_fillRightLeftBounds(double *v, double *v_left, double *v_right, int X, int Y){
	int tid = threadIdx.x + blockIdx.x* blockDim.x;
	// if(tid >= X*Y) return;
	int x = tid % X;
	int y = tid / X;
	if(! ( y > 0 && y < Y - 1) )return;
	if( x == 1 ){
        v_left[y-1] = v[y*X+x];
    } else if( x == X - 2){
        v_right[y-1] = v[y*X+x];
    }
}
__global__
void jacobi_rewriteRightLeftBounds(double *v, double *v_left, double *v_right, int X, int Y){
	int tid = threadIdx.x + blockIdx.x* blockDim.x;
	// if(tid >= X*Y) return;
	int x = tid % X;
	int y = tid / X;
	if(! ( y > 0 && y < Y - 1) )return;
	if( x == 0 ){
        v[y*X+x] = v_left[y-1];
    } else if( x == X - 1){
        v[y*X+x] = v_right[y-1];
    }
    
}
__global__
void jacobi_bounds(double *v, int X, int Y){
	int tid = threadIdx.x + blockIdx.x* blockDim.x;
	int ix = tid % X;
	int iy = tid / X;
    
    if(iy == 0 && ix > 0 && ix < X -1)
        v[X*0      + ix] = v[X*(Y-2) + ix];
    if(iy == Y-1&& ix > 0 && ix < X -1)
        v[X*(Y-1) + ix] = v[X*1      + ix];
    if(ix == 0&& iy > 0&& iy < Y -1)
        v[X*iy + 0]      = v[X*iy + (X-2)];
    if(ix == X-1&& iy > 0&& iy < Y -1)
        v[X*iy + (X-1)] = v[X*iy + 1     ];
}
__global__
void calcDs(double *v, double *vp, double *ds, int X, int Y){
	int tid = threadIdx.x + blockIdx.x* blockDim.x;
	// if(tid >= X*Y) return;
	int x = tid % X;
	int y = tid / X;
	if(x == 0 || y == 0 || y >= Y-1 || x >= X-1) return;
    // vp[y*X+x] = -0.25 * (f[y*X+x] - (v[X*y+x+1] + v[X*y+x-1] + v[X*(y+1) + x  ] + v[X*(y-1) + x  ]));
    ds[y*X+x] = fabs(vp[y*X+x] - v[y*X+x]);
    
    // printf("(%d, %d)=%f\n", x,y,vp[y*X+x]);
	// grid_new[y*X+x]=(grid_old[(y-1)*X+x]+grid_old[(y+1)*X+x]+grid_old[y*X+x-1]+grid_old[y*X+x+1]);
}

template<typename T>
struct absolute_value
{
  __host__ __device__ T operator()(const T &x) const
  {
    // return x < T(0) ? -x : x;
    return fabs(x);
  }
};

int solver_mpi(double *v_CPU,double *vp_CPU, double *f_CPU, int nx, int ny, double eps, int nmax, MPI_Comm comm, int NXL, int NYL )
{
    int rank;
    MPI_Comm_rank(comm, &rank);


    int devices;
    cudaGetDeviceCount(&devices);
    cudaSetDevice( rank % devices);      
    int deviceId; 
	cudaGetDevice(&deviceId);
    printf("CUDA device: %d of %d\n",deviceId,devices);

    double *ds;
    size_t bytes = (NXL+2) * (NYL+2) * sizeof(double);
	// cudaMallocManaged(&vp, bytes);
    CHECK_CUDA_ERROR(cudaMalloc(&ds, bytes));
    double  *v,*vp,*f;
    CHECK_CUDA_ERROR(cudaMalloc(&v, bytes));
    CHECK_CUDA_ERROR(cudaMalloc(&vp, bytes));
    CHECK_CUDA_ERROR(cudaMalloc(&f, bytes));
    CHECK_CUDA_ERROR(cudaMemcpy(v, v_CPU, bytes, cudaMemcpyHostToDevice));
    CHECK_CUDA_ERROR(cudaMemcpy(vp, vp_CPU, bytes, cudaMemcpyHostToDevice));
    CHECK_CUDA_ERROR(cudaMemcpy(f, f_CPU, bytes, cudaMemcpyHostToDevice));
    double  *v_right,*v_right_recv;
    double  *v_left,*v_left_recv;
    CHECK_CUDA_ERROR(cudaMalloc(&v_right, (NYL) * sizeof(double)));
    CHECK_CUDA_ERROR(cudaMalloc(&v_left, (NYL) * sizeof(double)));
    CHECK_CUDA_ERROR(cudaMalloc(&v_right_recv, (NYL) * sizeof(double)));
    CHECK_CUDA_ERROR(cudaMalloc(&v_left_recv, (NYL) * sizeof(double)));

    thrust::device_ptr<double> ds_thrust(ds);
    thrust::device_ptr<double> v_thrust(v);
    
    int numberOfSMs;
	cudaGetDevice(&deviceId);
    // cudaSetDevice( rank );  
    // cudaSetDevice( 0 );                                                                 
    // cudaError_t ret1 = cudaDeviceEnablePeerAccess ( 1, 0);                                          
    // cudaSetDevice( 1 );                                                                 
    // cudaError_t ret2 = cudaDeviceEnablePeerAccess (0, 0);
	cudaDeviceGetAttribute(&numberOfSMs, cudaDevAttrMultiProcessorCount, deviceId);
    // CHECK_CUDA_ERROR(cudaMemPrefetchAsync(v, bytes, deviceId));
    // CHECK_CUDA_ERROR(cudaMemPrefetchAsync(f, bytes, deviceId));
    // CHECK_CUDA_ERROR(cudaMemPrefetchAsync(vp, bytes, deviceId));
    CHECK_CUDA_ERROR(cudaDeviceSynchronize());
    int threadsPerBlock = 1024;
    int numberOfBlocks = ((nx*ny) + threadsPerBlock - 1) / threadsPerBlock; 



    // cudaSetDevice( rank );  
	// cudaGetDevice(&deviceId);
    // Get my coordinates in the new communicator
    int dims[2], periods[2], coords[2];
    MPI_Cart_get(comm, 2, dims, periods, coords);

    int left, right, top, bot;
    MPI_Cart_shift(comm, 0, 1, &left, &right);
    MPI_Cart_shift(comm, 1, 1, &top, &bot);
    int isLeftBorderTile = coords[0]==0;
    int isRightBorderTile = coords[0]==dims[0]-1;
    int isTopBorderTile = coords[1]==0;
    int isBottomBorderTile = coords[1]==dims[1]-1;

    int n = 0;
    double e = 2. * eps;
    
    MPI_Datatype vectorTypeVertical;
    MPI_Type_vector(NYL, 1, NXL + 2, MPI_DOUBLE, &vectorTypeVertical);
    MPI_Datatype contiguousTypeHorizontal;
    MPI_Type_contiguous(NXL, MPI_DOUBLE, &contiguousTypeHorizontal);
    MPI_Datatype contiguousTypeVertical;
    MPI_Type_contiguous(NYL, MPI_DOUBLE, &contiguousTypeVertical);
    MPI_Type_commit(&vectorTypeVertical);
    MPI_Type_commit(&contiguousTypeHorizontal);
    MPI_Type_commit(&contiguousTypeVertical);
    int n_count = 0;
    while ((e > eps) && (n < nmax))
    {
        jacobi<<<numberOfBlocks,threadsPerBlock>>>(v,vp,f,NXL+2,NYL+2); //TODO change size
        CHECK_LAST_CUDA_ERROR();
        jacobi_fillRightLeftBounds<<<numberOfBlocks,threadsPerBlock>>>(v,v_left,v_right,NXL+2,NYL+2);
        CHECK_LAST_CUDA_ERROR();
        // jacobi_bounds<<<numberOfBlocks,threadsPerBlock>>>(vp,NXL,NYL); //TODO change size
        // CHECK_LAST_CUDA_ERROR();
        
        // jacobi<<<numberOfBlocks,threadsPerBlock>>>(vp,v,f,NXL,NYL); //TODO change size
        // CHECK_LAST_CUDA_ERROR();
        // jacobi_bounds<<<numberOfBlocks,threadsPerBlock>>>(v,NXL,NYL); //TODO change size
        // CHECK_LAST_CUDA_ERROR();
        
        // if(n_count >= N_SKIP){
            // // // double sum = thrust::reduce(&v[0], &v[nx * ny],(double) 0.0, thrust::plus<double>());
            // // // printf("CUDA_Sum %f \n", w);
            // // printf("CUDA_Sum %f \n", e);
            // w /= (nx * ny);
            // e /= w;
            // printf("CUDA_Sum %f \n", e);
            // n_count =0;
            // CHECK_CUDA_ERROR(cudaDeviceSynchronize());
            // CHECK_CUDA_ERROR(cudaMemPrefetchAsync(vp, bytes, -1));
            
            // e = calcEps(v,vp,nx,ny);
            // printf("Sum %f \n", e);
            // CHECK_CUDA_ERROR(cudaMemPrefetchAsync(vp, bytes, deviceId));
        // }
        // n_count ++;
        // n++;



        // e = 0.0;
        // double w = 0.0;

        // for (int iy = 1; iy < (NYL+1); iy++) //! changed here
        // {
        //     for( int ix = 1; ix < (NXL+1); ix++ )
        //     {
        //         double d;

        //         vp[iy*(NXL+2)+ix] = -0.25 * (f[iy*(NXL+2)+ix] - (v[(NXL+2)*iy+ix+1] + v[(NXL+2)*iy+ix-1] + v[(NXL+2)*(iy+1) + ix  ] + v[(NXL+2)*(iy-1) + ix  ]));

        //         d = fabs(vp[iy*(NXL+2)+ix] - v[iy*(NXL+2)+ix]);
        //         e = (d > e) ? d : e;
        //         w += fabs(vp[(NXL+2)*iy+ix]);
        //     }
        // }
        // TODO can also be done non-blocking but yields worse performance??
        // send e
        // MPI_Request requests[2];
        // MPI_Iallreduce(MPI_IN_PLACE, &e, 1, MPI_DOUBLE, MPI_MAX, MPI_COMM_WORLD,&requests[0]);
        // Update v and compute error as well as error weight factor


        double* v_tmp = v;
        v = vp;
        vp = v_tmp;   

        if(n_count >= N_SKIP){
            calcDs<<<numberOfBlocks,threadsPerBlock>>>(v,vp,ds,NXL,NYL);
            e = thrust::transform_reduce(&ds_thrust[0], &ds_thrust[NXL * NYL],absolute_value<double>(), (double) 0.0, thrust::maximum<double>());
            double w = thrust::transform_reduce(&v_thrust[0], &v_thrust[NXL * NYL],absolute_value<double>(), (double) 0.0, thrust::plus<double>());
            
            // CHECK_CUDA_ERROR(cudaDeviceSynchronize());         
            MPI_Allreduce(MPI_IN_PLACE, &w, 1, MPI_DOUBLE, MPI_SUM,
                MPI_COMM_WORLD);
            MPI_Allreduce(MPI_IN_PLACE, &e, 1, MPI_DOUBLE, MPI_MAX,
                    MPI_COMM_WORLD);
            // MPI_Iallreduce(MPI_IN_PLACE, &w, 1, MPI_DOUBLE, MPI_SUM, MPI_COMM_WORLD,&requests[1]);

            // MPI_Waitall(2, requests, MPI_STATUSES_IGNORE);



            w /= (nx * ny);
            e /= w;
            n_count = 0;
        }
        n_count ++;
        n++;
            int counts[4] = {1, 1, 1, 1};

            /*
                share the perimeter of the inner matrix with neighbors
                    We can avoid to share the corners because we don't need them for the computation of the inner matrix
                _               _
                | - -  - - - -  - | 
                | - tl t t t tr - |
                | - l  - - - r  - |
                | - l  - - - r  - |
                | - bl b b b br - |
                |_- -  - - - -  -_|

                indices:
                    0: center-left neighbor communication
                    1: center-right neighbor communication
                    2: center-top neighbor communication
                    3: center-bottom neighbor communication
            */
            MPI_Datatype bufferTypes[4];
            bufferTypes[0] = vectorTypeVertical;     // left
            bufferTypes[1] = vectorTypeVertical;     // right
            bufferTypes[2] = contiguousTypeHorizontal; // top
            bufferTypes[3] = contiguousTypeHorizontal; // bottom
            MPI_Aint sdispls[4];
            /*
                put in sdispls where the boundaries that you want to share of the center matrix start


                |-----------------| = NXL + 2
                |-----------| = NXL
                _               _
                | - -  - - - -  - | 
                | - tl t t t tr - |
                | - l  - - - r  - |
                | - l  - - - r  - |
                | - bl b b b br - |
                |_- -  - - - -  -_|

            */
            //For example the left boundary vector of the inner matrix will be sent to the left neighbor (index 0) and it starts at tl
            sdispls[0] = ((NXL + 2) + 1) * sizeof(double);
            sdispls[1] = ((NXL + 2) + NXL) * sizeof(double);
            sdispls[2] = ((NXL + 2) + 1) * sizeof(double);
            sdispls[3] = ((NYL) * (NXL + 2) + 1) * sizeof(double);
            MPI_Aint rdispls[4];
            /*
                put in rdispls[i] the index you should start writing the boundary that you receive from communication i

                I've drawn the neighbors around the receiving matrix 
                    The matrix in the middle also share its perimeter but here we focus on the receiving part
                
                    | -  bl b b b br -  |
                    |_-  -  - - - -  - _|
                    _   _                 _    _
                -  - | | -  bl b b b br -  |  | - - 
                tr - | | tr -  - - - -  tl |  | - tl
                r  - | | r  -  - - - -  l  |  | - l 
                r  - | | r  -  - - - -  l  |  | - l 
                br - | | br -  - - - -  bl |  | - bl
                -  -_| |_-  tl t t t tr - _|  |_- - 
                        _                 _ 
                    | -  -  - - - -  -  |
                    | -  tl t t t tr -  |
            */
            //Example: from the left neighbor (i=0) it receives r vector, put it in the first column
            rdispls[0] = (NXL + 2) * sizeof(double);
            rdispls[1] = ((NXL + 2) + (NXL + 1)) * sizeof(double);
            rdispls[2] = 1 * sizeof(double);
            rdispls[3] = ((NYL + 1) * (NXL + 2) + 1) * sizeof(double);



            MPI_Request requests[8] = {MPI_REQUEST_NULL,MPI_REQUEST_NULL,MPI_REQUEST_NULL,MPI_REQUEST_NULL,MPI_REQUEST_NULL,MPI_REQUEST_NULL,MPI_REQUEST_NULL,MPI_REQUEST_NULL};
            sdispls[0] = ((NXL + 2) + 1) ;
            sdispls[1] = ((NXL + 2) + NXL) ;
            sdispls[2] = ((NXL + 2) + 1) ;
            sdispls[3] = ((NYL) * (NXL + 2) + 1);
            rdispls[0] = (NXL + 2) ;
            rdispls[1] = ((NXL + 2) + (NXL + 1)) ;
            rdispls[2] = 1 ;
            rdispls[3] = ((NYL + 1) * (NXL + 2) + 1);
            // CHECK_CUDA_ERROR(cudaDeviceSynchronize()); 
            // MPI_Isend(v + sdispls[0], 1, bufferTypes[0], left, 0, comm, &(requests[0]));
            // MPI_Isend(v + sdispls[1], 1, bufferTypes[1], right, 0, comm, &(requests[1]));
            MPI_Isend(v_left, 1, contiguousTypeVertical, left, 0, comm, &(requests[0]));
            MPI_Isend(v_right, 1, contiguousTypeVertical, right, 0, comm, &(requests[1]));
            // MPI_Sendrecv_replace(v_left, 1, contiguousTypeHorizontal, left, 0,right,0, comm , MPI_STATUS_IGNORE);
            // MPI_Sendrecv_replace(v_right, 1, contiguousTypeHorizontal, right, 0,left,0, comm,MPI_STATUS_IGNORE);
            MPI_Isend(v + sdispls[2], 1, bufferTypes[2], top, 0, comm, &(requests[2]));
            MPI_Isend(v + sdispls[3], 1, bufferTypes[3], bot, 0, comm, &(requests[3]));
            // MPI_Irecv(v + rdispls[0], 1, bufferTypes[0], left, 0, comm, &(requests[4]));
            // MPI_Irecv(v + rdispls[1], 1, bufferTypes[1], right, 0, comm, &(requests[5]));
            MPI_Irecv(v_right_recv, 1, contiguousTypeVertical, right, 0, comm, &(requests[4]));
            MPI_Irecv(v_left_recv, 1, contiguousTypeVertical, left, 0, comm, &(requests[5]));
            MPI_Irecv(v + rdispls[3], 1, bufferTypes[2], top, 0, comm, &(requests[6]));
            MPI_Irecv(v + rdispls[2], 1, bufferTypes[3], bot, 0, comm, &(requests[7]));
            // # cudaMemcpyPeerAsync
            MPI_Waitall(8, requests, MPI_STATUSES_IGNORE);
            // v_tmp = v_left;
            // v_left = v_left_recv;
            // v_left = v_tmp;
            // v_tmp = v_right;
            // v_right = v_right_recv;
            // v_right = v_tmp;
            jacobi_rewriteRightLeftBounds<<<numberOfBlocks,threadsPerBlock>>>(v,v_left_recv,v_right_recv,NXL+2,NYL+2);
            CHECK_LAST_CUDA_ERROR();


            // MPI_Neighbor_alltoallw(
            //     v, counts, sdispls, bufferTypes,
            //     v, counts, rdispls, bufferTypes, comm);
                


            // // Boundary conditions for w
            // if ( isLeftBorderTile ) {
            //     for (int iy = 1; iy < (NYL+1); iy++) 
            //     {
            //         w += fabs(v[(NXL+2)*iy+0]);
            //     }
            // }
            // if ( isRightBorderTile ) {
            //     for (int iy = 1; iy < (NYL+1); iy++) 
            //     {
            //         w += fabs(v[(NXL+2)*iy+((NXL+2)-1)]);
            //     }
            // }
            // if ( isTopBorderTile ) {
            //     for (int ix = 1; ix < (NXL+1); ix++) 
            //     {
            //         w += fabs(v[(NXL+2)*0+ix]);
            //     }
            // }
            // if ( isBottomBorderTile ) {
            //     for (int ix = 1; ix < (NXL+1); ix++) 
            //     {
            //         w += fabs(v[(NXL+2)*((NYL+2)-1)+ix]);
            //     }
            // }


    }
    CHECK_CUDA_ERROR(cudaDeviceSynchronize()); 
    CHECK_CUDA_ERROR(cudaMemcpy(v_CPU, v, bytes, cudaMemcpyDeviceToHost));
    CHECK_CUDA_ERROR(cudaMemcpy(vp_CPU, vp, bytes, cudaMemcpyDeviceToHost));
    CHECK_CUDA_ERROR(cudaMemcpy(f_CPU, f, bytes, cudaMemcpyDeviceToHost));

    // return 1;
    MPI_Type_free(&vectorTypeVertical);
    MPI_Type_free(&contiguousTypeHorizontal);

    if(rank == 0)
        if (e < eps)
            printf("Converged after %d iterations (nx=%d, ny=%d, e=%.2e)\n", n, nx, ny, e);
        else
            printf("ERROR: Failed to converge\n");

    return (e < eps ? 0 : 1);
}