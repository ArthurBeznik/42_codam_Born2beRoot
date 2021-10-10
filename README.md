# Born2beRoot

This project aims to introduce you to the wonderful world of virtualization.

## General guidelines

- The use of **VirtualBox** (or UTM if you can’t use VirtualBox) is mandatory.
- You only have to turn in a `signature.txt` file at the root of your repository. You must paste in it the signature of your machine’s virtual disk. Go to Submission and peer-evaluation for more information.

# Mandatory part

## VMs
- How do VM work?
- Purpose?

### Useful links
- [Install Debian Linux in VM](https://www.brianlinkletter.com/2012/10/installing-debian-linux-in-a-virtualbox-virtual-machine/)

## OS: Debian
- Why this OS?
- Basic differences between Debian & CentOS?
- Differences between `aptitude` abd `apt`? What's APPArmor?

## *No graphical interface*

## 2 encrypted partitions
- At least, using LVM. Below is an example of an expected partitioning:

<p align=center>
<img width="524" alt="Screen Shot 2021-10-10 at 4 03 40 PM" src="https://user-images.githubusercontent.com/43698378/136699027-5a77000c-c0f0-4b78-8919-98be71d3e2b9.png">
</p>

### Useful links
- [Manually partition Debian](https://unix.stackexchange.com/questions/577379/how-can-i-install-debian-with-full-disk-encryption-and-a-custom-sized-swapfile)

## SSH service
- Running on port 4242.
- For security reasons, it must not be possible to connect using SSH as root.
- ***During eval:***
  - SSH service properly installed.
  - working properly.
  - explain what SSH is and the value using it.
  - use SSH in order to log in with the newly created user.
    - you can use a key or a simple password.
    - make sure you cannot use SSH with the "root" user.

### Useful links
- [Install & config SSH server](https://devconnected.com/how-to-install-and-enable-ssh-server-on-ubuntu-20-04/)

## UFW firewall
- Configure OS with UFW firewall.
- Leave only port 4242 open.
- ***During eval:***
  - "UFW" program properly installed.
  - working properly.
  - explain what UFW is and the value using it.
  - list active rules in UFW, a rule must exist for port 4242.
  - add new rule to open port 8080.
    - check that is has been added by listing the active rules.
  - delete new rule.

## Hostname
- Hostname of the VM must be your login ending with 42 (*abeznik42*). 
- ***During eval:***
  - modify hostname, restart machine, hostname should be updated.
  - show partitions of the VM
  - compare output with example given

## Strong password policy
- Password has to expire every 30 days.
- Minimum number of days allowed before modification of a password will be set to 2.
- User has to receive a warning message 7 days before their password expires.
- Password must 
  - be at least 10 characters long
  - contain an uppercase letter and number
  - not contain more than 3 consecutive identical characters
  - not include the name of the user
  - **does not apply to root password**: have at least 7 character that are not part of the former password
  - **does apply to root password**: after setting up config files, you will have to change all the passwords of the acounts present on the VM.
  - ***During eval:***
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
- ***During eval:***
  - `sudo` properly installed.
  - assign new user to the `sudo` group.
  - explain value and operation of `sudo` using examples of your choice.
  - verify that `/var/log/sudo/` folder exists and has at least one file.
    - check the contents of the files in this folder.
    - should see a history of commands used with `sudo`.
  - run command via `sudo` and see if the files in `/var/log/sudo/` folder have been updated.
 
### Useful links
- [Adding a user to sudoers](https://devconnected.com/how-to-add-user-to-sudoers-on-ubuntu-20-04/)

## User
- In addition to the root user, a user with your login as username has to be present. And has to belong to **sudo** and **user42** groups.
- ***During eval:***
  - create new user.
  - assign password of choice (respecting rules) + explain how these rules were set up.
  - create a group and assign new user to it.

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
- ***During eval:***
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

Check some of the subject’s requirements:
<p align=center>
<img width="636" alt="Screen Shot 2021-10-10 at 5 12 50 PM" src="https://user-images.githubusercontent.com/43698378/136701852-a3309cc5-fae6-4d6e-9ca5-939b0ad138f2.png">
</p>

## That's all folks!
