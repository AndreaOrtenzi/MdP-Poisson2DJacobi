.PHONY: all clean
CC = gcc 
CFLAGS = -O3
LDFLAGS = -lm
SIZE_X=1024
SIZE_Y=1024

all: jacobiCUDA

jacobiCUDA: ./solver.cu
	nvcc -arch=compute_70 -DNX=$(SIZE_X) -DNY=$(SIZE_Y) $(CFLAGS) $(LDFLAGS) ./solver.cu  -o jacobiCUDA

jacobiMPI: solverMPI.cu
	nvcc -lmpi -lnvidia-ml -arch=compute_70 -DNX=$(SIZE_X) -DNY=$(SIZE_Y) $(CFLAGS) $(LDFLAGS) solverMPI.cu -o jacobiMPI

clean:
	rm -f jacobiCUDA jacobiMPI *.o