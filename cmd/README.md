## Useful Commands
### User related
- Change user
```bash
su <user_name>
```

- Root user
```bash
su
```

- Connected users
```bash
who
```

### Server related
- Restart
```bash
ssh -t -p 4242 <user_name>@<server_name> 'sudo reboot'
```

- Remove fnkcin dhcp
```bash
apt list --installed | grep dhcp
```
found:
```bash
isc-dhcp-client
isc-dhcp-common
```
I just disabled both and that fixed it using:
```bash
sudo apt-get remove dhcp-client
sudo apt-get remove dhcp-common
```
