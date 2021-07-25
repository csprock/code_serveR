# code_serveR


This repository contains a template for dockerized R development using VS Code and extends the [code-server image](https://github.com/linuxserver/docker-code-server) developed and maintained by [LinuxServer.io](https://www.linuxserver.io/). This container allows for remote access to a VS Code development environment through a web browser.

The repository contains the following
* the Dockerfile
* a sample docker-compose file
* a sample .env file (for docker-compose)
* scripts for installing useful R and VS Code extensions upon container start

## How to Use
First, familiarize yourself with [base image](https://docs.linuxserver.io/images/docker-code-server) from LinuxServer. 

1. Choose an R version by setting the `R_VERSION` argument in the .env file.
2. Add any packages you wish to install to the `env_config/install_packages.R` file
3. Add any VS Code extensions you wish to add to `env_config/extension_list` and set the `INSTALL_EXTENSIONS=true` in the docker-compose file. Set this to `false` once the container has been built
4. Set the directory on the host you wish to become your project workspace in the container by setting the `WORKSPACE_PATH` variable
5. (Optional) set a directory to persist application data by setting the `APPDATA_PATH` variable. See [here](https://docs.linuxserver.io/general/running-our-containers) for more details.


## Environment Variables and Arguments

For an explanation of the difference between environment variables and arguments in Docker, see [here](https://vsupalov.com/docker-arg-env-variable-guide/) 

### Arguments

| Variable | Description |
|----------|-------------|
| `R_VERSION`        | Set the version of R to be installed to the container.           |


### Environment Variables
| Variable | Description |
|----------|-------------|
| `VERSION`        | Image version            |
| `CONTAINER_NAME` | Name of container           |
| `IMAGE_NAME`     | Name of image           |
| `APPDATA_PATH`   | Bind mouth path for `\config` volume in the container (see [here](https://docs.linuxserver.io/general/running-our-containers) for more details)           |
| `WORKSPACE_PATH`   | Path on the host machine to the directory that will become the VS Code's workspace in the container           |
| `CODE_SERVER_PORT` | Port on host machine which VS Code will be accessable on           |

For a complete list variables used by code-server, please see [LinuxServer's documentation](https://docs.linuxserver.io/images/docker-code-server#environment-variables-e). 
