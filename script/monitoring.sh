#!/bin/sh

echo "#Architecture: "`hostnamectl | grep "Operating System" | sed 's/Operating System: //' | sed -e 's/[ \t]*//'` `hostnamectl | grep Kernel | sed 's/Kernel: //' | sed -e 's/[ \t]*//'` `hostnamectl | grep Architecture: //' | sed -e 's/[ \t]*//'`

echo "#CPU physical: "`cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l`
echo "#vCPU: "`cat /proc/cpuinfo | grep processor | wc -l`

echo "#Memory Usage: "`free | grep Mem | awk '{printf("%d/%dMB (%.2f%%)\n", $3, $4, $3/$2 * 100.0}'`
echo "#Disk Usage: "

echo "#CPU load: "`cat /proc/stat | awk '{printf("%.1f%%\n", ($2+$4)*100.0/($2+$4+$5))}' | head -1`

echo "#Last boot: "`who -b | sed -e 's/system boot//' | sed -e 's/[ \t]*//'`

echo "#LVM use: "

echo "#TCP connections: "`awk </proc/net/tcp 'BEGIN{t=0};{if ($4 == "01") {t++;}};END{print t}'`

echo "#User Log: "`who | uniq | wc -l`

echo "#Network: IP "`hostname -I`  `ip addr | grep "link/ether" | cut -c 1,16- | cut -c -18,19`

echo "Sudo: "`journalctl _COMM=sudo | grep COMMAND | uniq | wc -l`
