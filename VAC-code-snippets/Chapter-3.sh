echo "
find what kind of shell you are using
    "
    echo $0 # this gives the name of the script you are using if run in a script; if in terminal it displays /usr/bin/bash
    file -h /bin/sh # outputs symbolic link to dash
    echo $SHELL

    echo "
        a command you enter in the shell will take its input (stdin) from your keyboard, and it will
        deliver its output (stdout) to your screen.
        example:
        
        if you do cat and the press ENTER and WHATEVER it will output "whatever"; 

        when running the script write something, it will outputed and then press CTRL + C to stopcur
    "
    cat 
    

    