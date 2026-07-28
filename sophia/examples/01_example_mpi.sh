#!/bin/bash
#PBS -l select=1
#PBS -l walltime=00:10:00
#PBS -q by-node
#PBS -l filesystems=home:eagle
#PBS -A <project-name>
#PBS -o logs/
#PBS -e logs/

# initialize the module system on the compute node (required in batch scripts on Sophia)
. /etc/profile

# run from the directory you submitted from, where the compiled binary lives
cd ${PBS_O_WORKDIR}

# Count number of nodes assigned
NNODES=`wc -l < $PBS_NODEFILE`
# Sophia has 8 GPUs per node; run 1 MPI rank per GPU
NRANKS_PER_NODE=8
# calculate total ranks
NTOTRANKS=$(( NNODES * NRANKS_PER_NODE ))
echo "NUM_OF_NODES= ${NNODES} TOTAL_NUM_RANKS= ${NTOTRANKS} RANKS_PER_NODE= ${NRANKS_PER_NODE}"

mpiexec -n ${NTOTRANKS} --ppn ${NRANKS_PER_NODE} --hostfile ${PBS_NODEFILE} ./01_example_mpi
