#!/bin/bash -l
#SBATCH --time=00:15:00
#SBATCH --account=p200117
#SBATCH --nodes=1
#SBATCH --job-name=Summit23
#SBATCH --export=NONE
#SBATCH --cpu-freq=2200000
#SBATCH -p gpu
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH -q short


module purge
module load OpenMPI/4.1.4-NVHPC-22.7-CUDA-11.7.0
export OMP_NUM_THREADS=1
for i in {3..14}
do
	s=`echo "( 2 ^ $i   )" | bc -l` 
	s=$(printf '%.0f' "$s")
    echo $s
    SIZE_X=$s
    SIZE_Y=$s
    make clean
    make SIZE_X=$SIZE_X SIZE_Y=$SIZE_Y
    srun -n 1 ./jacobiCUDA

done


