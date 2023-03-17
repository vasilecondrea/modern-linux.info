Networking
Contents:
basic  network terms  (HTTP SSH network stack, protocols interfaces, naming center of Internet(DNS) 
application layer and tooling (file sharing, networked fs)
advanced topics: geomapping, mananging time over network

Basics:

3 spaces:
    USER: browser, ip, ssh, dig, ping, arp, mail
    KERNEL: sockets, TCP/UDP, IP, ICMP, drivers
    HARDWARE: Network interface controller (NIC) &  wireless

!!! almost every protocol and interface is based on publicly available specifications see
https://datatracker.ietf.org/

TCP/IP stack 
the communicatoin is layered (each layer communicates with the one above and the one below ONLY)

App
|
User data
|
application layer : deals with user-facing tooling and apps (web, ssh, mail)
|
transport layer - communication between hosts through 
|                       - the Transmission Control Protocol (TCP; not secure, session-based) and 
|                       - the User Datagram Protocol (UDP) connectionless, 
Internet layer (Internet Protocol - rounting - sends packets of info between machines across network)
|
Link layer (hardware or near-hardware stuff "lowest level" - covers hardware Ethernet (cable) and WIFI)

# Link layer 

it refers to bytes, wires, electromagnetic waves, device drivers, and network interfaces

Basics: ethernet (tech with using wires to connect machines)
        wireless (protocols and methods to transport data via electromagnetic waves)
        MAC (media access control) 48-bit indentifier for hardware to identify machiens over the internet
        Interface the actual network connection

**Network interface controller**  
      - provides physical connectivity = either a wired standard—for example, the IEEE 802.3-2018 standard for Ethernet
                                        OR one of many wireless standards from the IEEE 802.11 family

        to examine it do 
        $ ifconfig
        Or the newer 
        $ ip config show 

**Address Resolution Protocol** arp - maps MAC address to IP addreses - bridges the link layer with the internet layer (sitting above)

You can use the following commands to examine it:

$ arp  OR newer $ ip neigh

$ iw dev wlp1s0 info  (wlp1s0 is the WIFI card) 
AND 
$ iw dev wlp1s0 link (gets you router/traffic related info)

**Internet layer** second layer of the TCP/IP stack - routing packets from machine to machine
                    comes with the IP (internet protocol) IPv4 and IPv6 (newer, with more addresses and one code)

IPv4 defines unique 32-bit numbers identifying a host or process acting as an endpoint in a TCP/IP communication
do 
$ ip addr show

IPv6 is a 128-bit number identifying an endpoint - we  can assign on the order of 1038 individual machines (devices).

Routing: deciding on a per-packet basis where to send a packet.

do 
$ sudo route -n (-n forces numerical IP addresses instead of 'default' and 'link-local' labels)
or the newer cmd
$ sudo ip route

Explanation of what you see
Destinatiom IP address of the destination; 0.0.0.0 means it’s unspecified or unknown,
Gateway --  gateway address.
Genmask subnet mask used.
Flags - UG means the network is up and is a gateway.
Iface - The network interface the packet is going to use (wlp4s0 or wifi, docker, etc)


**The Transport Layer** 
connection-oriented protocols and connection-less ones.

PORTS each protocol requires ports. A port is a unique 16-bit number identifying a service available at an IP address.

Types of ports
Well-known ports (from 0 to 1023) - These are for daemons such as an SSH server or a web server. 
                                requires elevated privileges (root or CAP_NET_BIND_SERVICE capability, as discussed in “Capabilities” on page 87).

Registered ports (from 1024 to 49151) - These are managed by Internet Assigned Numbers Authority (IANA) through a
                                        publicly documented process.
Ephemeral ports (from 49152 to 65535) cannot be registered. They can be used for automatically allocating a tem‐
                                        porary port (for example, if your app connects to a web server, it needs a port itself, as the other endpoint of the communication) as well as for private (say,company-internal) services.

On your own machine do

$ nmap -A localhost # scan ports on local machine

631 is an open port - ipp internet printing protocl


Transmission Control Protocol: used by a number of higher-level protocols, including HTTP and SSH

User Datagram Protocol (UDP) is a connection-less transport layer protocol allowing
you to send messages, called datagrams in UDP, without communication setups (such
as TCP does with the handshake).
UDP used by application-level protocols, such as NTP and DHCP and DNS 

Sockets endpoints in a communication, with their distinct identity: a tuple made up of the TCP or UDP port and the IP address.
you’ll only use sockets if you want to develop network-related tooling or apps,

$ ss -s # queries the ports

This shows TCP:   24 (estab 9, closed 6, orphaned 0, timewait 0) - I have 24 sockets in use

a breakdown of these sockets follows by type and IPv.


on UDP (-u says UDP sockets, -l listening sockets, -p process info)
$ ss -ulp

or lsof

lsof -c chrome -i udp | head -5 # UDP sockets Chrome uses on a machine

SO FAR it was about the lowest 3 layers: LINK, INTERNET, TRANSPORT LAYERS

NOW APPLICATION LAYER
2 items here DNS (naming system) and Application Layer Networking

# DNS
2 challanges:
we generally remember names better than we do (long) numbers
IP addresses often change.

SOLUTION locally: maintain a mapping between names and IP addresses via /etc/hosts - Network Information Center (NIC) would share a single file called HOSTS.TXT via FTP with all participating hosts.

DNS is a hierarchical naming system, and at its root sit 13 root servers that manage the records for the top-level domains.

# Application Layer Networking

three core components:

1. Uniform Resource Locators (URL) -  A URL defines both the identity and the location of a resource on the web. 
                                    (could be a static page or a process that generates content dynamically)
                                    
2. Hypertext Transfer Protocol (HTTP)  defines how am application layer protocol and how to interact with content available via URLs.
                3 concepts 
                    HTTPS methods GET, POST etc) CRUD like interface
                    Resource naming This dictates how to form URLs.
                    HTTP status codes: 2xx range for success, 3xx for redirects, 4xx for client errors, and 5xx for server errors.

3. Hyper Text Markup Language (HTML) - allows you to define page elements such as headers or inputs.


you can now create a server to make available the current folder with

python3 -m http.server # this creates a server
if you put http://localhost:8000 in your browser you can access the current folder

You can run a docker container which cotains everything in the pwd and you can access it with a curl /wget command like so:
$ docker run --name mywebserver \
--rm -d \
–v "$PWD":/usr/share/nginx/html:ro \
-p 8042:80 \
nginx:1.21

make sure the server is running in the other shell

and 
$ curl localhost:8000 OR $ wget localhost:8000





Another topic:  Secure Shell ssh

Secure Shell (SSH) is a cryptographic network protocol for securely offering network services on an unsecured network.

you can use Hausenblas' VM oin the cloud to see what ssh does but you would need to configure a .lml file file in your /.ssh


# Network File System

widely supported and used way to share files from a central location over the network is via network file system (NFS)
you would need to install the client (programm to run such sharing a files)

if you want to find about a domain do 
$ whois theWebSite.com/etc

Dynamic Host Configuration Protocol (DHCP) is a network protocol that enables automatic assignment of an IP address to a host.

Network Time Protocol (NTP) is for synchronizing clocks of computers over a network.

Other advanced tooling: 
wireshark and tshark (low-level traffic analysis), 
socat (establishes two bidirectional byte streams and enables the transferring of data between the endpoint)
geoiplookup -- map an IP to a geographic region
tunnels - VPNs
BitTorrents