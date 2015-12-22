echo -e "\nScan LAN for other computers.\n"
if [ -n ""$@"" ];  then
    ip=$(/sbin/ifconfig $1 | grep 'inet ' | awk '{ print $2}' | cut -d"." -f1,2,3 )
    nmap -sP $ip.1-255
else
    echo "Enter Interface parameter ex:"
    echo -e "\t./scannetwork.sh $(ifconfig -lu | awk '{print $2}')\n"

    echo "Avail interfaces: "
    for i in $(ifconfig -lu)
    do
        echo -e "\033[32m \t $i \033[39;49m"
    done

    echo "Down interfaces: "
    for i in $(ifconfig -ld)
    do
        echo -e "\033[31m \t $i \033[39;49m"
    done
    echo
fi