# scan local net for other comps

for ip in 192.168.1.{1..10}; do  # generate ips
    ping -c 1 -t 1 192.168.1.1 > /dev/null 2> /dev/null  # ping each
    if [ $? -eq 0 ]; then  # check exit code
        echo "${ip} is up" # display the output
    else
        echo "${ip} is down"
    fi
done