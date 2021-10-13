## UFW installation and configuration
### Installation
Install UFW with
```bash
sudo apt install ufw
```

You can now check the status of the UFW firewall by running
```bash
sudo ufw status
```

And enable it with
```bash
sudo ufw enable
```

### Configuration
If you are using UFW as a default firewall on your Ubuntu 20.04 host, it is likely that you need to allow SSH connections on your host.

#### 1. Enable SSH connections
To enable SSH connections on your host, run the following command:
```bash
sudo ufw allow ssh
```
And to see the existing rules:
```bash
sudo ufw status
```

#### 2. Allow/deny rules
Allow
```bash
sudo ufw allow <port>/<optional: protocol>
```

Delete
```bash
sudo ufw delete <rule_number_here>
or
sudo ufw delete allow/deny <port>/<optional: protocol>
```

We need to allow incoming tcp and udp packet on port 4242:
```bash
sudo ufw allow 4242
```

We also need to delete the default 22/tcp rule
```bash
sudo ufw status numbered

sudo ufw delete <rule_number_here>
or
sudo ufw delete allow 22/tcp
```
You will need to confirm `y` when prompted to delete the rule from your system and verify again using `sudo ufw status`

### Useful links
- [UFW Debian](https://wiki.debian.org/Uncomplicated%20Firewall%20%28ufw%29)
- [Set up UFW on Debian 9](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-debian-9)
- [Set up UFW on Debian 10](https://www.tecmint.com/setup-ufw-firewall-on-ubuntu-and-debian/)
- [Set up UFW on Debian 10](https://linuxize.com/post/how-to-setup-a-firewall-with-ufw-on-debian-10/)
