Filesystems

UNIX =  “everything is a file” --- most resources in Linux are indeed files.

Even devices and pseudo devices are exposed as files (like echo "Hello modern Linux users" > /dev/pts/0, prints “Hello modern Linux users” to the screen, as if a file but it is not a proper file to read). Ex 2: kernel exposes a process like PID as if it was a file

this makes it easy to learn linux: everything you do you can do as if it was file. 

content: 
relevant terms
how Linux implements the “everything is a file” abstraction. N
review special-purpose filesystems the kernel uses to expose information about processes or devices. 
regular files and filesystems, something you would typically associate with documents, data, and programs. 
compare filesystem options and discuss common operations.

# relevant terms
- filesystems are hierarchical (like a tree) and start at root (/)
- directories as an organizational unit, allowing you to group files
- navigation with: ls (list), cd (change dir), pwd (print working dir)
- permissions are builtin
- filesystem implemented in the kernel

Definitions to understand:
Drive: device such as a hard disk drive (HDD) or a solid-state drive (SSD); when emulated /dev/sda (SCSI device) or /dev/sdb (SATA device) or /dev/hda (IDE device)

Partition - logically split up drives into storage sectors - your HDD  would show up as /dev/sdb1 and /dev/sdb2.
Volume somewhat similar to a partition, but it is more flexible

Super block - When formatted, filesystems have a special section in the beginning that captures the metadata of the filesystem (ex filesystem type, blocks, state, and how many inodes per block)

Inodes - in filesystems, inodes store metadata about files, such as size, owner, location, date, and permissions. (NOT actual data which sits in files, directories)


Command             Use case
lsblk               List all block devices    DO lsblk --exclude 7 to exlude the loops
fdisk, parted       Manage disk partitions
blkid               Show block device attributes such as UUID
hwinfo              Show hardware information
file -s             Show filesystem and partition information
stat, df -i, ls -i  Show and list inode-related information 

see "stat masktest"  look at individual filesys obj (files directories)
with "stat ."        the respective directory file information, including its inode, number of blocks used

    Another term: LINK (**hard link** [reference inodes] and **symbolic link** (file containing a string representing the path to another file))
    commands to create a link and a soft link to file masktest

       $ ln masktest maskHardLink (creates a hard link to masktest)
       $ ln -s masktest maskSoftLink (creates a soft link to masktest - Note -s)
       $ stat maskHardLink and etc to see details about the links
       $ ls -ali *ink 
       last one outputs
            8264537 -rwxrwxr-x 4 v_condrea v_condrea 0 Mar 15 09:44 maskHardLink
            8266332 lrwxrwxrwx 1 v_condrea v_condrea 8 Mar 15 10:43 maskSoftLink -> masktest 


    ANOTHER TOPIC: 
Virtual File System: a layer of indirection between the clients (syscalls) and the individual filesystems implementing operations for a concrete device or other kind of resource.

**VFS separates the generic operation (open, read, seek) from the actual implementation details.**
VFS wrapps: 
    - local filesys (XFS, FAT, and NTFS), 
    - in-memory filesys (RAM), 
    - pseudo filesys (also in memory -- kernel interfacing and device abstractions), 
    - networked filesys (NFS, Samba, Netware (nee Novell),)

    SELECTED syscalls 
    Category    Examples 

    Inodes          chmod, chown, stat
    Filesopen       close, seek, truncate, read, write
    Directories     chdir, getcwd, link, unlink, rename, symlink
    Filesystems     mount, flush, chroot
    Others          mmap, poll, sync, flock

    ANOTHER TOPIC : 
    Logical volume manager (LVM) 
    - a layer of indirection between physical entities (such as drives or partitions) and the file system.

          file system A        file system B
                 |                     |
                 |                     |
          logical Vol 1       logical vol 2

                    \              /
                     VOLUME GROUP 1
                            |

       physical vol 1   physical vol 2    physical vol 3

       type **hwinfo** to get info hardware
       type **lvscan** to get info on volumes 


       ANOTHER TOPIC: Filesystem Operations
       shows how to create a filesystem, given a partition or a logical volume (created using LVM).
       - two steps: 
                -- creating the filesystem (called formating in other OS than Linux)
                -- mounting it, or inserting it into the filesystem tree.


    Another topic: common filesystems
    you can see the concrete setup of a machine do
    man hier
    you will get the man help menu explaining what each file contains 

type of filesystems layouts:

    bin, sbin       System programs and commands (usually links to /usr/bin and /usr/sbin)
    boot            static files for the boot loader; Kernel images and related components
    dev              Devices (terminals, drives, etc.)
    etc             System configuration files
    homeUser         home directories
    lib             Shared system libraries
    mnt, media      Mount points for removable media (e.g., USB sticks)
    opt             Distro specific; can host package manager files
    proc, sys       Kernel interfaces; see also “Pseudo Filesystems” on page 104
    tmp             For temporary files
    usr             User programs (usually read-only)
    var             User programs (logs, backups, network caches, etc.)


  

# Pseudo Filesystems

- procfs (older from UNIX)
- sysfs (newer for Linux)
- devices: devfs

  - pseudo filesystems (when the VFS implementor is not a bloc devices i.e. SD cards, SSD drive)
       pseudo filesystems only pretend to be filesystems so that we can interact with them in the usual manner (ls, cd, cat), but really they are wrapping some kernel interface. Examples

**procfs** filessystems (process fs) - OLDER WAY TO LOOK AT FILE SYSTEMS

        
Information that can be 
ENTRY       type        Information
attr        Directory   security attributes
cgroup      File        Control groups
cmdline     File        Command line
cwd         Link        Current working directory
environ     File        Environment variables
exe         Link        Executable of the process
fd          Directory   File descriptors
io          File        Storage I/O (bytes/char read and written)
limits      File        Resource limits
mem         File        Memory used
mounts      File        Mounts used
net         Directory   Network stats
stat        File        Process status
syscall     File        Syscall usage
task        Directory   Per-task (thread) information
timers      File        Timers information

commands like the following can get some information from the above (current running command and IP, respectively)
$ cat /proc/self/status | head -10
$ cat /proc/self/net/arp

**sysfs**
procfs inherited/older fs from UNIX
sysfs is the Linux fs by which linux exposes information

directories of sysfs: block/  bus/  class/   dev/  devices/   firmware/   fs/   module/
see the sysfs in action (info about "block device sda"):
$ ls -al /sys/block/sda/ | head -7

**devfs**

/dev filesystem (devfs) hosts device special files, representing devices ranging
from physical devices to things like a random number generator or a write-only data
sink
devices available via devfs: 
    Block devices (ex drives), 
    Character devices (terminal, keyboard/mouse), 
    Special devices (they generate/manipulate data see /dev/null AND /dev/random)
        ex you want a random string? (generates a 42-character random sequence) 
                                DO:  $ tr -dc A-Za-z0-9 < /dev/urandom | head -c 42
        ex: send somthing to terminal /dev/tty stands for the terminal
                                DO $ echo "something" > /dev/tty


#    SYSTEMS you want to manage regular files (docs, data files)

    1. Regular files
ex: docs, YAML,  JSON, (PNG, JPEG, etc.), source code, plain text files etc


    2. common filesystem : filesystems that are either the defaults used in Linux distributions or widely
used in storage devices

files systems: 
"extended filesystem": ext2, ext3, 
ext4 (see https://www.man7.org/linux/man-pages/man5/ext4.5.html 
    DEFAULT today, supported since 2008 in Linux, filesize 16TB, no. files 4bilion, filenamelenght 255 like all the others)


other file systems:  XFS and ZFS, NTFS and vfat
and brtfs (supported since 2009) - b-tree fs (pronounced butterFS or betterFs) developed by Oracle, A CoW type of fs (suitable for professional env see server)


    3. In memory filsystems
    ex: debugfs, loopfs, pseudo fs (pipefs, sockfs), swapfs, tempfs


    4. Copy-on-Write (CoW) Fs - relevant to CONTAINERS
Advantage    increase I/O speed and uses less space. 
Means: 
        A. when File1 (containing blocs ABC) is copied to File2, File 2 will only contain the metadata pointing to the ABC blocks of File1.
        B. when block C of File2 is modified, then block C is copied to File2 and that C' of File2 will be a later changed version of bloc C (of File1). File2 still points and uses the unmodified blocks A and B from File1

implementation - where it can be found: Unionfs, Overlayfs, AUFS, btrfs

Relevant concept: **union mounts** - p. 111: "combine (mount) multiple directories into one location so that, to the user of the resulting directory, it appears that said directory contains the combined content (or: union) of all the participating directories."
there will be an 'upper filesystem' and a "lower filesystem"
