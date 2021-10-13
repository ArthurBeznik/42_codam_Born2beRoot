## Changing hostname
### Configuration
Login to your server
```bash
ssh -p <port> <user>@<hostname>
```

Display the current hostname:
```bash
hostnamectl
```

Become root with `su`

To set the hostname to <server_name>, run:
```bash
hostnamectl set-hostname <server_name>
```
Edit the file `/etc/hosts` and replace all occurences of previous server_name by the new server name: 
```bash
vi /etc/hosts
```

Verify it by running the `hostnamectl` command again.


### Useful links
- [Change hostname Debian 10 Linux](https://www.cyberciti.biz/faq/how-to-change-hostname-on-debian-10-linux/)
- [Change hostname Debian 10 Linux](https://www.cyberciti.biz/faq/debian-change-hostname-permanently/)
- [Change hostname Debian 10 Linux](https://linuxize.com/post/how-to-change-hostname-on-debian-10/)
