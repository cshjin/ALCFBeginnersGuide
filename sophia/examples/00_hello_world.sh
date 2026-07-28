#!/bin/bash
#PBS -l select=1
#PBS -l walltime=00:30:00
#PBS -q by-node
#PBS -l filesystems=home:eagle
#PBS -A <project-name>
#PBS -o logs/
#PBS -e logs/

# initialize the module system on the compute node (required in batch scripts on Sophia)
. /etc/profile

cd ${PBS_O_WORKDIR}

# Sophia has 8 GPUs per node
GPUS_PER_NODE=8

mpiexec -n $GPUS_PER_NODE -ppn $GPUS_PER_NODE echo Hello World
