echo "    
    this comand "lscpu" interacts with the BIOS to display info about the harware components and etc
"
lscpu

echo "
    demidecode command interacts with the BIOS - on my machine it says "permission denied"
"
dmidecode

echo "
    if you only want to see the architecture (x86_64 for me) do uname -m
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
     how to list the ram size:   grep MemTotal /proc/meminfo (8GB)
     how to see the size of the virtual memory (34TB)
     how to see huge pages information (2MB)
"
grep MemTotal /proc/meminfo
grep VmallocTotal /proc/meminfo
grep Huge /proc/meminfo

