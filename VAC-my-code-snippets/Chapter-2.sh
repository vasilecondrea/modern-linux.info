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