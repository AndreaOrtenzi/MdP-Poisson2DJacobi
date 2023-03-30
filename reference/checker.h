#ifndef __CHECKER_H_
#define __CHECKER_H_
#include <stdio.h>
#include <stdbool.h>

int getFilename(char *filename, size_t maxFileLen, size_t nx, size_t ny, size_t nmax, double eps){
   return snprintf(filename, maxFileLen, "%zu_%zu_%zu_%f.ref", nx, ny, nmax, eps);
}

void writeToFile(double* arr, size_t nx, size_t ny, size_t nmax, double eps){
    size_t maxFileLen = 150; 
    char filename[maxFileLen];
    getFilename(filename,maxFileLen,nx,ny,nmax,eps);
    //snprintf(filename, maxFileLen, "%d_%d_%d_%f.ref", nx, ny, nmax, eps);

    FILE *fh = fopen(filename, "w");
    // for(size_t i = 0; i<ny*nx; i++)
        fwrite(arr, sizeof(double), nx*ny, fh);

    fclose(fh);
}

//  https://stackoverflow.com/a/253874/8701598
bool approximatelyEqual(float a, float b, float epsilon)
{
    float smooth = 0.0001f;
    return fabs(a - b)<= ( (fabs(a) < fabs(b) ? fabs(b) : fabs(a)) * epsilon) + smooth;
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
    for(size_t i = 0; i<ny*nx; i++){
        if(!approximatelyEqual(arr[i],tmp[i],approxEps)){
            printf("Not equal! idx: %zu, was: %f, expected: %f\n", i,arr[i],tmp[i]);
            return 1;
        }
    }
    printf("Correct\n");
    fclose(fh);
    free(tmp);
    return 0;
}

#endif // __CHECKER_H_