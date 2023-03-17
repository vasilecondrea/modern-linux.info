# Chapter 6: Applications, Package Management, and Containers
content:
    - how application, program, binary, or executable are diff from each other
    - linux start up
    - package management
    - containers
    - modern ways to manage Linux apps (focus on desktop environments)

# Basic vocabulary
program: a binary file or a shell script that Linux can load into memory and execute.

process: when not sleeping, a running entity based on a program (when not sleeping)
         loaded into main memory and either using the CPU or I/O,

daemon: process, sometimes called service (background process); provides a certain function to other processes (ex printer  daemon, webservices, logging, time, utilities)

application: A program including its dependencies (usually with a sort of User interface)
            OR  entire life cycle of a program (configuration, finding data, installing, upgrading. removing it)

package: file that contains programs and configurations; used to distribute software applications

package manager: takes a package as an input and, installs it, upgrades it, or removes it from a Linux environment.

supply chain: software producers and distributors that enable you to find and use applications based on packages

booting - startup sequence in Linux that involves hardware and operating system initialization steps

# Linux startup process: 
  poweron; 
                    (hardware)          1 UEFI or BIOS 
                                        2 Bootloader (bootstraps the kernel) 
                    entering kernel:    3 kernel (this is kernel space) located in the /boot  dri (compressed) 
                    user space:         4 init (launching daemons (service processes) systemwide) 
                                            see for init: 
                                                   **systemd** - init system - a "powerfulsupervisor" includes login, networking, defines daemons and their dependencies
                                                            systemd has **units** - logical grouping in systemd (target, mount, timer units; less important socket, device, automount units)
                                                            **systemctl** - The tool you use to interact with systemd to manage services is systemctl (see 
                                                            $ sudo systemctl status greeter.timer ) also 
                                                            OR: systemctl enable / stop / restart / reload a_service.service
                                        5 other user space (terminal, environment, and shell initialization going on, display manager, server, desktop env, GUI)


# Another topic branching from systemd (see the greteer dir in this repo): 
monitorig with joirnalctl (binary file managed by the systemd-journald daemon, providing a centralized location for all messages logged by systemd components)
you can define to files afile.service and afile.timer which will effectively run your greeter.sh  

to run greeter.sh, cd into greeter dir and run $ bash greeter.sh "george" (you will see "Hello george, you are awesome!" in the terminal)

# New topic: supply chains
from 
**developer** the software  goes to
**repository** and then to a 
**packagemanager** which distributes it to 1. **local cache** and **apps and end-users**

three primary options for package and dependency management

    - traditional pkg managers: 
            packages with data and metadata, zipped; and tooling - package managers - these install/manage/uninstall/maintains apps. e.g. yum, Zypper, apt (debian deb)
            Language specific pkg manager: pip/PyPm (python), npm (node.js), c (Conan), go (go get, go mod), java (maven, nuts)

    - container-based solutions: 
            "container as a Linux process group that uses Linux namespaces, cgroups, and optionally CoW filesystems to provide application-level dependency management."
            they’ve enjoyed mainstream adoption only due to Docker, starting in roughly 2014.
            Docker has a standardized way to define the packaging via container **images** and a human-friendly user interface (for example, docker run)
            NOW we also have OCI (open container initiative)
            containers= immutability - once put together, a configuration cannot be changed. Change requires a NEW static configuration; and a new resources (processes) with it

    - modern pkg managers




# Another topic namespaces vs cgroups (control groups): 
    Linux namespaces - allow processes to have a local view on a resource (such as a filesystem, networking, or even users)             
                    - initially Linux had global view on resources

                    - three relevant syscalls at your disposal: 
                        **clone** (create a child process sharing execution context), 
                        **unshare** (remove a shared execution context from an existing process)
                        **stns** (join an existing process to an existing namespace)

namespaces are about visibility

cgroups are about organising process groups (for CPU, networking, memory, I/O, devices...) there is an old cgroup1 which is now superseeded by cgroup2 (based on lessons learned in cgroup1)

commands to examine:
$ systemctl status
$ systemd-cgtop


# another topic Copy-on-Write filesystems : DOCKER

 CoW filesystems are used in combination with bind mounts to layer the content of the different dependencies on top of each other in an efficient manner.

unique about Docker: contains the building blocks (namespaces, cgroups, CoW filesystems, and bind mounts) AND combines them to be easy to use by hiding the complexity of managing the low-level bits like namespaces and cgroups.


namespaces - cgroups    |                                   |
                        |                                   |
app1, app 2, etc        | this is controlled by | Docker    |  CONTAINER    user DOES
                        |                       | daemon    |                       $ docker run
kernel                  |                                   |                       $ docker build 
                                                                                            to a container image which sits in a Registry

container image - compressed archive file with metadata and JSON files and the layers(directories) - Docker daemon pulls these images as needed from a registry

container = runtime artifact (app A.B.C)

commands
run         Launch a continaer                          Run NGINX as a daemon and remove container on exit: docker run -d 
                                                                                                            --rm nginx:1.21

ps          List containers                             List all containers (including nonrunning): docker ps -a

inspect     Display low-level info                      To query the container IP: docker inspect -f '{{.Network
                                                                        Settings.IPAddress}}'

build       Generate a container image locally          Build image based on current directory and tag: docker build -t
                                                                                                                some:tag .

push        Upload a container image to a registry       Push to AWS registry: docker push public.ecr.aws/some:tag

pull        Download a container image from a registry  Pull from AWS registry: docker pull public.ecr.aws/some:tag

images      List local container images                 List images from a certain registry: docker images ubuntu

image       Manage container images                     Remove all unused images: docker image prune -all


# Alternative to Docker - OCI container tooling
again containers make it easy to work with namespaces and cgroups
e.g.: **containerd**, **skopeo**, **systemd-cgtop**, **nsenter**, '**lsns**, ***cinf*


# Modern package managers: 
snap, flatpack, AppImage, homebrew
