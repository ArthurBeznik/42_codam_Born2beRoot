## Monitoring script
### Commands

#### 1. Os and kernel version
```bash
hostnamectl | grep "Operating System" | sed 's/Operating System: //' | sed -e 's/[ \t]*//'
hostnamectl | grep Kernel | sed 's/Kernel: //' | sed -e 's/[ \t]*//'
hostnamectl | grep Architecture | sed 's/Architecture: //' | sed -e 's/[ \t]*//'
```

#### 2. Physical and virtual processors
```bash
cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l
cat /proc/cpuinfo | grep processor | wc -l
```

#### 3. Memory/disk usage
```bash
free -m | grep Mem | awk '{printf("%d/%dMB (%.2f%%)\n", $3, $2, $3/$2 * 100.0}'
df -h / | awk 'NR==2{printf("%s/%s (%d%%)\n", $3, $2, $5)}' 
```

#### 4. CPU load
```bash
cat /proc/stat | awk '{printf("%.1f%%\n", ($2+$4)*100.0/($2+$4+$5))}' | head -1
```

#### 5. Last boot
```bash
who -b | sed -e 's/system boot//' | sed -e 's/[ \t]*//'
```

#### 6. LVM use
```bash
LVM=$( cat /etc/fstab | grep "/dev/mapper" | wc -l )
if [ $LVM -gt 0 ]
then
echo "#LVM use: yes"
else
echo "#LVM use: no"
fi
```

#### 7. TCP connections
You will need to install `net-tools` package to use `netstat`
```bash
awk </proc/net/tcp 'BEGIN{t=0};{if ($4 == "01") {t++;}};END{print t}'
or
netstat -ant | grep ESTABLISHED | wc -l
```

#### 8. User log
```bash
who | uniq | wc -l
```

#### 9. Network IP
You will need to install `net-tools` package to use `ifconfig`
```bash
apt-get install net-tools
```

```bash
hostname -I` "("`ip address | grep "link/ether" | grep -ioE '([a-z0-9]{2}:){5}..' | head -1`")"
```

#### 10. Sudo
```bash
`journalctl _COMM=sudo | grep COMMAND | uniq | wc -l`" cmd"
```

### Cron
We need to use a combination of `wall` and `cron` in order for our script to run every 10 min.

```bash
crontab -e
```
And add the following line:
```bash
*/10 * * * * bash monitoring.sh > script.txt | wall script.txt
or
*/10 * * * * /root/monitoring.sh
or
*/10 * * * * /root/monitoring.sh > /root/inf.txt | wall /root/inf.txt 
```
This tells the crontab to run a job every 10min.
```bash
sudo systemctl enable cron.service
sudo systemctl start cron.service
sudo systemctl stop cron.service
sudo systemctl restart cron.service
sudo systemctl status cron.service
```
### Create cron.log file
Edit the /etc/rsyslog.conf file, enter:
```bash
sudo nano /etc/rsyslog.conf
```
Find the line:
```bash
#cron.*                         /var/log/cron.log
```
Comment out (uncomment line) in a configuration file as follows:
```bash
cron.*                         /var/log/cron.log
```

Save and close the file. Restart rsyslog service, enter:
```bash
sudo systemctl restart rsyslog
```
And verify:
```bash
sudo systemctl status rsyslog
```
You can now see cron log entries in `/var/log/cron.log` file:
```bash
sudo tail -f /var/log/cron.log
sudo grep something /var/log/cron.log
```

### MTA
Sometimes, cron will disregard the output because we haven't set up the Mail To Address, which we don't. To disable it, add this line at the top of the crontab.
```bash
crontab -e
MAILTO=""
or add this ath the end of every cron job
>/dev/null 2>&1
```

### Useful links
- [Bash shell](https://www.2daygeek.com/bash-shell-script-view-linux-system-information/)
- [Physical CPU](https://developpaper.com/how-to-view-the-physical-cpu-logical-cpu-and-cpu-number-of-linux-servers/)
- [vCPU](https://webhostinggeeks.com/howto/how-to-display-the-number-of-processors-vcpu-on-linux-vps/)
- [Bash](https://medium.com/@david_packman/gathering-linux-system-information-using-bash-3bfaaed7755f)
- [Wall](https://www.howtoforge.com/linux-wall-command/)
- [Cron](https://www.cyberciti.biz/faq/how-do-i-add-jobs-to-cron-under-linux-or-unix-oses/)
- [Cron](https://www.cyberciti.biz/faq/linux-execute-cron-job-after-system-reboot/)
