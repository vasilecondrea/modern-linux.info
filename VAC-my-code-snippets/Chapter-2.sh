echo "    
    this comand "lscpu" interacts with the BIOS to display info about the harware components and etc
    lspcpu
"
lscpu

echo "
    command interacts with the BIOS - on my machine it says "permission denied"
    dmidecode

"
dmidecode

echo "
    if you only want to see the architecture (x86_64 for me) do 
    uname -m
"
uname -m

echo "
    if you want to find which kernel version you using do 
    uname -srm
"
uname -srm

echo "
    see the sessions, process groups, and processes active at a particular time; 
            abbreviations:
    ps - Process Status
    TTY is the terminal type and this is what the user is logged into.
    TIME - is the total amount of the CPU both in minutes and seconds that the process has been running
    CMD - is the name of the command line that carried out the process
    PID - process id
    PGID - process group id
"
    ps -j

echo "
     A very useful tool to figure out memory-related information such as how much RAM is available to you is the /proc/meminfo interface.
     how to list the ram size:   
     grep MemTotal /proc/meminfo 

     how to see the size of the virtual memory (34TB): grep VmallocTotal /proc/meminfo

     how to see huge pages information (2MB)
     grep Huge /proc/meminfo
"
grep MemTotal /proc/meminfo
grep VmallocTotal /proc/meminfo
grep Huge /proc/meminfo

echo "
    overview of network interfaces with "ip link"
    
"
ip link 

echo "
    routing information "ip route"
"
ip route

echo " 
    overview of the devices on your Linux system
"
ls -al /sys/devices/


echo "
    strace to look behind the curtain, a tool useful for troubleshooting, for example, if you don’t have the source code of an app but want to learn what it does.

    strace ls, we ask strace to capture the syscall that ls uses.
"

strace ls