# JacobiChallenge - MPI + CUDA

## CUDA
For the single GPU approach we used CUDA.

To run the single GPU approach make sure that in the ``Makefile`` line 8 is set to ``jacobiCUDA``.

Also in ``scripts/meluxina.sh`` set ``--ntasks-per-node=0`` and the last line to ``mpirun ./jacobiCUDA``



Change the size using the defines in the ``Makefile``.
```
sbatch ./scripts/meluxina.sh
```

## CUDA + MPI
For the multi gpu approach set the  ``Makefile`` line 8 to ``jacobiMPI``.

Also in ``scripts/meluxina.sh`` set ``--ntasks-per-node=4`` to use all 4 gpus of a system. If set to higher numbers that the MPI processes will loop in their access to the GPUs. So MPI task 4 will access GPU 0. 

Change the last line in ``scripts/meluxina.sh`` to ``mpirun ./jacobiCUDA``.

```
sbatch ./scripts/meluxina.sh
```




