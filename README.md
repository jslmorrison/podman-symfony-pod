# Info

An excercise in moving away from Docker and docker-compose to using Podman on Fedora Silverblue, now that it is my distro of choice now.

## Usage

- ```podman play kube ./my-project-pod.yaml```
- run the symfony console commands to create database schema and run fixtures

Please note that this contains paths only relevant to my device.

In order to regenerate from pod, created with one of the following options, execute:

```podman generate kube my-project-pod > my-project-pod.yaml```

or alternatively:
 - use ansible:
    
    ```ansible-playbook play.yaml```

 - use the makefile.

    e.g. ```make podman.all symfony.all```
