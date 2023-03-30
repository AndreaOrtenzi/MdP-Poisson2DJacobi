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

int solver_transposed_mpi(double *v,double *vp, double *f, int nx, int ny, double eps, int nmax, MPI_Comm comm, int NXL, int NYL )
{


    int rank;
    MPI_Comm_rank(comm, &rank);
    // Get my coordinates in the new communicator
    int dims[2], periods[2], coords[2];
    MPI_Cart_get(comm, 2, dims, periods, coords);

    int left, right, top, bot;
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


    while ((e > eps) && (n < nmax))
    {
        e = 0.0;
        double w = 0.0;

        for (int iy = 1; iy < (NYL+1); iy++) //! changed here
        {
            for( int ix = 1; ix < (NXL+1); ix++ )
            {
                double d;

                vp[iy*(NXL+2)+ix] = -0.25 * (f[iy*(NXL+2)+ix] - (v[(NXL+2)*iy+ix+1] + v[(NXL+2)*iy+ix-1] + v[(NXL+2)*(iy+1) + ix  ] + v[(NXL+2)*(iy-1) + ix  ]));

                d = fabs(vp[iy*(NXL+2)+ix] - v[iy*(NXL+2)+ix]);
                e = (d > e) ? d : e;
                w += fabs(vp[(NXL+2)*iy+ix]);
            }
        }
        // TODO can also be done non-blocking but yields worse performance??
        // send e
        // MPI_Request requests[2];
        // MPI_Iallreduce(MPI_IN_PLACE, &e, 1, MPI_DOUBLE, MPI_MAX, MPI_COMM_WORLD,&requests[0]);
        // Update v and compute error as well as error weight factor

        double* v_tmp = v;
        v = vp;
        vp = v_tmp;        

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
        MPI_Neighbor_alltoallw(
            v, counts, sdispls, bufferTypes,
            v, counts, rdispls, bufferTypes, comm);



        // Boundary conditions for w
        if ( isLeftBorderTile ) {
            for (int iy = 1; iy < (NYL+1); iy++) 
            {
                w += fabs(v[(NXL+2)*iy+0]);
            }
        }
        if ( isRightBorderTile ) {
            for (int iy = 1; iy < (NYL+1); iy++) 
            {
                w += fabs(v[(NXL+2)*iy+((NXL+2)-1)]);
            }
        }
        if ( isTopBorderTile ) {
            for (int ix = 1; ix < (NXL+1); ix++) 
            {
                w += fabs(v[(NXL+2)*0+ix]);
            }
        }
        if ( isBottomBorderTile ) {
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