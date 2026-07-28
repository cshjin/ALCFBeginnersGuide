#!/bin/bash
#PBS -l select=1
#PBS -l walltime=00:10:00
#PBS -q by-gpu
#PBS -l filesystems=home:eagle
#PBS -A <project-name>
#PBS -o logs/
#PBS -e logs/

# initialize the module system on the compute node (required in batch scripts on Sophia)
. /etc/profile

# run from the directory you submitted from, where the compiled binary lives
cd ${PBS_O_WORKDIR}

./01_example_cu
