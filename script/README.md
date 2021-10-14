## Monitoring script
### Commands

#### 1. Os and kernel version
```bash
hostnamectl | grep "Operating System"
hostnamectl | grep "Kernel"
```

#### 2. Physical and virtual processors
```bash
cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l
cat /proc/cpuinfo | grep processor | wc -l
```

#### 3. Memory/disk usage
```bash
free | grep Mem | awk '{printf("Memory usage: %d/%dMB (%.2f%%)\n", $3, $4, $3/$2 * 100.0}'
df -h ?
```

#### 4. CPU load
```bash
cat /proc/stat | awk '{printf("CPU load: %.1f%%\n", ($2+$4)*100.0/($2+$4+$5))}' | head -1
```

#### 5. Last boot
```bash
who -b | sed -e 's:\<system boot\>//g' | sed -e 's/[ \t]*//'
```

#### 6. LVM use
```bash
lvscan ?
```

#### 7. TCP connections
```bash
awk </proc/net/tcp 'BEGIN{t=0};{if ($4 == "01") {t++;}};END{print t}'
```

#### 8. User log
```bash
who | uniq | wc -l
```

#### 9. Network IP
```bash
hostname -I
ip addr | grep "link/ether" |
```

#### 10. Sudo
```bash
sudo journalctl _COMM=sudo | grep COMMAND | uniq | wc -l
```

### Configuration
We need to use a combination of `wall` and `cron` in order for our script to run every 10 min.

```bash
crontab -e
```
And add the following line:
```bash
*/10 * * * * bash monitoring.sh >> script.txt | wall script.txt
or
*/10 * * * * /root/monitoring.sh
```
This tells the crontab to run a job every 10min.

### Useful links
- [Bash shell](https://www.2daygeek.com/bash-shell-script-view-linux-system-information/)
- [Physical CPU](https://developpaper.com/how-to-view-the-physical-cpu-logical-cpu-and-cpu-number-of-linux-servers/)
- [vCPU](https://webhostinggeeks.com/howto/how-to-display-the-number-of-processors-vcpu-on-linux-vps/)
- [Bash](https://medium.com/@david_packman/gathering-linux-system-information-using-bash-3bfaaed7755f)
- [Wall](https://www.howtoforge.com/linux-wall-command/)
- [Cron](https://www.cyberciti.biz/faq/how-do-i-add-jobs-to-cron-under-linux-or-unix-oses/)
- [Cron](https://www.cyberciti.biz/faq/linux-execute-cron-job-after-system-reboot/)