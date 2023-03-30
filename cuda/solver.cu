/*
 * Copyright (c) 2021, Dirk Pleiter, KTH
 *
 * This source code is in parts based on code from Jiri Kraus (NVIDIA) and
 * Andreas Herten (Forschungszentrum Juelich)
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
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND Any
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR Any DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON Any THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN Any WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
 #ifndef NX
 #define NX 128
 #endif
 #ifndef NY
 #define NY 128
 #endif
 #define NMAX 2000000
 #define EPS 1e-5
 #define N_SKIP 100
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <math.h>
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <thrust/transform_reduce.h>
#include <thrust/functional.h>
#include "helper.h"
/**
* @brief https://leimao.github.io/blog/CUDA-Shared-Memory-Capacity/
* 
*/
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
void jacobi_stride(double *v, double *vp, double *f, int X, int Y){
	int index = threadIdx.x + blockIdx.x * blockDim.x;
	int stride = blockDim.x * gridDim.x;
	// int x = index % X;
	// int y = index / X;
	for(size_t i = index; i < X*Y; i += stride){
		int x = i % X;
		int y = i / X;
		if(x == 0 || y == 0 || y >= Y-1 || x >= X-1) continue;
		vp[y*X+x] = -0.25 * (f[y*X+x] - (v[X*y+x+1] + v[X*y+x-1] + v[X*(y+1) + x  ] + v[X*(y-1) + x  ]));
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
// __device__ double w_answer;

double calcEps(double *v, double *vp, size_t nx, size_t ny){
    double e = 0.0;
    double w = 0.0;
    for( int ix = 1; ix < (nx-1); ix++ )
    {
        for (int iy = 1; iy < (ny-1); iy++)
        {
            double d;

            d = fabs(vp[nx*iy+ix] - v[nx*iy+ix]);
            e = (d > e) ? d : e;
            w += fabs(v[nx*iy+ix]);
        }
    }

    for (int ix = 1; ix < (nx-1); ix++)
    {
        w += fabs(v[nx*0+ix]) + fabs(v[nx*(ny-1)+ix]);
    }

    for (int iy = 1; iy < (ny-1); iy++)
    {
        w += fabs(v[nx*iy+0]) + fabs(v[nx*iy+(nx-1)]);
    }
    // printf("Sum %f \n", w);
    w /= (nx * ny);
    e /= w;
    return e;
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

int solver(double *v, double *f, int nx, int ny, double eps, int nmax)
{
    int n = 0;
    double e = 2. * eps;
    double *vp, *ds;
    size_t bytes = nx * ny * sizeof(double);
	cudaMallocManaged(&vp, bytes);
    CHECK_CUDA_ERROR(cudaMalloc(&ds, bytes));
    thrust::device_ptr<double> ds_thrust(ds);
    thrust::device_ptr<double> v_thrust(v);

    int deviceId; // TODO repetition. see main()
	int numberOfSMs;
	cudaGetDevice(&deviceId);
	cudaDeviceGetAttribute(&numberOfSMs, cudaDevAttrMultiProcessorCount, deviceId);
    CHECK_CUDA_ERROR(cudaMemPrefetchAsync(v, bytes, deviceId));
    CHECK_CUDA_ERROR(cudaMemPrefetchAsync(f, bytes, deviceId));
    CHECK_CUDA_ERROR(cudaMemPrefetchAsync(vp, bytes, deviceId));
    CHECK_CUDA_ERROR(cudaDeviceSynchronize());
    int threadsPerBlock = 1024;
    int numberOfBlocks = ((nx*ny) + threadsPerBlock - 1) / threadsPerBlock; 
    // double e = eps*2;
    double n_count = 0;
    while (( e > eps) && (n < nmax))
    {
        // printf("e: %f, eps: %f \n", e,eps);
        jacobi<<<numberOfBlocks,threadsPerBlock>>>(v,vp,f,nx,ny); //TODO change size
        CHECK_LAST_CUDA_ERROR();
        jacobi_bounds<<<numberOfBlocks,threadsPerBlock>>>(vp,nx,ny); //TODO change size
        CHECK_LAST_CUDA_ERROR();
        
        // CHECK_CUDA_ERROR(cudaDeviceSynchronize());
        // e = calcEps(v,vp,nx,ny);

        jacobi<<<numberOfBlocks,threadsPerBlock>>>(vp,v,f,nx,ny); //TODO change size
        CHECK_LAST_CUDA_ERROR();
        jacobi_bounds<<<numberOfBlocks,threadsPerBlock>>>(v,nx,ny); //TODO change size
        CHECK_LAST_CUDA_ERROR();
        
        if(n_count >= N_SKIP){
            calcDs<<<numberOfBlocks,threadsPerBlock>>>(v,vp,ds,nx,ny);
            e = thrust::transform_reduce(&ds_thrust[0], &ds_thrust[nx * ny],absolute_value<double>(), (double) 0.0, thrust::maximum<double>());
            double w = thrust::transform_reduce(&v_thrust[0], &v_thrust[nx * ny],absolute_value<double>(), (double) 0.0, thrust::plus<double>());
            // // // double sum = thrust::reduce(&v[0], &v[nx * ny],(double) 0.0, thrust::plus<double>());
            // // // printf("CUDA_Sum %f \n", w);
            // // printf("CUDA_Sum %f \n", e);
            w /= (nx * ny);
            e /= w;
            // printf("CUDA_Sum %f \n", e);
            n_count =0;
            // CHECK_CUDA_ERROR(cudaDeviceSynchronize());
            // CHECK_CUDA_ERROR(cudaMemPrefetchAsync(vp, bytes, -1));
            
            // e = calcEps(v,vp,nx,ny);
            // printf("Sum %f \n", e);
            // CHECK_CUDA_ERROR(cudaMemPrefetchAsync(vp, bytes, deviceId));
        }
        n_count ++;
        n++;
    }
    CHECK_CUDA_ERROR(cudaDeviceSynchronize());
    e = calcEps(v,vp,nx,ny);

	cudaFree(vp);

    if (e < eps)
        printf("Converged after %d iterations (nx=%d, ny=%d, e=%.2e)\n", n, nx, ny, e);
    else
        printf("ERROR: Failed to converge\n");

    return (e < eps ? 0 : 1);
}


// TODO use CUBLAS "gesvdj" as reference
int main()
{
    // printf("OMP-Threads: %d\n", omp_get_max_threads());
    double *v;
    double *f;
    size_t bytes = NX * NY * sizeof(double);
	cudaMallocManaged(&v, bytes);
	cudaMallocManaged(&f, bytes);

    // Allocate memory
    // v = (double *) malloc(NX * NY * sizeof(double));
    // f = (double *) malloc(NX * NY * sizeof(double));

    // Initialise input
    for (int iy = 0; iy < NY; iy++)
        for (int ix = 0; ix < NX; ix++)
        {
            v[NX*iy+ix] = 0.0;

            const double x = 2.0 * ix / (NX - 1.0) - 1.0;
            const double y = 2.0 * iy / (NY - 1.0) - 1.0;
            f[NX*iy+ix] = sin(x + y);
        }

	int deviceId;
	int numberOfSMs;
	cudaGetDevice(&deviceId);
	cudaDeviceGetAttribute(&numberOfSMs, cudaDevAttrMultiProcessorCount, deviceId);
    CHECK_CUDA_ERROR(cudaMemPrefetchAsync(v, bytes, deviceId));
    CHECK_CUDA_ERROR(cudaMemPrefetchAsync(f, bytes, deviceId));
    CHECK_CUDA_ERROR(cudaDeviceSynchronize());

    cudaEvent_t start, stop;     		// using cuda events to measure time
	float elapsed_time_ms; 
    cudaEventCreate(&start);     		// events to measure start time
	cudaEventCreate(&stop);  	


    // // Call solver
    printf("Solver:\n");
	cudaEventRecord(start, 0);
    solver(v, f, NX, NY, EPS, NMAX);
    CHECK_LAST_CUDA_ERROR();
	cudaEventRecord(stop, 0);     	// instrument code to measue end time
	cudaEventSynchronize(stop);
	cudaEventElapsedTime(&elapsed_time_ms, start, stop );
    printf("Took %f sec\n", elapsed_time_ms/1000);
    compareToFile(v,NX,NY,NMAX,EPS);


    
    // Clean-up
    cudaFree(v);
    cudaFree(f);

    return 0;
}
