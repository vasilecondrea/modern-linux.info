# The Linux Kernel

**Linux architecture**
3 things:

Hardware CPU, disk drives, etc

The Kernel (focus of the chapter)

User land: where the app are running, OS components (shells), utilities (like *ps* and *ssh*)


The interface between HARDWARE and KERNEL has collection of interfaces:
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

**Continues with**
    - CPU architecture = CPU families 
        -- BIOS older versus UEFI newer 

        -- x86 architecture: originally developed by Intel licensed to Advanced Micro Devices (AMD) 
        -- the ARM Architecture - very low consumption so widely used in portable devices (many CPU registers with a small no of instruction - it executes faster) -- important: AWS Graviton an ARM based CPU used in the data centre.

    - Kernel components see their list above

    1. Process Management: 
    
    there are various process management parts in the kernel (some deal with the CPU, others deal with lunch/interruption of programs)
     - a 'process' is 'the user-facing unit, based on an executable program  (or binary)'
     - a 'thread' is 'a unit of execution'
     - 'multithreading' - a process may have a number of parallel executions, potentially running on different CPUs

     Linux has ('from most granular to the smalllest unit'):
     - sessions: one or more process groups; high-level user-facing unit - kernel identifies this as SID (session ID)
     - process groups: one or more processes - *PGID no. is the way the kernel identifies 'the process group ID'
     - processes: abstractions that group multiple resources - kernel idenfies this with the PID process id
     - threads - implemented by the kernel; thread = a process that shares certain resources with other processes; kernel identifies thread id (TID) or thread group ID (TGID)
     - tasks: all of the above are anchored in 'tasks' -- tasks not exposed as such outside the kernel.


    2. Memory Management:

    both physical memory and virtual memory are divided into fixed-length chunks we call 'pages'
    A very useful tool to figure out memory-related information such as how much RAM is available to you is the /proc/meminfo interface.

    3. Network: 
    
    kernel provides network functionality:
    - socket - abstracting communication
    - Transmission Control Protocol (TCP) connection-oriented communication and User Datagram Protocol (UDP) communicationless communication
    -  Internet Protocol (IP) addressing machines
    ip link gives overview of network interfaces 