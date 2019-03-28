#!/usr/bin/bash

iptables -F

iptables -A INPUT -s 127.0.0.1/32 -p tcp -j ACCEPT

iptables -A OUTPUT -d 127.0.0.1/32 -p tcp -j ACCEPT

iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -A INPUT -p icmp -j ACCEPT

iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT

iptables -A INPUT -j REJECT --reject-with icmp-host-prohibited

iptables -A INPUT -i lo -j ACCEPT

iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT

iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT

iptables -A INPUT -p tcp -m tcp --dport 25 -j ACCEPT

iptables -A INPUT -p tcp -m tcp --dport 465 -j ACCEPT

iptables -A INPUT -s 127.0.0.1/32 -p tcp -j ACCEPT

iptables -A FORWARD -j REJECT --reject-with icmp-host-prohibited

iptables -A OUTPUT -d 127.0.0.1/32 -p tcp -j ACCEPT

iptables-save > /etc/sysconfig/iptables

printf "Ip tables rules updated and saved."

echo

echo "Restarting Iptables"

service iptables restart

echo "Finished"
