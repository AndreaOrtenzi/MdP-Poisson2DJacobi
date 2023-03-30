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

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <mpi.h>
#include <immintrin.h>

int solver_transposed_mpi_avx(double *v, double * vp, double *f, int nx, int ny, double eps, int nmax, MPI_Comm comm, int NXL, int NYL )
{


    int rank;
    MPI_Comm_rank(comm, &rank);
    // Get my coordinates in the new communicator
    int dims[2], periods[2], coords[2];
    MPI_Cart_get(comm, 2, dims, periods, coords);

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
    MPI_Type_commit(&vectorTypeVertical);
    MPI_Type_commit(&contiguousTypeHorizontal);




    int unroll = 4;
    int restX = (nx-1)-((nx-1)-unroll+1);
    __m256d invfour = _mm256_set1_pd(-0.25);

    while ((e > eps) && (n < nmax))
    {
        e = 0.0;
        double w = 0.0;

        
        __m256d eVec = _mm256_setzero_pd();
        __m256d wVec = _mm256_setzero_pd();

        for (int iy = 1; iy < (NYL+1); iy++) //! changed here
        {
            int ix = 1;
            for( ; ix < (NXL+1)-unroll+1; ix+=unroll )
            {

                __m256d vecf = _mm256_loadu_pd(&f[iy*(NXL+2)+ix]);
                __m256d vecTop = _mm256_loadu_pd(&v[(NXL+2)*(iy-1) + ix ]);
                __m256d vecBot = _mm256_loadu_pd(&v[(NXL+2)*(iy+1) + ix ]);
                __m256d vecLeft = _mm256_loadu_pd(&v[(NXL+2)*iy+ix-1]);
                __m256d vecRight = _mm256_loadu_pd(&v[(NXL+2)*iy+ix+1]);
                __m256d tmp1 = _mm256_add_pd(vecTop, vecBot);
                __m256d tmp2 = _mm256_add_pd(vecLeft, vecRight);
                __m256d tmp3 = _mm256_add_pd(tmp1, tmp2);
                __m256d tmp4 = _mm256_sub_pd(vecf, tmp3);
                tmp4 = _mm256_mul_pd(invfour, tmp4);
                _mm256_storeu_pd(&vp[iy*(NXL+2)+ix], tmp4);

                __m256d vecv = _mm256_loadu_pd(&v[iy*(NXL+2)+ix]);
                __m256d d = _mm256_sub_pd(tmp4, vecv);

                d = _mm256_andnot_pd(_mm256_set1_pd(-0.0),d); // <-- Computes absolute value
                eVec = _mm256_max_pd(eVec,d);
                wVec =_mm256_add_pd(wVec, _mm256_andnot_pd(_mm256_set1_pd(-0.0),tmp4));
            }
            for(;  ix < (NXL+1); ix++ )
            {
                double d;
                vp[iy*(NXL+2)+ix] = -0.25 * (f[iy*(NXL+2)+ix] - (v[(NXL+2)*iy+ix+1] + v[(NXL+2)*iy+ix-1] + v[(NXL+2)*(iy+1) + ix  ] + v[(NXL+2)*(iy-1) + ix  ]));

                d = fabs(vp[iy*(NXL+2)+ix] - v[iy*(NXL+2)+ix]);
                e = (d > e) ? d : e;
                w += fabs(vp[(NXL+2)*iy+ix]);
            }
        }
        e = (eVec[0] > e) ? eVec[0]: e;
        e = (eVec[1] > e) ? eVec[1]: e;
        e = (eVec[2] > e) ? eVec[2]: e;
        e = (eVec[3] > e) ? eVec[3]: e;

        w += wVec[0];
        w += wVec[1];
        w += wVec[2];
        w += wVec[3];
        // TODO can also be done non-blocking but yields worse performance??
        // send e
        // MPI_Request requests[2];
        // MPI_Iallreduce(MPI_IN_PLACE, &e, 1, MPI_DOUBLE, MPI_MAX, MPI_COMM_WORLD,&requests[0]);
        // Update v and compute error as well as error weight factor

        double* v_tmp = v;
        v = vp;
        vp = v_tmp;        

        int counts[4] = {1, 1, 1, 1};
        
        MPI_Datatype bufferTypes[4];
        bufferTypes[0] = vectorTypeVertical;     // left
        bufferTypes[1] = vectorTypeVertical;     // right
        bufferTypes[2] = contiguousTypeHorizontal; // top
        bufferTypes[3] = contiguousTypeHorizontal; // bottom
        MPI_Aint sdispls[4];
        sdispls[0] = ((NXL + 2) + 1) * sizeof(double);
        sdispls[1] = ((NXL + 2) + NXL) * sizeof(double);
        sdispls[2] = ((NXL + 2) + 1) * sizeof(double);
        sdispls[3] = ((NYL) * (NXL + 2) + 1) * sizeof(double);
        MPI_Aint rdispls[4];
        rdispls[0] = (NXL + 2) * sizeof(double);
        rdispls[1] = ((NXL + 2) + (NXL + 1)) * sizeof(double);
        rdispls[2] = 1 * sizeof(double);
        rdispls[3] = ((NYL + 1) * (NXL + 2) + 1) * sizeof(double);
        MPI_Neighbor_alltoallw(
            v, counts, sdispls, bufferTypes,
            v, counts, rdispls, bufferTypes, comm);


        // Boundary conditions for w
        if ( coords[0] == 0 ) { // left
            for (int iy = 1; iy < (NYL+1); iy++) 
            {
                w += fabs(v[(NXL+2)*iy+0]);
            }
        }
        if ( coords[0] == (dims[0]-1) ) { // right
            for (int iy = 1; iy < (NYL+1); iy++) 
            {
                w += fabs(v[(NXL+2)*iy+((NXL+2)-1)]);
            }
        }
        if ( coords[1] == 0 ) { // top
            for (int ix = 1; ix < (NXL+1); ix++) 
            {
                w += fabs(v[(NXL+2)*0+ix]);
            }
        }
        if ( coords[1] == (dims[1]-1) ) { // bot
            for (int ix = 1; ix < (NXL+1); ix++) 
            {
                w += fabs(v[(NXL+2)*((NYL+2)-1)+ix]);
            }
        }

        MPI_Allreduce(MPI_IN_PLACE, &w, 1, MPI_DOUBLE, MPI_SUM,
                MPI_COMM_WORLD);
        MPI_Allreduce(MPI_IN_PLACE, &e, 1, MPI_DOUBLE, MPI_MAX,
                MPI_COMM_WORLD);
        // MPI_Iallreduce(MPI_IN_PLACE, &w, 1, MPI_DOUBLE, MPI_SUM, MPI_COMM_WORLD,&requests[1]);

        // MPI_Waitall(2, requests, MPI_STATUSES_IGNORE);



        w /= (nx * ny);
        e /= w;
        n++;
    }

    MPI_Type_free(&vectorTypeVertical);
    MPI_Type_free(&contiguousTypeHorizontal);
    
    if(rank == 0)
        if (e < eps)
            printf("Converged after %d iterations (nx=%d, ny=%d, e=%.2e)\n", n, nx, ny, e);
        else
            printf("ERROR: Failed to converge\n");

    return (e < eps ? 0 : 1);
}