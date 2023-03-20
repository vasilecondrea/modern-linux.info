# The Linux Kernel

## Linux architecture
3 things:

Hardware CPU, disk drives, etc

The Kernel (focus of the chapter)

User land: where the app are running, OS components (shells), utilities (like *ps* and *ssh*)


Between HARDWARE and KERNEL there are the following interfaces:
 - CPU interface
 - Memory management - interface with main memory
 - Networking (wired, wireless) including drivers
 - File systems
 - Interface for keyboard, terminals, I/O and character devices


 KERNEL contains: processes, memory, networking, filesystem, devices and their interfaces 
 between 
 -- HARDWARE (from CPU, RAM, HDD/SSD/CD/DVD, keyboard etc) 
 AND
 -- USER SPACE (shell, terminal, display server, curl, grep, and sshd)

*The kernel abstracts away the differences of the hardware — that is CPU architectures and peripheral devices — and makes Linux very portable.*

 *Kernel mode*: fast execution with limited abstraction -- syscalls
 *User mode*: slower but safer and more convenient abstraction -- all apps run in the USER LAND

 ## Interfaces between hardware and kernel

    1. CPU architecture = CPU families 
        -- BIOS older versus UEFI newer 

        -- x86 architecture: originally developed by Intel licensed to Advanced Micro Devices (AMD) 
        -- the ARM Architecture - very low consumption so widely used in portable devices (many CPU registers with a small no of instruction - it executes faster) -- important: AWS Graviton an ARM based CPU used in the data centre.

    - Kernel components see their list above


    2. Process Management: 
    
    there are various process management parts in the kernel (some deal with the CPU, others deal with lunch/interruption of programs)
     - a 'process' is 'the user-facing unit, based on an executable program  (or binary)'
     - a 'thread' is 'a unit of execution'
     - 'multithreading' - a process may have a number of parallel executions, potentially running on different CPUs

     Linux has (from the largest to the smallest unit):
     - sessions: one or more process groups; high-level user-facing unit - kernel identifies this as SID (session ID)

        - process groups: one or more processes - *PGID no. is the way the kernel identifies 'the process group ID'

            - processes: abstractions that group multiple resources - kernel idenfies this with the PID process id

                - threads: implemented by the kernel; thread = a process that shares certain resources with other processes;            kernel identifies thread id (TID) or thread group ID (TGID)

                    - tasks: all of the above are anchored in 'tasks' -- tasks not exposed as such outside the kernel.


    3. Memory Management:

    both physical memory and virtual memory are divided into fixed-length chunks we call 'pages'
    A very useful tool to figure out memory-related information such as how much RAM is available to you is the /proc/meminfo interface.

    4. Network: 
    
    kernel provides network functionality:
    - socket - abstracting communication
    - Transmission Control Protocol (TCP) connection-oriented communication and User Datagram Protocol (UDP) communicationless communication
    -  Internet Protocol (IP) addressing machines
    ip link gives overview of network interfaces 

    5. Fielsystems 
    - Linux uses filesystems to organize files and directories on storage devices  (HDDs and SSDs) or flash memory.
    - types of filesystems: ext4, btrfs, NTFS
    - Virtual File System (VFS) supports multiple filesystem types and instances
                It includes but not limited to :    common API abstraction for functions like open/close/write
                                                    plugins (at the bottom)

    6. Device Drivers = driver "code that runs in the kernel" 
    - they manage a devices (actual hardware OR  "pseudo devices" like a pseudo-terminal under /dev/pts/ - this is treated as device as well). You can see these devices with 
        - `ls -al /sys/devices/`
        - mounted devices with `mount` (in my terminal I see) sysfs (systemfiles), proc, udev, securityfs, systemd-1, googlecloud cli, docker, slack, snap-store


    7. Syscalls (hundreds of them)

    Every action you ask kernel to do (touch, download content, etc) is asking it to turn this highlevel instruction into a 'concrete, architecture-dependent steps' - 'the service interface the kernel exposes and that user land entities call is the set of system calls, or syscalls for short'
    
    Example, syscalls of ls

   type `strace ls` - a lot of functions are called including execeve(), brk(), nmap() etc

   

   Advanced topic: how to extend the kernel - Modules and the modern way eBPF

   a module is a program that you can load into a kernel on demand
    e.g. the kernel detects a video card and loads a generic module (another module could be provided by the manufacturer of the card)

    eBPF - "extended BPF"- originating in the Berkeley Packet Filter (BPF)
    - safely and efficiently extend the Linux kernel functions by using the `bpf` syscall.
    - is implemented as an inkernel virtual machine

   to understand a little bit mire, check out  epbf.io.

From https://www.brendangregg.com/blog/2019-01-01/learn-ebpf-tracing.html

'eBPF does to Linux what JavaScript does to HTML. (Sort of.) So instead of a static HTML website, JavaScript lets you define mini programs that run on events like mouse clicks, which are run in a safe virtual machine in the browser. And with eBPF, instead of a fixed kernel, you can now write mini programs that run on events like disk I/O, which are run in a safe virtual machine in the kernel. In reality, eBPF is more like the v8 virtual machine that runs JavaScript, rather than JavaScript itself. eBPF is part of the Linux kernel.

Programming in eBPF directly is incredibly hard, the same as coding in v8 bytecode. But no one codes in v8: they code in JavaScript, or often a framework on top of JavaScript (jQuery, Angular, React, etc). It's the same with eBPF. People will use it and code in it via frameworks. For tracing, the main ones are bcc and bpftrace. These don't live in the kernel code base, they live in a Linux Foundation project on github called iovisor.

'

bcc is for gathering information about the system and debugging

  see a bcc Tutorial tutorial here  https://github.com/iovisor/bcc/blob/master/docs/tutorial.md


bpftrace can be used for customizing bcc tools and writing your own tools.

see a tutorial here https://github.com/iovisor/bpftrace


