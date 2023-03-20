# Observability : 
visibility into what’s going on across the stack—from the kernel to user-facing parts.

Basics
widely used strategy: OODA loop (observe–orient–decide–act).
e.g.  slow application slow?
    - you have multiple possible reasons for this (not enough memory, too few CPU cycles, network I/O
insufficient, etc.). 
        1. measure each resource consumption.
        2. change each resource allocation individually (keeping the others unchanged) 
        3.  measure the outcome.


Observability: Assessing the internal state of a system (such as Linux) by measuring external information
Signal types: representations of state system - numeric or symbols (payload is text - comes as logs)
Source: generates signals
Destination: Where you consume, store, and further process signals - exposed to a user interface (GUI/TUI - text based interface like the blue interface of BIOS/CLI) 

## Signal types
    logs
    metrics: counter, gauges (overall available main memory), histograms
    traces

Logging 
- descrite events
- textual payload

a log comprises:
A collection of log items, messages, or lines 
Metadata or context
A format for how an individual log message is to be interpreted: Defines the log’s parts and meanings(a JSON schema. etc).



for Linux’s central log directory do:

`ls -al /var/log`
apt = apt package man
auth.log = login attempts
btmp = failed login attempts
cups = printing related logs
dpkg = logs of dpkg package man
dmesg = device driver logs use `dmesg` to read
installer = system install logs
journal = inspect with journalctl 
kern = kernel logs
lastlog = last login of all users use `laslog`
nptstats = Network time protocol logs
syslog = system logs

Syslog vs journalctl
journalctl uses a binary format to store the log items. This allows faster access and better storage footprints. 

    you can do  `journalctl -f` or the older method through syslog `tail -f /var/log/syslog` to get the same thing

## Monitoring 

capturing of system and application metrics (how long something takes or how many resources a process consumes); classic comand `uptime`; see also `free -h -w` (free comand for memory utilisation; -w says not to combine buffers with cache) or `vmstat 1` (print a line every second)

Device I/O and network 
    `iostat` monitor I/O devices `iostat -z --human`


Advanced observability follows - tracing and profiling - a little project with Prometheus and Graphana

