Filesystems

UNIX =  “everything is file” --- most resources in Linux are indeed files.

Even devices and pseudo devices are exposed as files (like echo "Hello modern Linux users" > /dev/pts/0, prints “Hello modern Linux users” to the screen, as if a file but it is not a proper file to read). Ex 2: kernel exposes a process like PID as if it was a file

this makes it easy to learn linux: everything you do you can do as if it was file. 

content: 
relevant terms
how Linux implements the “everything is a file” abstraction. N
review special-purpose filesystems the kernel uses to expose information about processes or devices. 
regular files and filesystems, something you would typically associate with documents, data, and programs. 
compare filesystem options and discuss common operations.

relevant terms
- filesystems are hierarchilcal (like a tree) and start at root (/)
- directories as an organizational unit, allowing you to group files
- navigation with: ls (list), cd (change dir), pwd (print working dir)
- permissions are builtin
- filesystem implemented in the kernel

Drive: device such as a hard disk drive (HDD) or a solid-state drive (SSD); when emulated /dev/sda (SCSI device) or /dev/sdb (SATA device) or /dev/hda (IDE device)

Partition - logically split up drives into storage sectors - your HDD  would show up as /dev/sdb1 and /dev/sdb2.
Volume somewhat similar to a partition, but it is more flexible

Super block - When formatted, filesystems have a special section in the beginning that captures the metadata of the filesystem

Inodes store metadata about files, such as size, owner, location, date, and permissions. (NOT actual data which sits in files, directories)


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