# The Linux Kernel

**Linux architecture**

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
