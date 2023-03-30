.PHONY: all clean
CC = mpicc 
CFLAGS = -O3 -fopenmp -march=native #-std=c++14 -stdlib=libc++ -g -O0
LDFLAGS = -lm

all: jacobiMPI

jacobiMPI: mainMPI.c
	$(CC) $(CFLAGS) $(LDFLAGS) mainMPI.c solver_transposed_mpi.c solver_transposed_mpi_avx.c -o jacobiMPI

clean:
	rm -f jacobiMPI *.o