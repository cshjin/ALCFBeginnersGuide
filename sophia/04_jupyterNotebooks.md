# Jupyter at ALCF

### Users are assumed to know:
* basic Jupyter Notebook usage
* basic batch scheduler usage on a cluster/supercomputer
### Learning Goals:
* Login to ALCF Jupyter on Sophia
* Submit a job via the Jupyter interface
* Adding a Conda environment to your Jupyter kernel list


JupyterHub is an open-source application that allows multiple users to launch Jupyter Notebooks from a central location.

[Link to Full Docs](https://docs.alcf.anl.gov/services/jupyter-hub/)

### Quick Description of the Process:
1. At ALCF, users can use the JupyterHub instances at [https://jupyter.alcf.anl.gov](https://jupyter.alcf.anl.gov).
2. Select which machine to launch a notebook server on — **Sophia** is selectable alongside the other ALCF systems.
3. Login using your [Passcode Token](https://docs.alcf.anl.gov/account-project-management/accounts-and-access/alcf-passcode-tokens/), exactly the same as you would to login to an ALCF machine via ssh.
4. Select parameters for the job that will be submitted to the queue. You are defining the parameters for the PBS job at this stage.
    * Select a job profile (e.g. a Sophia compute node profile).
    * Queue Name: the queue on the system (see [00_scheduler.md](00_scheduler.md) for Sophia's `by-gpu` / `by-node` queues).
    * Project List: the list of active projects associated with your account.
    * Number Chunks: the number of compute resources to allocate for the job.
    * Runtime (minutes:seconds): the runtime of the job.
    * File Systems: which file systems are required (on Sophia, `home` and `eagle`).
5. Wait for the job to start. There is a timeout after which the service removes your job from the queue, and you must resubmit.
6. When your server starts, navigate to your working folder, then start a new notebook using a kernel.

## Customize Environment

ALCF provides a simple Python3 environment and the default `conda` module. Most users should use the `conda` module, as the plain Python3 environment has little installed. Users can add kernels that employ their custom environment. See [03_pythonEnvs.md](./03_pythonEnvs.md) for how to make custom environments.

With your custom environment loaded, you can register it as a Jupyter kernel:

```bash
# with your target environment active
python -m ipykernel install \
    --user \
    --name=<kernel-name> \
    --display-name="<kernel-display-name>"
```

This creates a `kernel.json` file in `~/.local/share/jupyter/kernels/<kernel-name>/`, generated automatically from your active environment. After completing these steps, you should see `<kernel-name>` when you click *New* on the JupyterHub home page or use the *Kernel* menu in a notebook.

Note: kernels are loaded by Jupyter during server start, not while the server is running. A stop/restart is required if the kernel was installed while the server was running.

## Accessing Project Folders

From within the JupyterHub file browser, users are limited to viewing files within their home directory.

To access project directories located outside of your `$HOME`, create a symbolic link to the directory.

For example, to access project `ABC` on Eagle:

```bash
# from a terminal
cd ~
ln -s /lus/eagle/projects/ABC ABC_project
```

```bash
# in a notebook using the `!` escape
!ln -s /lus/eagle/projects/ABC ABC_project
```
