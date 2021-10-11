# Born2beRoot

This project aims to introduce you to the wonderful world of virtualization.

***Share some love, star this repo buddy <3***

## General guidelines
- The use of **VirtualBox** (or UTM if you can’t use VirtualBox) is **mandatory**.
- You only have to turn in a `signature.txt` file at the root of your repository. You must paste in it the signature of your machine’s virtual disk. Go to Submission and peer-evaluation for more information.


# Mandatory part

## VMs
- How do VM work?
- Purpose?

### Useful links
- [THIS IS THE TUTORIAL I FOLLOWED TO INSTALL DEBIAN ON VM](https://www.brianlinkletter.com/2012/10/installing-debian-linux-in-a-virtualbox-virtual-machine/)
- [What is a VM?](https://azure.microsoft.com/en-us/overview/what-is-a-virtual-machine/#overview)
- [What is a VM?](https://www.vmware.com/topics/glossary/content/virtual-machine)


## OS: Debian
- Why this OS?
- Basic differences between Debian & CentOS?
- Differences between `aptitude` and `apt`?
- What's APPArmor?

### Useful links
- [OS - Overview](https://www.tutorialspoint.com/operating_system/os_overview.htm)
- [CentOS vs Debian](https://www.openlogic.com/blog/centos-vs-debian)
- [CentOS vs Debian](https://www.educba.com/centos-vs-debian/)
- [CentOS vs Debian](https://1gbits.com/blog/debian-vs-centos/)
- [Aptitude vs apt](https://www.tecmint.com/difference-between-apt-and-aptitude/#:~:text=Apt%2Dget%20being%20a%20lower,operation%20by%20entering%20required%20commands.)
- [APPArmor](https://www.howtogeek.com/118222/htg-explains-what-apparmor-is-and-how-it-secures-your-ubuntu-system/)


## No graphical interface
> Since it is a matter of setting up a server, you will install the minimum of services. For this reason, a graphical interface is of no user here. It is therefore forbidden to install X.org or any other equivalent graphics server.

Deselect **Desktop environment** and **GNOME** from **software selection** during the install in order to get a non-GUI Debian install.

X.org = debian.org ??

## 2 encrypted partitions
At least, using LVM. Below is an example of an expected partitioning:
`lsblk`
<p align=center>
<img width="524" alt="Screen Shot 2021-10-10 at 4 03 40 PM" src="https://user-images.githubusercontent.com/43698378/136699027-5a77000c-c0f0-4b78-8919-98be71d3e2b9.png">
</p>

### Useful links
- [Manually partition Debian](https://unix.stackexchange.com/questions/577379/how-can-i-install-debian-with-full-disk-encryption-and-a-custom-sized-swapfile)


## SSH service
- Running on port 4242.
- For security reasons, it must not be possible to connect using SSH as root.
- **During eval:**
  - SSH service properly installed.
  - working properly.
  - explain what SSH is and the value using it.
  - use SSH in order to log in with the newly created user.
    - you can use a key or a simple password.
    - make sure you cannot use SSH with the "root" user.

### Prerequisites
In order to install a SSH server on Ubuntu or Debian, you need to have **sudo privileges on your server**.

To check whether you have sudo privileges or not, you can run:
```bash
groups
```
and verify if "sudo" is one of the entries.

To check that this is actually the case, you can run the `ssh` command with the `-V` option.
```bash
ssh -V
```

**Be careful** : this information does not mean that you have a SSH server running on your server, **it only means that you are currently able to connect as a client to SSH servers.**

### Installation
First of all, as always, make sure that your current packages are up to date for security purposes.
```bash
sudo apt-get update
```

Now that all packages are up-to-date, run the `apt-get install` command in order to install OpenSSH.
```bash
sudo apt-get install openssh-server
```

This command should run a complete installation of an OpenSSH server.

From steps displayed on your console, you should see the following details :

- A configuration file is created in the `/etc/ssh` folder named sshd_config;
- Symbolic links are created : one named sshd.service (your systemd service) and one in the multi-user target (to boot SSH when you log in).

As stated earlier, a SSH service was created and you can check that it is actually up and running.
```bash
sudo systemctl status sshd
```

By default, your SSH server is listening on port 22 (which is the default SSH port).

### Configuration
Before giving any access to your users, it is important for your SSH server to be correctly configured.

If it is done badly, you are at risk when it comes to SSH attackes and your entire infrastructure can be compromised easily.

By default, SSH configuration files are located in the `/etc/ssh` folder.

In this directory, you are going to find many different files and folders, but the most important ones are :

- **ssh_config** : is used in order to configure **SSH clients**. It means that it defines rules that are applied everytime you use SSH to connect to a remote host or to transfer files between hosts;
- **sshd_config** : is used in order to configure your **SSH server**. It is used for example to define the reachable SSH port or to deny specific users from communicating with your server.

#### 1. Changing SSH default port
The first step towards running a secure SSH server is to **change the default assigned by the OpenSSH server**.

Edit the config file with
```bash
sudo vi /etc/ssh/sshd_config
```
**Warning:** search how to use `sudo vi`, it's **VERY** confusing to use!

Look for the following line.
```bash
#Port 22

Port 4242
```
**Uncomment the line you edit**, or it will not consider the changes.

Make sure to change your port to one that is not reserved for other protocols. Be careful when you change your default SSH port, **you will have to specify it when connecting to it**.

#### 2. Disabling Root Login on your SSH server
By default, on recent distributions, root login is set to “prohibit-password”.

This option means that all interactive authentication methods are banned, allowing only public keys to be used.

In short, you need to setup SSH keys and to use them in order to connect as root.

However, even if we connect without a password, root login is not recommended : if keys are compromised, your entire host is compromised.

As a consequence, you can set this option to “no” in order to restrict it completely.

```bash
#PermitRootLogin prohibit-password

PermitRootLogin no
```

#### 3. Restarting your SSH server to apply changes
In order for the changes to be applied, you need to restart your SSH server.
```bash
sudo systemctl restart sshd

sudo systemctl status sshd
```

When restarting it, make sure that the server is correctly listening on the custom port your specified earlier.

This information is available on the last lines of the systemd status command.

#### 4. Connecting to your SSH server
In order to connect to your SSH server, you are going to use the ssh command with the following syntax
```bash
$ ssh -p <port> <username>@<ip_address>or<hostname>
```

If you are connecting over a LAN network, make sure to get the local IP address of your machine with the following command
```bash
$ ip a
```

For example, I would run the following command
```bash
$ ssh -p 4242 abeznik@abeznik42
```
You will be asked to provide your password and to certify that the authenticity of the server is correct.

#### 5. Exiting your SSH server
In order to exit from your SSH server, you can hit Ctrl + D or type `logout` and your connection will be terminated.

#### 6. Disabling your SSH server
In order to disable your SSH server, run the following command
```bash
sudo systemctl stop sshd

sudo systemctl status sshd
```
From there, your SSH server **won’t be accessible anymore**.

### Useful links
- [Install & config SSH server](https://devconnected.com/how-to-install-and-enable-ssh-server-on-ubuntu-20-04/)
- [SSH man](https://linuxcommand.org/lc3_man_pages/ssh1.html)
- [Change SSH port](https://www.cyberciti.biz/faq/howto-change-ssh-port-on-linux-or-unix-server/) 


## UFW firewall
- Configure OS with UFW (Uncomplicated) FireWall.
- Leave only port 4242 open.
- **During eval:**
  - "UFW" program properly installed.
  - working properly.
  - explain what UFW is and the value using it.
  - list active rules in UFW, a rule must exist for port 4242.
  - add new rule to open port 8080.
    - check that is has been added by listing the active rules.
  - delete new rule.

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


## Hostname
Hostname of the VM must be your _login ending with 42_ (*abeznik42*). 
- **During eval:**
  - modify hostname, restart machine, hostname should be updated.
  - show partitions of the VM
  - compare output with example given

### Useful links
- [Change hostname Debian 10 Linux](https://www.cyberciti.biz/faq/how-to-change-hostname-on-debian-10-linux/)
- [Change hostname Debian 10 Linux](https://www.cyberciti.biz/faq/debian-change-hostname-permanently/)
- [Change hostname Debian 10 Linux](https://linuxize.com/post/how-to-change-hostname-on-debian-10/)


## Strong password policy
- Password has to expire every 30 days.
- Minimum number of days allowed before modification of a password will be set to 2.
- User has to receive a warning message 7 days before their password expires.
- Password must:
  - be at least 10 characters long
  - contain an uppercase letter and number
  - **not** contain more than 3 consecutive identical characters
  - **not** include the name of the user
  - **does not apply to root password**: have at least 7 character that are **not** part of the former password
  - **does apply to root password**: after setting up config files, you will have to change all the passwords of the acounts present on the VM.
  - **During eval:**
     - explain advantages of this password policy.
     - explain advantages and disadvantages of its implementation.

### Useful links
- [Set password policy in Linux](https://ostechnix.com/how-to-set-password-policies-in-linux/)
- [Set strong password policy](https://computingforgeeks.com/enforce-strong-user-password-policy-ubuntu-debian/)
- [Force users to use strong passwords in Debian](https://ostechnix.com/force-users-use-strong-passwords-debian-ubuntu/)


## `sudo` strict rules
- Max 3 attempts on authentication using `sudo` in event of incorrect password.
- Display custom message on error due to incorrect password when using `sudo`.
- Archive each action using `sudo`, both inputs and outputs. Log file to be saved in `/var/log/sudo/` folder.
- `TTY` mode has to be enabled for security reasons.
- For security reasons the paths that can be used by `sudo` must be restricted. Example: `/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin`
- **During eval:**
  - `sudo` properly installed.
  - assign new user to the `sudo` group.
  - explain value and operation of `sudo` using examples of your choice.
  - verify that `/var/log/sudo/` folder exists and has at least one file.
    - check the contents of the files in this folder.
    - should see a history of commands used with `sudo`.
  - run command via `sudo` and see if the files in `/var/log/sudo/` folder have been updated.


### Install
On a fresh Debian install `sudo` does not work by default. You need to add your user to the `sudo` group in order to get the command working.

#### 1. Get root first

If you are already logged in on another user, use the `su` command.

Enter your root password that you set during installation to get the root prompt.

#### 2. Add user to the sudo group

This will add your user to the sudo group.

`adduser <username> sudo`

After this start a new shell or logout and login again. Try running the commands with sudo now and they will surely work with your own user.

Additionally in some cases like the minimal installations of Debian, the sudo program/command itself might not be present. In that case you will also need to install sudo.

`apt install sudo`

### Configuration

Always edit sudo file using `sudo visudo`.

#### 1. Set a Secure PATH

This is the path used for every command run with sudo, it has two importances:

- Used when a system administrator does not trust sudo users to have a secure PATH environment variable
- To separate “root path” and “user path”, only users defined by exempt_group are not affected by this setting.

To set it, add the line:

``` bash
Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
```

#### 2. Enable sudo on TTY User Login Session

To enable sudo to be invoked from a real tty but not through methods such as cron or cgi-bin scripts, add the line:

```bash
Defaults  requiretty 
```

#### 3. Create a sudo Log File

By default, sudo logs through syslog(3). However, to specify a custom log file, use the logfile parameter like so:

```bash
Defaults  logfile="/var/log/sudo/sudo.log"
```

To log hostname and the four-digit year in the custom log file, use log_host and log_year parameters respectively as follows:

```bash
Defaults  log_host, log_year, logfile="/var/log/sudo.log"
```

#### 4. Log sudo Command Input/Output

The log_input and log_output parameters enable sudo to run a command in pseudo-tty and log all user input and all output sent to the screen receptively.

The default I/O log directory is /var/log/sudo-io, and if there is a session sequence number, it is stored in this directory. You can specify a custom directory through the iolog_dir parameter.

``` bash
Defaults   log_input, log_output
```

#### 5. Display Custom Message on wrong sudo password

When a user enters a wrong password, a certain message is displayed on the command line. The default message is “sorry, try again”, you can modify the message using the badpass_message parameter as follows:

``` bash
Defaults  badpass_message="Password is wrong, please try again"
```

#### 6. Increase sudo password Tries Limit

The parameter passwd_tries is used to specify the number of times a user can try to enter a password.

The default value is 3:

```bash
Defaults   passwd_tries=3 
```

### Useful links
- [sudo man](https://www.sudo.ws/man/1.8.13/sudo.man.html)
- [Adding a user to sudoers](https://devconnected.com/how-to-add-user-to-sudoers-on-ubuntu-20-04/)
- [Let sudo insult you](https://www.tecmint.com/sudo-insult-when-enter-wrong-password/)
- [Configs for sudo](https://www.tecmint.com/sudoers-configurations-for-setting-sudo-in-linux/)


## User
In addition to the root user, a user with your login as username has to be present. And has to belong to `sudo` and `user42` groups.
- **During eval:**
  - create new user.
  - assign password of choice (respecting rules) + explain how these rules were set up.
  - create a group and assign new user to it.

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

### 3. Adding user to group
```bash
usermod -aG <groupname> <username>
```
-aG is the option that tells the command to add the user to a specific group. The -a option adds a user to the group without removing it from current groups. The -G option states the group where to add the user. In this case, these two options always go together.

To verify the new Debian sudo user was added to the group, run the command:
```bash
getent group sudo
```

### Useful links
- [Create a sudo user Debian](https://phoenixnap.com/kb/create-a-sudo-user-on-debian)


## Script monitoring
- `monitoring.sh` developped in `bash`.
- At server startup, the script will display some information on all terminals every 10min (see `wall`), banner is optional, no error must be visible.
- Following information must be displayed:
  - Architecture of your OS and its kernel version
  - The number of physical processors.
  - The number of virtual processors.
  - The current available RAM on your server and its utilization rate as a percentage.
  - The current available memory on your server and its utilization rate as a percentage.
  - The current utilization rate of your processors as a percentage.
  - The date and time of the last reboot.
  - Whether LVM is active or not.
  - The number of active connections.
  - The number of users using the server.
  - The IPv4 address of your server and its MAC (Media Access Control) address.
  - The number of commands executed with the `sudo` program.
- **During eval:**
  - how the script works.
  - what "cron" is.
  - how it was set up so that it runs every 10min.
  - ensure that this script runs every minute, make sure that the script runs with dynamic values correctly.
  - make the script stop running when the server has started up, without modifying the script itself. (you'll have to restart one last time)
  - at startup, check if the script still exists in the same place, rights have remained unchanged, and not been modified.
- Example below:
<p align=center>
  <img width="597" alt="Screen Shot 2021-10-10 at 5 11 35 PM" src="https://user-images.githubusercontent.com/43698378/136701814-cc671d24-9bd5-4d6f-8d89-bb2c19d4d6e9.png">
</p>

## Check some of the subject’s requirements:
<p align=center>
<img width="636" alt="Screen Shot 2021-10-10 at 5 12 50 PM" src="https://user-images.githubusercontent.com/43698378/136701852-a3309cc5-fae6-4d6e-9ca5-939b0ad138f2.png">
</p>

Commands used:
```bash
head -n 2 /etc/os-release

/usr/sbin/aa-status

ss -tunlp

/usr/sbin/ufw status
```

# That's all folks!
