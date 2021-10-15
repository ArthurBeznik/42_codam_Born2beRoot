If you are using Debian 10 "Buster" or newer, AppArmor is enabled by default so you dont need to install it, but in case it is not, here's the command:
```bash
apt install apparmor apparmor-utils auditd
```
Since AppArmor is a Linux kernel module, you must enable it with the following commands:
```bash
mkdir -p /etc/default/grub.d
```
Create the file /etc/default/grub.d/apparmor.cfg with the following contents:
```bash
GRUB_CMDLINE_LINUX_DEFAULT="$GRUB_CMDLINE_LINUX_DEFAULT apparmor=1 security=apparmor"
```
Save and exit, then run:
```bash
update-grub
```
Then reboot.
