# Chapter 1: Intro to Linux

**Linux related environments:**
    - Mobile devices: Android 
    - Cloud computing - AWS has on offer the powerful AWS Graviton secure, energy saving CPU architectures
    - IoT
    - Other processor architectures


**The linux story:**

1990s Linus Tordvald's email to comp.os.minix on Aug 25 1991 represents the birth of the Linux project
2000-2010 - "teenager" Linux - growing beyond UNIX. Adoption by Google, Amazon, IBM
2010s to present 
    - Linux is 'the workhorse in data centers and the cloud' / IoT / Cloud
    - distro wars are over: we either have RedHat or Debian based OS
    - rise of container (starting 2014)

**What is "Linux kernel"?**
 it is essentially an clean nice API (Application Programming Interface) which is part of the OS Linux (the OS does all the work to abstract hardware components). "We usually call these APIs that an OS exposes system calls, or *syscalls* for short."

**Linux distributions or distros** 
'concrete bundling of kernel and related components' that could be package management file system, init system, a shell. One can roll his/her own distro if one is so inclined (see Arch Linux for creating customized distros)

**"Global view"** 
this has to do with "containers"  -- in Linux everything is a file or something that can be used for execution of a software.


Linux identifies a process by PID "process ID" 
-- $$ is the process ID of the shell (such as bash)
-- in my shell PID gives out Pid no: 16157 with PID1 being reserved for the "root of the user space process tree"

Advantages:
1. multiple users / processes running means 'restricted visibility on to resources'
2. isolation of processes of one from another

A presentation of the following chapters ensues. 
