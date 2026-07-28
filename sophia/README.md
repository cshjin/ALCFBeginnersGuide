# Sophia Beginners Guide

This guide aims to introduce researchers with coding experience on clusters and/or supercomputers to the specifics of using ALCF systems.

### Users of this guide are assumed to know:
* basic linux terminal usage
* basic cluster scheduling
* basic code compilation
### Learning Goals:
* Use `module` command to inspect and modify the shell environment


## [Sophia](https://www.alcf.anl.gov/sophia)

Sophia is an NVIDIA DGX A100-based system. It was re-platformed from the earlier ThetaGPU system, so some older ALCF documentation and training material may still refer to ThetaGPU or the Cobalt scheduler — Sophia uses **PBS** (like Polaris and Aurora).

Sophia Machine Specs
* 24 NVIDIA DGX A100 nodes (192 A100 GPUs total)
* Each Node has:
  * 8 NVIDIA A100 GPUs (22 nodes with 40 GB A100s, 2 nodes with 80 GB A100s)
  * 2 AMD EPYC (Rome) 64-core CPUs
  * 1 TB DDR4 (on 40 GB-GPU nodes) or 2 TB (on 80 GB-GPU nodes)
  * 4× 3.84 TB Gen4 NVMe local drives
  * 8 Mellanox HDR200 (QM9700) fabric endpoints in a fat-tree topology


## Logging in:

Login using `ssh` replacing `<username>` with your ALCF username
```bash
ssh <username>@sophia.alcf.anl.gov
```

You will be prompted for your password, which is a six digit code generated uniquely each time using the MobilePASS+ app (CRYPTOCard/MobilePASS+ token).

You will land on one of the Sophia login nodes (`sophia-login-01`/`sophia-login-02`). These are AMD nodes **without GPUs** — use them for editing, building small non-GPU code, and submitting jobs, not for GPU compilation or computation (see [01_compilers.md](01_compilers.md)).

## Quick filesystem breakdown

When you login, you start in your _home_ directory: `/home/<username>/`. The home file system (`agile-home`, mounted at `/home` or `/lus/agile/home`) has a default quota of **50 GB** and is backed up; it is meant for small files and binaries, not intensive I/O from compute nodes.
As an ALCF user you will be assigned access to different allocation _projects_. You can see your projects listed on the [ALCF Accounts Page](https://accounts.alcf.anl.gov). Each project maps to a user group to control filesystem access, so you can also check your projects using the `groups` command on the terminal. On Sophia, project data lives on the **Eagle** Lustre filesystem where all members of the project can read/write and share data/software:
* `/lus/eagle/projects/<project-name>` (also reachable as `/eagle/projects/<project-name>`)

Users should use project spaces for large scale storage and software installations, and for intensive job I/O from compute nodes. You can check your usage with `myquota` (home) and `myprojectquotas` (project). Increases can be requested via `support@alcf.anl.gov`.

> **Note:** Sophia mounts `home` and `eagle` only — there is no `flare` or `grand` on Sophia. Jobs declare the filesystems they need with `-l filesystems=home:eagle` (see [00_scheduler.md](00_scheduler.md)).

## Clone repo:

Next, clone this repository into your home directory using:
```bash
git clone https://github.com/argonne-lcf/ALCFBeginnersGuide.git
cd ALCFBeginnersGuide
```

## Getting to know the environment

ALCF uses [Environment Modules](https://modules.readthedocs.io/en/latest/index.html) to provide users with loadable software packages. This includes compilers, python installations, and other software. Here are some basic commands:

`module list`: lists all currently loaded modules

`module avail`: lists the available modules that can be loaded. What modules are available is controlled by the `MODULEPATH` environment variable. The colon-separated list of paths is scanned for module files.

One can include pre-built modules from ALCF staff by adding the path `/soft/modulefiles` to `MODULEPATH` using either of these commands:
```bash
export MODULEPATH=$MODULEPATH:/soft/modulefiles
# OR
module use /soft/modulefiles
```

After doing this, you will find additional modules listed with `module avail`.

## Loading modules

Now we can "load modules" which simply executes some simple bash commands to add paths to prebuilt software into our environment variables such as `PATH` and `LD_LIBRARY_PATH`, thus making the software easily available for compilation or use. For example, to make a Python/conda environment available:

```bash
module use /soft/modulefiles
module load conda
```

> **Note:** In non-interactive (batch) job scripts on Sophia, start the script with `. /etc/profile` before using `module` commands, so that the module system is initialized on the compute node.


## [NEXT ->](00_scheduler.md)
