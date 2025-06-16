# mock-ssh-server

Mocked SSH server for development

## Description

This is a mocked SSH server built using Ubuntu 22.04 with OpenSSH installed. It's designed to be used in development environments where an SSH server is required.

## Features

- Based on Ubuntu 22.04
- OpenSSH Server pre-installed and configured
- Default root user credentials (passwordless):
  - **Username:** `root`

## Prerequisites

- Docker installed on your machine

## Getting Started

### Building the Docker Image

To build the Docker image, navigate to the directory containing this README and run:

```bash
docker build -t mock-ssh-server .
```

### Running the Container

After building the image, you can start a container using the following command:

```bash
docker run --name ssh-container -p 2222:22 -d mock-ssh-server
```

This maps port `22` in the container to port `2222` on your host machine. You can connect to the SSH server using a client by connecting to `localhost:2222`.

### Connecting via SSH

To connect to the running container using an SSH client, use the following command:

```bash
ssh root@localhost -p 2222
```

## Configuration Details

Here are some details about what's configured in this Dockerfile:

- Installs OpenSSH Server (`openssh-server`)
- Sets up the `/var/run/sshd` directory
- Adds a root user with a password of "root"
- Disables password authentication and allows root login:
  - `PermitRootLogin yes`
  - `PasswordAuthentication no`

## Customization

To customize this Dockerfile:

1. Modify the `Dockerfile` as needed.
2. Rebuild the image using `docker build -t mock-ssh-server .`.
3. Run a new container with your changes.

## Useful Tips

### Accessing Files in the Container

If you need to access files inside the running container, use Docker's file copy command:

```bash
docker cp ssh-container:/etc/ssh/sshd_config ./local_sshd_config
```

This will copy the `sshd_config` file from the container to your local machine.

### Running Commands in the Container

To execute commands inside the running container, use:

```bash
docker exec -it ssh-container /bin/bash
```

This opens a bash shell in the container, allowing you to run commands as if you were logged in directly.
