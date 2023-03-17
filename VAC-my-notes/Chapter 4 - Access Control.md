Topic: Users and controlling access to resources and files


    specifically
    - the fundamental relationship between users, processes, and files, from an access perspective
    - the definition of a Linux user 
    - how to manage users either locally or alternatively from a central place.
    - file permissions
    - how to control access to files
    - capabilities, seccomp profiles, and ACLs.
    - security good practices

    Linux is a multiuser operating system 
    - Users launch process, own files (process: a file that the kernel has loaded into main memory and runs)
    - files - have owners, user creates a file, the file is owned by that user
    - process - use files for communication and persistency 

    USERS - 2 types
        **system users** (system accounts) -- programs (sometimes called daemons) use these types of accounts to run background processes. They can be either part of the OS (ex, networking see sshd) or applications (mysql)
        **regular users** human users interacting with the shell

    Linux identifies users via a user ID (UID)

        - a special kind of user with the UID 0, usually called **root** (no restrictions apply) - AVOID working as root (too much power,  a mistake can destroy the system)

    SANDBOXING: access to resources

    UID 0                       root
    UID 1 to 999                system users - programs of linux
    UID 65534                   nobody ---    mapping remote users to some wellknown Id - (see network file system)
    UID 1000 to 65533 and 65536 to 4294967294  regular users

    to see what UID you have type **id -u**

    Types of access control: 

    - discretionary AC(DAC) - restrict access to resources based on the Id of the user. 
    - mandatory AC - users are given a security clearance = a user has access to a clearance level equal and lower to their own

    THAT IS: you are either a superuser who has the power to change everything or you are a normal user with limited access.


    Centralized User Management:
    If you have more than one machine or server for which you have to manage users —  few approaches available to you:

    - lightweight directory based access control - LDAP: you can use **Keycloak** or outsource to cloud **Azure Active Directroy**
    - via a network - see Kerberos
    - user config management systems: Ansible, Chef, Puppet, SaltStack


    Persmissions: 
    - File permission:  everything is a file in Linux, more or less - three permissions: USER / OWNER, GROUP (of users), OTHER (everyone else)
    - Types of access: read, write, execute r-w-x
    - other type of access: 
            s - setuid/setid permission to an executable file
            t - only for directories - prevents non-root users from deleting files in it, unless user owns the file

After doing "ls -all" in this file, one line is
-rw-rw-r-- 1 v_condrea v_condrea    137 Feb 10 14:43  _config.yml 

                                                       name of file
                                         last modified

                                   file size in bites

                        group it belog to
             file owner
           no. of hard links (1 here)

the first section: 
-   rw-    rw-   r-- 
                permission for others (only read)
           permission for group (read and write)
    permission for file owner (idem)
type file (- means regular file, d means directory, l symbolic link, s socket, ? unknown file type)
 
 File permissions: 
 --- means no permission
 rwx means read, write,execute
 
 Examples of permission by no. --- most relevant are 
 - 644 (r/w for owner, r for anybody else)
 - 750 make it excutable ($ chmod 750 greeter.sh mankes greeter.sh executable)
 - 755 full access for owner, r/e for the others
 - 700 full access for owner, none for others
 - 400 read only by its owner

 Change permission with *chmod* either with permission settings (eg. 644) or shortcut (+x this means 'make it executable')


if I do:

touch masktest # creates a file

ls -al masktest # output : -rw-rw-r-- 1 v_condrea v_condrea 0 Mar 15 09:44 masktest (regular file, owner and group have rw privileges, others only read)

chmod +x masktest # this makes the file excutable (you can run the file)

ls -al masktest # output : -rwxrwxr-x 1 v_condrea v_condrea 0 Mar 15 09:44 masktest (regular file, owner and group have rw and execute privileges; others read and execute)

Change owner of a file:

touch myfile 
ls -al myfile

then get

-rw-rw-r-- 1 v_condrea v_condrea 0 Mar 14 10:22 myfile

after 

sudo chwon root myfile # this changes owner (one can do chgrp - to chage group)

-rw-rw-r-- 1 root v_condrea 0 Mar 14 10:22 myfile

ROOT owns the file now.
                


Capabilities:
In Linux  the root user has no restrictions when running processes.  
kernel only distinguishes between:
    -   Privileged processes, bypassing the kernel permission checks, with an effective UID of 0 (aka root)
    -   Unprivileged processes, with a nonzero effective UID, for which the kernel does permission checks
    capabilities are generally relevant only for system-level tasks --- most of the time you won’t necessarily depend on them.