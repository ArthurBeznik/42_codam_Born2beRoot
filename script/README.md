## Monitoring script
### Commands
#### 1. Os and kernel version
```bash
hostnamectl | grep "Operating System"
hostnamectl | grep "Kernel"
```

#### 2. Physical and virtual processors
```bash
cat /proc/cpuinfo | grep "physical id"
cat /proc/cpuinfo | grep "^processor"
```

#### 3. CPU/Memory usage
```bash
grep MemTotal /proc/meminfo
```

### Useful links
- [Bash shell](https://www.2daygeek.com/bash-shell-script-view-linux-system-information/)
