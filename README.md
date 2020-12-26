# Info

An excercise in moving away from Docker and docker-compose to using Podman on Fedora Silverblue, now that it is my distro of choice now.

## Usage

- ```podman play kube ./my-project-pod.yaml```
- run the symfony console commands to create database schema and run fixtures

or alternatively use the makefile.

e.g. ```make podman.all symfony.all```

### TODO
- SELinux permissions