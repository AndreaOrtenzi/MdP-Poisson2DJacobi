#ifndef __CHECKER_H_
#define __CHECKER_H_
#include <stdio.h>
#include <stdbool.h>
#include <time.h>
#include <math.h>
#include <stdlib.h>
#include <mpi.h>

double getTime()
{
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (double)ts.tv_sec + (double)ts.tv_nsec * 1.e-9;
}


int getFilename(char *filename, size_t maxFileLen, size_t nx, size_t ny, size_t nmax, double eps){
   return snprintf(filename, maxFileLen, "%zu_%zu_%zu_%f.ref", nx, ny, nmax, eps);
}

int checkReferenceFileExists(size_t nx, size_t ny, size_t nmax, double eps){
    size_t maxFileLen = 150; 
    char filename[maxFileLen];
    getFilename(filename,maxFileLen,nx,ny,nmax,eps);
    FILE *file;
    if((file = fopen(filename,"r"))!=NULL)
    {
        // file exists
        fclose(file);
        return 1;
    }
    else
    {
        return 0;
    }

}

void writeToFile(double* arr, size_t nx, size_t ny, size_t nmax, double eps){
    size_t maxFileLen = 150; 
    char filename[maxFileLen];
    getFilename(filename,maxFileLen,nx,ny,nmax,eps);

    FILE *fh = fopen(filename, "w");
    fwrite(arr, sizeof(double), nx*ny, fh);

    fclose(fh);
}

bool approximatelyEqual(float a, float b, float epsilon)
{
    float smooth = 0.0001f;
    if(fabs(a-b)<smooth) return true;
    return fabs(a - b)<= ( (fabs(a) < fabs(b) ? fabs(b) : fabs(a)) * epsilon);
    // return false;
}

/**
 * return -1 on error. 0 if both files are identical
*/
int compareToFile(double* arr, size_t nx, size_t ny, size_t nmax, double eps){
    double approxEps = 0.001;
    size_t maxFileLen = 150; 
    char filename[maxFileLen];
    getFilename(filename,maxFileLen,nx,ny,nmax,eps);
    FILE *fh = fopen(filename, "r");
    if(!fh) {printf("Error locating file: %s\n",filename); return -1;}
    double *tmp = (double *) malloc(nx * ny * sizeof(double));
    if(!tmp) {perror("compareToFile: malloc failed");return -1;}
    fread( tmp, sizeof(double), nx * ny, fh ) ;
    for(size_t y = 0; y<ny-0; y++){
        for(size_t x = 0; x<nx-0; x++){
            if(!approximatelyEqual(arr[y * nx +x],tmp[y * nx +x],approxEps)){
                printf("Not equal! idx: (x,y)(%zu, %zu), was: %f, expected: %f\n", x,y,arr[y * nx +x],tmp[y * nx +x]);
                // return 1;
            }
        }   
    }
    printf("Correct\n");
    fclose(fh);
    free(tmp);
    return 0;
}

int compareFileToFile(char* filename, size_t nx, size_t ny, size_t nmax, double eps){
    double approxEps = 0.001;
    size_t maxFileLen = 150; 
    char filenameRef[maxFileLen];
    getFilename(filenameRef,maxFileLen,nx,ny,nmax,eps);
    printf("Comparing: %s to %s \n",filename,filenameRef); 
    FILE *fhRef = fopen(filenameRef, "r");
    if(!fhRef) {printf("Error locating file: %s\n",filenameRef); return -1;}
    FILE *fh = fopen(filename, "r");
    if(!fh) {printf("Error locating file: %s\n",filename); return -1;}
    double *tmpRef = (double *) malloc(nx * ny * sizeof(double));
    if(!tmpRef) {perror("compareToFile: malloc failed");return -1;}
    double *tmp = (double *) malloc( nx * ny * sizeof(double));
    if(!tmp) {perror("compareToFile: malloc failed");return -1;}
    fread( tmpRef, sizeof(double), nx * ny, fhRef ) ;
    fread( tmp, sizeof(double), nx * ny, fh ) ;
    for(size_t y = 0; y<ny; y++){
        for(size_t x = 0; x<nx; x++){
            if(!approximatelyEqual(tmp[y * nx + x],tmpRef[y * nx +x],approxEps)){
                printf("Not equal! idx: (x,y)(%zu, %zu), was: %f, expected: %f\n", x,y,tmp[y * nx +x],tmpRef[y * nx +x]);
                return 1;
            }
        }   
    }
    printf("Correct\n");
    fclose(fhRef);
    fclose(fh);
    free(tmpRef);
    free(tmp);
    return 0;
}


int compareFileWoBoundsToFile(char* filename, size_t nx, size_t ny, size_t nmax, double eps){
    double approxEps = 0.001;
    size_t maxFileLen = 150; 
    char filenameRef[maxFileLen];
    getFilename(filenameRef,maxFileLen,nx,ny,nmax,eps);
    FILE *fhRef = fopen(filenameRef, "r");
    if(!fhRef) {printf("Error locating file: %s\n",filenameRef); return -1;}
    FILE *fh = fopen(filename, "r");
    if(!fh) {printf("Error locating file: %s\n",filename); return -1;}
    double *tmpRef = (double *) malloc(nx * ny * sizeof(double));
    if(!tmpRef) {perror("compareToFile: malloc failed");return -1;}
    double *tmp = (double *) malloc( (nx-2) * (ny-2) * sizeof(double));
    if(!tmp) {perror("compareToFile: malloc failed");return -1;}
    fread( tmpRef, sizeof(double), nx * ny, fhRef ) ;
    fread( tmp, sizeof(double), (nx-2) * (ny-2), fh ) ;
    for(size_t y = 1; y<ny-1; y++){
        for(size_t x = 1; x<nx-1; x++){
            if(!approximatelyEqual(tmp[(y-1) * (nx-2) + x-1],tmpRef[y * nx +x],approxEps)){
                printf("Not equal! idx: (x,y)(%zu, %zu), was: %f, expected: %f\n", x,y,tmp[(y-1) * (nx-2) +x-1],tmpRef[y * nx +x]);
                return 1;
            }
        }   
    }
    printf("Correct\n");
    fclose(fhRef);
    fclose(fh);
    free(tmpRef);
    free(tmp);
    return 0;
}

int compareArrays(double* A,double* B, size_t size){
    double approxEps = 0.001;
    for(size_t i = 0; i<size; i++){
        if(!approximatelyEqual(A[i],B[i],approxEps)){
            printf("Not equal! idx: %zu, was: %f, expected: %f\n", i,A[i],B[i]);
            return 1;
        }
    }
    return 0;
}

void writeGnuPlotFile(double *A, size_t nx, size_t ny, size_t startX, size_t startY,size_t nxL, size_t nyL , int MPIrank, int MPIsize, MPI_Comm comm ){

    // printf("Rank %d: n(%d, %d) start(%d, %d) nl(%d, %d)",MPIrank,nx,ny,startX,startY,nxL,nyL);
    double dx = 1.0/nx;
    double dy = 1.0/ny;

    int xLStart = 1;
    int yLStart = 1;
    // if(startX)xLStart=1;
    // if(startY)yLStart=1;
    int xLEnd = nxL-1;
    int yLEnd = nyL-1;
    // if(startX+nxL!=nx)nxL-=1;
    // if(startY+nyL!=ny)nyL-=1;
    for (int i = 0; i < MPIsize; i++)
    {
        if (i == MPIrank)
        {
            FILE *fp;
            if(i == 0){
                fp = fopen("result.dat", "w");
            }else{
                fp = fopen("result.dat", "a");
            }


            if (fp== NULL) {
                printf("Error!\n");
                exit(EXIT_FAILURE);
            }

            for( int yL=yLStart; yL<yLEnd; yL++ ) {
                double y = (double)(startY + yL-0.5) * dy;
                for( int xL=xLStart; xL<xLEnd; xL++ ) {
                    double x = (double)(startX + xL-0.5) * dx;
                    fprintf(fp, "%.2f %.2f %f %d\n", x, y, A[yL*nxL+xL], MPIrank);
                }
                fprintf(fp, "\n");
            }

            fflush(fp); 
            fclose(fp);
        }
        MPI_Barrier(comm);
    }
}

#endif // __CHECKER_H_