## Strong password policy
### Interesting discussion over strong password policy
[Strong pass policy](https://security.stackexchange.com/questions/139702/does-preventing-consecutive-characters-in-a-password-actually-increase-security)

### Password complexity
Usually, the password and authentication-related configuration files will be stored in /etc/pam.d/ location in DEB based operating systems.

First install password quality checking library using command:
```bash
sudo apt-get install libpam-pwquality
```

Then, edit /etc/pam.d/common-password file:
```bash
sudo nano /etc/pam.d/common-password
```

Search for this line
```bash
password        requisite                       pam_pwquality.so [...]
```
and add the following:
```bash
minlen=10 difok=7 ucredit=1 dcredit=1 reject_username maxrepeat=3
```

### Password expiration period

To set an expiration period policy, edit:
```bash
sudo vi /etc/login.defs
```

Set the values as is:
```
PASS_MAX_DAYS 30
PASS_MIN_DAYS 2
PASS_WARN_AGE 7
```

### Useful links
- [Set password policy in Linux](https://ostechnix.com/how-to-set-password-policies-in-linux/)
- [Set strong password policy](https://computingforgeeks.com/enforce-strong-user-password-policy-ubuntu-debian/)
- [Force users to use strong passwords in Debian](https://ostechnix.com/force-users-use-strong-passwords-debian-ubuntu/)
- [Enforce pass complexity](https://www.networkworld.com/article/2726217/how-to-enforce-password-complexity-on-linux.html)
