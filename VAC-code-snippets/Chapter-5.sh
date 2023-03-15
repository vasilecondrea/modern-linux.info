echoe "
    how to see drivers, partitions and volumes: sda is the disk drives, I have 2 partitions (sd1 with /boot/efi  - boot partition and sd2 - this contains 1 volume)
    --exclude 7 means exclude pseudo (loop) devices
"

lsblk --exclude 7


