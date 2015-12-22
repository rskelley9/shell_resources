Aliases
-------

```
# Get local computer IP address for LAN network
alias myip="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"

# Public facing ip
alias myippub='wget -qO- icanhazip.com'

# Get mac address for en0
alias whatsmymac='ifconfig en0'

# Network interface card
alias disconnectwifi='airport -z'
alias sudonicup='sudo ifconfig en0 up'
alias sudonicdown='sudo ifconfig en0 down'

# Nmap and Scanning
alias nmaplist='nmap --iflist'
alias netusers='arp -a -n'
alias netr='netstat -r'

# Get server header
alias header='curl -I'

#Process URL
urldecode_json='xargs -0 node -e "console.log(decodeURIComponent(process.argv[1]))"'
urlencode_json='xargs -0 node -e "console.log(encodeURIComponent(process.argv[1]))"'

#List programs with open ports and connections
alias lsnetservices='lsof -i'

# IfConfig
alias ifa='ifconfig -a'
```

Other Commands
--------------

```
# Sniff traffic on wlan0
sudo tcpdump -i wlan0 -n ip | awk '{ print gensub(/(.*)\..*/,"\\1","g",$3), $4, gensub(/(.*)\..*/,"\\1","g",$5) }' | awk -F " > " '{print $1"\n"$2}'

# Sniff traffic on remote server with ssh, tcpdump and wireshark
ssh root@000.00.000.00 tcpdump -U -s0 -w - "port !22" | wireshark -k -i -

# Capture packet going to specific IP
tcpdump -i any dst host

# List the hosts on your LAN, their MAC addresses and IP's and then count them
$ arp -an | tee >(wc -l)
```
