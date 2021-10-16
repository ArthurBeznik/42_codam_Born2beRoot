## Users, groups, ...
To know in which groups a user is, run:
```bash
groups
or
groups <user_name>
```

### 1. Adding user
```bash
adduser <username>
```

To list all users account, run
```bash
getent passwd
or
cat /etc/passwd
```

### 2. Creating group
```bash
groupadd <groupname>
```

To list all groups, run
```bash
getent group
or
cat /etc/group
```

### 3. Adding user to group
```bash
usermod -aG <groupname> <username>
```
-aG is the option that tells the command to add the user to a specific group. The -a option adds a user to the group without removing it from current groups. The -G option states the group where to add the user. In this case, these two options always go together.

To verify the new Debian sudo user was added to the group, run the command:
```bash
getent group sudo
```

### 4. Deleting user
Log in to the server via SSH.
```bash
ssh -p <port> <user_name>@<hostname>
```

Switch to the root user using `su`.

Delete user:
```bash
userdel <user_name>
or
userdel -r <user_name> to remove the user's home folder and email folder.
```

### Useful links
- [Create a sudo user Debian](https://phoenixnap.com/kb/create-a-sudo-user-on-debian)
