#!/bin/bash -l
#SBATCH --time=00:15:00
#SBATCH --account=p200117
#SBATCH --nodes=1
#SBATCH --job-name=Summit23
#SBATCH --export=NONE
#SBATCH --cpu-freq=2200000
#SBATCH -p gpu
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=1
#SBATCH -q short

# cpus-per-task= OMP Threads per Mpi task
# -p gpu for GPU


# module purge
# module load OpenMPI/4.1.4-GCC-11.3.0
# module load foss/2022a # alternative
module load OpenMPI/4.1.4-NVHPC-22.7-CUDA-11.7.0
# module load foss/2022a # alternative
# module avail OpenMPI
make clean
make -j
# CUDA_VISIBLE_DEVICES=“0” 
# export OMPI_MCA_pml=ucx
mpirun ./jacobiCUDA

