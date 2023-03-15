echo "           the following is a syscall to getuid() which returns the real user ID of the calling process:
"
id --user

echo "           the linux version:

"
cat /proc/version 

echo "           CPU related info:"
cat /proc/cpuinfo | grep "model name"

echo "           
    PID process ID, details about the current process, limit output to 6 lines

"

cat /proc/$$/status | head -n6

