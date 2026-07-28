# Compilers on Sophia

This section describes how to compile C/C++ code standalone, with CUDA, and with MPI on Sophia. Sophia is an NVIDIA DGX A100 system, so it uses the standard **GNU + NVIDIA CUDA** toolchains (`gcc`/`g++`/`gfortran` and `nvcc`) — there is **no Cray Programming Environment** here (unlike Polaris), so do not use the Cray wrappers `cc`/`CC`/`ftn` or `PrgEnv-*` modules.

### User is assumed to know:
* how to compile and run code
* basic familiarity with CUDA and MPI
### Learning Goals:
* How to compile a C++ code
* How to compile a C++ code with CUDA
* How to compile and run a CUDA + MPI code
* Modifications to job submission scripts when using MPI

> **IMPORTANT:** The Sophia **login nodes have no GPUs** and do not have the full CUDA toolchain on their `PATH`. Compile GPU code (and ideally build/test everything) on a **compute node** obtained through an interactive job:
> ```bash
> qsub -I -l select=1 -l walltime=00:30:00 -q by-gpu -l filesystems=home:eagle -A <project-name>
> ```
> Confirm the CUDA compiler is available with `which nvcc`.

# Compiling C/C++ code

For plain (CPU-only) C/C++/Fortran, use the GNU compilers that are available by default:
- `gcc` - C compiler
- `g++` - C++ compiler
- `gfortran` - Fortran compiler

### Example code: [`01_example.cpp`](examples/01_example.cpp)
```c++
#include <iostream>

int main(void){

   std::cout << "Hello World!\n";
   return 0;
}
```

Build and run:
```bash
g++ 01_example.cpp -o 01_example
./01_example
```

__NOTE:__ that this only uses the CPU. CUDA is required to use the GPU.

# Compiling C/C++ with CUDA

CUDA is provided through the NVIDIA CUDA toolkit (CUDA 12.4, driver v470 at the time of writing). On a compute node, confirm it is available:
```bash
which nvcc
nvcc --version
```

The A100 GPUs on Sophia use compute capability `sm_80`.

### Example code: [`01_example.cu`](examples/01_example.cu)

Compile on a **compute node**:
```bash
nvcc -arch=sm_80 01_example.cu -o 01_example_cu
```

### Submit script: [`01_example_cu.sh`](examples/01_example_cu.sh)
```bash
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
```

and submit your job (from the directory containing the script and the compiled `01_example_cu`):
```bash
qsub 01_example_cu.sh
```

# Compiling C/C++ with MPI

To run across multiple GPUs/nodes, MPI is needed. Sophia provides an MPI installation (OpenMPI) with the usual compiler wrappers `mpicc` / `mpicxx` / `mpifort`.

> **Note (verify on system):** At the time of writing, the ALCF Sophia "Compiling and Linking" documentation page for MPI is marked *"NEEDS UPDATING"*, so the exact MPI module name, install path, and version are not reliably documented. Before relying on a specific path, confirm what is actually available on a compute node:
> ```bash
> module avail        # look for an mpi/openmpi module
> which mpicc mpicxx  # confirm the wrappers are on your PATH
> mpicxx --version
> ```
> Load the MPI module the system reports (if any) rather than hard-coding a path from older docs.

### Example Code: [`01_example_mpi.cu`](examples/01_example_mpi.cu)

Build the CUDA + MPI example on a compute node. `mpicxx` wraps the host compiler; use `nvcc` for the CUDA portion (here compiling the whole `.cu` with `nvcc` and pointing it at the MPI wrapper for host code):
```bash
nvcc -arch=sm_80 -ccbin mpicxx 01_example_mpi.cu -o 01_example_mpi
```

### Running the code: [`01_example_mpi.sh`](examples/01_example_mpi.sh)

This bash script submits a job that runs 8 MPI ranks on one node — one rank per GPU.

```bash
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
```

> **Note:** This example uses `-q by-node` so that `select=1` allocates a full 8-GPU node. In the `by-gpu` queue, `select` counts GPUs (1/2/4/8) instead.

# [NEXT ->](02_profiling.md)
