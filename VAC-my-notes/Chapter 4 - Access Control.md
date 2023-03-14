Topic: Users and controlling access to resources in general and files


    specifically
    - the fundamental relationship between users, processes, and files, from an access perspective
    - the definition of a Linux user 
    - how to manage users either locally or alternatively from a central place.
    - file permissions
    - how to control access to files
    - capabilities, seccomp profiles, and ACLs.
    - security good practices

    Linux: multiuser operating system 
    - Users launch process, own files (process: a file that the kernel has loaded into main memory and runs)
    - files - have owners, user creates a file, the file is owned by that user
    - process - use files for communication and persistency 

    SANDBOXING: access to resources

    Types of access control: 

    - discretionary AC(DAC) - restrict access to resources based on the Id of the user. 
    - mandatory AC - users are given a security clearance = a user has access to a clearance level equal and lower to their own

    TAHT IS: you are either a superuser who has the power to change everything or you are a normal user with limited access.


    Centralized User Management:
    If you have more than one machine or server for which you have to manage users—  few approaches available to you:

    - lightweight directory based access control - LDAP: you can use **Keycloak** or outsource to cloud **Azure Active Directroy**
    - via a network - see Kerberos
    - user config management systems: Ansible, Chef, Puppet, SaltStack


    Persmissions: 
    - File permission:  everything is a file in Linux, more or less - three permissoins: USER, GROUP (of users), OTHER (everyone else)
    - Types of access: read, write, execute r-w-x
    - other type of access: 
            s - setuid/setid permission to an executable file
            t - only for directories - prevents nonroot users from deleting files in it, unless user owns the file

After doing "ls -all" in this file, first line is
-rw-rw-r-- 1 v_condrea v_condrea    137 Feb 10 14:43  _config.ym  
                                                       name of file
                                         last modified
                                   file size in bites
                        group it belog to
             file owner
           no of hard links (1 here)

the first section: 
-   rw-    rw-   r-- 
                perm for others
           perm for group
    permision for file owner
type file (- means regular file, d means directory, l symbolic link, s socket, ? unknown file type)
 
 File permissions: 
 --- means no permission
 rwx means read, write,execute
 
 Examples of permission by no. most relevant are 
 - 644 (r/w for owner, r for anybody else) a
 - 755 full access for owner, r/e for the others
 - 700 full access for owner, none for others
 - 400 read only by its owner

 Change permission with *chmod* either with permission settings (eg. 644) or shortcut (+x this means 'make it executable)
if I do:

touch myfile
ls -al myfile

then get

-rw-rw-r-- 1 v_condrea v_condrea 0 Mar 14 10:22 myfile

after 

sudo chwon root myfile - this changes owner (chown; one can do chgrp - to chage group)

-rw-rw-r-- 1 root v_condrea 0 Mar 14 10:22 myfile

ROOT owns the file now.
                


capabilities:
In Linux  the root user has no restrictions when running processes.  
kernel only distinguishes between:
    -   Privileged processes, bypassing the kernel permission checks, with an effective UID of 0 (aka root)
    -   Unprivileged processes, with a nonzero effective UID, for which the kernel does permission checks
    capabilities are generally relevant only for system-level tasks --- most of the time you won’t necessarily depend on them.