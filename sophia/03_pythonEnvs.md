# Python Environments

### Users are assumed to know:
* how to use Python
* basic Conda usage

### Learning Goals:
* How to add prebuilt Python environments into your environment
* Loading a Conda module
* Create a custom build environment based on a pre-existing Conda module

## Overview

ALCF provides pre-built `conda` environments on Sophia containing GPU-supported builds of common ML/Python libraries, such as:

- [PyTorch](https://pytorch.org/)
  - [DDP](https://pytorch.org/tutorials/beginner/dist_overview.html)
  - [Horovod](https://horovod.readthedocs.io/en/stable/pytorch.html)
- [TensorFlow](https://www.tensorflow.org/)
  - [Horovod](https://horovod.readthedocs.io/en/stable/tensorflow.html)
- [JAX](https://jax.readthedocs.io/en/latest/)
- [mpi4py](https://mpi4py.readthedocs.io/en/stable/)

## Loading Python Environment

To load and activate the default environment (either from an interactive job or inside a job script):

```bash
# tell modules where to find the ALCF-staff conda module
module use /soft/modulefiles
# load conda into your environment
module load conda
# activate the base conda environment
conda activate base
```

> **Note:** In a batch job script, start the script with `. /etc/profile` before running these `module` commands so the module system is initialized on the compute node.

If you need to install additional packages, there are two approaches covered in the following sections:

1. [Virtual environments via `venv`](#virtual-environment-via-venv): builds an extendable environment on top of the immutable base environment.
2. [Clone the base `conda` environment](#clone-conda-environment): a complete mutable copy of the base environment into a user's space.

In general, these are things that should be done in a user's project directory (`/lus/eagle/projects/<project-name>/`) to get the best performance and available capacity.

## Virtual Environment via `venv`

The easiest method for making a custom environment that builds on top of the ALCF environment is to use `venv`.

```bash
module use /soft/modulefiles; module load conda; conda activate base
python -m venv /path/to/venvs/base --system-site-packages
```

By passing the `--system-site-packages` flag, the new virtual environment inherits all the packages from the base `conda` environment, while being able to install new packages.

To activate this new environment,

```bash
source /path/to/venvs/base/bin/activate
```

Once activated, installing packages with pip is as usual:

```bash
python -m pip install <new-package>
```

To install a _different version_ of a package that is **already installed** in the base environment add `--ignore-installed` to your command:

```bash
python -m pip install --ignore-installed <new-package>
```

## Clone Conda Environment

Cloning a Conda environment creates a full copy of the ALCF conda environment in a specified directory. This means the user has full control of the environment. This process can use significant disk space and be quite slow, so prefer the [`venv`](#virtual-environment-via-venv) approach whenever possible.

Create a `clone` of the base environment by:

```bash
# load conda
module use /soft/modulefiles; module load conda; conda activate base
# create the clone
conda create --clone base --prefix /path/to/envs/myclone
# load the cloned environment
conda activate /path/to/envs/myclone
```

Future loading can be done with:

```bash
module use /soft/modulefiles; module load conda; conda activate /path/to/envs/myclone
```

It is necessary to ensure the version of conda you are loading is the same as the one with which you generated the clone.


## Additional Resources

- [ALCF Docs: Python on Sophia](https://docs.alcf.anl.gov/sophia/data-science/python/)


# [NEXT ->](04_jupyterNotebooks.md)
