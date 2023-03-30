#!/bin/bash -l
#SBATCH --account=p200117
#SBATCH --job-name=Summit23MPI
#SBATCH --export=NONE
#SBATCH -N 1
#SBATCH --ntasks=9
#SBATCH --cpus-per-task=1
#SBATCH -p cpu
#SBATCH -q test
#SBATCH --time 00:10:00

#Load OpenMPI module
# module load OpenMPI
module load OpenMPI/4.1.4-GCC-11.3.0
module load foss/2022a # alternative

#Check OpenMPI version
mpicc --version

#Compile C program with OpenMPI
make clean
make

#Execute the program
srun jacobiMPI

# export FONTCONFIG_PATH=/etc/fonts
# module load gnuplot
# gnuplot ./result.plot