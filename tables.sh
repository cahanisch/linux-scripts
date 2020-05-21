#!/bin/bash

#So I don't get duplicates if I run this script again
iptables -F

#For remote management
#Accept SSH in
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT


#For user access to our webserver
#Accept HTTP\HTTPS in
iptables -A INPUT -p tcp -m conntrack --ctstate NEW,ESTABLISHED --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m conntrack --ctstate NEW,ESTABLISHED --dport 443 -j ACCEPT
#Allow only established HTTP\HTTPS connections out
iptables -A OUTPUT -p tcp -m conntrack --ctstate ESTABLISHED --sport 80 -j ACCEPT
iptables -A OUTPUT -p tcp -m conntrack --ctstate ESTABLISHED --sport 443 -j ACCEPT


#Allows use to resolve servers to grab updates
#Accept DNS out to resolve names of update servers
iptables -A OUTPUT -p udp -m conntrack --ctstate NEW,ESTABLISHED --sport 53 -j ACCEPT
#Allow us to see what the DNS servers are returning to us
iptables -A INPUT -p udp -m conntrack --ctstate ESTABLISHED --dport 53 -j ACCEPT
#Accept FTP out to allow us to get updates over ftp (apt uses ftp, http, or https depending on source)
iptables -A OUTPUT -p tcp -m conntrack --ctstate NEW,ESTABLISHED --sport 21 -j ACCEPT
#Allow established connections to continue
iptables -A INPUT -p tcp -m conntrack --ctstate ESTABLISHED --dport 21 -j ACCEPT
#Accept HTTP\HTTPS out (I learned the hard way that I need to do this to allow my server to get updates)
iptables -A OUTPUT -p tcp -m conntrack --ctstate NEW,ESTABLISHED --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp -m conntrack --ctstate NEW,ESTABLISHED --dport 443 -j ACCEPT
#Allow only established HTTP\HTTPS back in
iptables -A INPUT -p tcp -m conntrack --ctstate ESTABLISHED --sport 80 -j ACCEPT
iptables -A INPUT -p tcp -m conntrack --ctstate ESTABLISHED --sport 443 -j ACCEPT


#Extra stuff to drop invalid packets and other stuff
#Drops invalid packets
iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
#Changes Default policy to drop
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP