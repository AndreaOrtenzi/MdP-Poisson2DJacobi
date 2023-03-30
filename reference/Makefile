.PHONY: all clean
CC = gcc 
CFLAGS = -O3 
LDFLAGS = -lm

all: jacobi

jacobi: ./*
	$(CC) $(CFLAGS) $(LDFLAGS) main.c solver.c -o jacobi


clean:
	rm -f jacobi *.o