# Shells and Scripting

Two major ways to interact with Linux, from a CLI perspective: 
- interactively typing commands 
- a series of commands in a special kind of file that the shell interprets for you and in turn executes.

a terminal:
- "program that provides a textual user interface"
- "a terminal supports reading characters from the keyboard and displaying them on the screen"
- "nowadays terminals are simply apps"


shell - "a program that runs inside the terminal and acts as a command interpreter."


the shell equips every process with three default file descriptors (FDs)
stdin (FD 0) - input from keyboard (standard input)
stdout (FD 1) -  output on screen (standard output)
stderr(FD 2) - standard error   


special characters in the shell
ampersand & = executes the command in the background
backslash \ = continue command on the next line
pipe = Connects stdout of one process with the stdin of the next process -- pass data without having to save it to a file


Input and output streams or IO
Shell gives every process 3 file descriptors:
stdin -- input from keyboard
stdout -- output on the screen
stderr --


Variables - 2 types 
- environmental variables (shell wide settings; list them by typing "env" in the shell)
- variables valid in the context of the current shell (list them with "set" ); Shell variables are not inherited by subprocesses.


CREATE an env variable by using `export` to create an ACCESS an env variable use $ in front of it.
DELETE an env variable use `unset`
