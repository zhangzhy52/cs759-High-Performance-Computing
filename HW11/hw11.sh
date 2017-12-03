#!/bin/sh
#SBATCH --partition=slurm_shortgpu
#SBATCH --time=0-00:05:00 # run time in days-hh:mm:ss
#SBATCH --nodes=1
#SBATCH --cpus-per-task=40
#SBATCH -o out         # This sends stdoutto a file
#SBATCH -e err         # This sends stderrto a file
#SBATCH --gres=gpu:1

cd $SLURM_SUBMIT_DIR          # go to job submission directory

# echo source activate my_perl
# source activate my_perl
# echo perl check_homework.pl
# perl check_homework.pl

echo make clean
make clean
echo make
make
printf "\n"

printf "==========\nproblem 1\n==========\n"
for i in `seq 1 24`
do
    N=$(echo 2^$i | bc)
    echo ./problem1 2^$i
    ./problem1 $N
    printf "*******************\n"
    echo ./ref_scan 2^$i
    ./ref_scan $N
    printf "~~~~~~~~~~~~~~~~~~~\n"
done
printf "\n"

printf "==========\nproblem 2\n==========\n"
for i in `seq 1 24`
do
    N=$(echo 2^$i | bc)
    echo ./problem2 2^$i
    ./problem2 $N
    printf "*******************\n"
    echo ./ref_reduction 2^$i
    ./ref_reduction $N
done
printf "\n"

printf "==========\nproblem 3\n==========\n"
echo ./problem3
./problem3



mv out job_out_$SLURM_JOB_ID
mv err job_err_$SLURM_JOB_ID
