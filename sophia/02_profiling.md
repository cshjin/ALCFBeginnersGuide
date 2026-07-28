# Profiling with NVIDIA Nsight tools

NVIDIA® Nsight™ Systems provides developers a system-wide visualization of an application's performance. Developers can optimize bottlenecks to scale efficiently across the CPUs and A100 GPUs on Sophia. For further optimization of compute kernels, developers should use Nsight Compute.

NVIDIA Nsight Compute is an interactive kernel profiler for CUDA applications. It provides detailed performance metrics and API debugging via a user interface and command line tool.

### Users are assumed to know:
* basic usage of NVIDIA Nsight Systems and Compute profilers
### Learning Goals:
* How to run NVIDIA profilers on Sophia
* Installing NVIDIA profilers on your local machine
* Viewing results produced on Sophia on your local machine

> **Note:** Some older ALCF profiling pages for this hardware predate the Sophia re-platform and show the **Cobalt** scheduler (e.g. `module load cobalt/cobalt-gpu`, `qsub -n ... -q full-node`) and the older `.qdrep` report extension. On Sophia, use the **PBS** interactive job shown below; modern `nsys` writes `.nsys-rep` files.

## Step-by-step guide

### Common part on Sophia
Build your application on a Sophia compute node (see [01_compilers.md](01_compilers.md)), then profile it from an interactive job:
```bash
qsub -I -l select=1 -l walltime=1:00:00 -l filesystems=home:eagle -q by-gpu -A <project-name>

# on the compute node, confirm the CUDA toolkit (which provides nsys/ncu) is available
which nsys ncu
nsys --version
ncu --version
```

### Nsight Systems
Run your application with Nsight Systems as follows:
```bash
nsys profile -o {output_filename} --stats=true ./{your_application}
```

### Nsight Compute
Run your application with Nsight Compute:
```bash
ncu --set detailed -k {kernel_name} -o {output_filename} ./{your_application}
```

Remark: Without the `-o` option, Nsight Compute provides performance data as standard output.

### Post-processing the profiled data
#### Post-processing via CLI
```bash
nsys stats {output_filename}.nsys-rep
ncu -i {output_filename}.ncu-rep
```

#### Post-processing on your local system via GUI
* Install [NVIDIA Nsight Systems](https://developer.nvidia.com/nsight-systems) and [NVIDIA Nsight Compute](https://developer.nvidia.com/nsight-compute) after downloading them from the NVIDIA Developer Zone.
  Remark: Your local client version should be the same as or newer than the NVIDIA Nsight tools on Sophia.
* Download the `nsys` output files (i.e., ending with `.nsys-rep` and `.sqlite`) to your local system, and then open them with NVIDIA Nsight Systems.
* Download the `ncu` output files (i.e., ending with `.ncu-rep`) to your local system, and then open them with NVIDIA Nsight Compute.

### More options for performance analysis with Nsight Systems and Nsight Compute
```bash
nsys --help
ncu --help
```

## References
[NVIDIA Nsight Systems Documentation](https://docs.nvidia.com/nsight-systems/UserGuide/index.html)
[NVIDIA Nsight Compute Documentation](https://docs.nvidia.com/nsight-compute/NsightCompute/index.html)

# [NEXT ->](03_pythonEnvs.md)
