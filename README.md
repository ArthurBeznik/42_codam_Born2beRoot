# Born2beRoot

This project aims to introduce you to the wonderful world of virtualization.

***Share some love, star this repo buddy <3***

# Table of entries
- [General guidelines](#guide)
- [VMs](#vm)
- [OS](#os)
- [Hostname](#host)
- [Encrypted partitions](#encrypt)
- [Graphical](#graph)
- [sudo](#sudo)
- [SSH](#ssh)
- [UFW](#ufw)
- [Password policy](#pass)
- [User](#user)
- [APPArmor](#apparmor)
- [Useful Commands](#cmd)
- [Monitoring script](#script)
- [Bonus](#bonus)

## Subject
[subject.pdf](/Born2beroot.pdf#section)


## General guidelines <a name="guide"></a>
- The use of **VirtualBox** (or UTM if you can’t use VirtualBox) is **mandatory**.
- You only have to turn in a `signature.txt` file at the root of your repository. You must paste in it the signature of your machine’s virtual disk. Go to Submission and peer-evaluation for more information.

## VMs <a name="vm"></a>
- **During eval:**
Explain simply:
  - How a virtual machine works.
  - The purpose of virtual machines.

### Useful links
- [THIS IS THE TUTORIAL I FOLLOWED TO INSTALL DEBIAN ON VM](https://www.brianlinkletter.com/2012/10/installing-debian-linux-in-a-virtualbox-virtual-machine/)
- [What is a VM?](https://azure.microsoft.com/en-us/overview/what-is-a-virtual-machine/#overview)
- [What is a VM?](https://www.vmware.com/topics/glossary/content/virtual-machine)
---


## OS: Debian <a name="os"></a>
- **During eval:**
Explain simply:
  - Their choice of operating system. 
  - The basic differences between CentOS and Debian.
  - Debian: the difference between aptitude and apt, and what APPArmor is.

### Useful links
- [OS - Overview](https://www.tutorialspoint.com/operating_system/os_overview.htm)
- [CentOS vs Debian](https://www.openlogic.com/blog/centos-vs-debian)
- [CentOS vs Debian](https://www.educba.com/centos-vs-debian/)
- [CentOS vs Debian](https://1gbits.com/blog/debian-vs-centos/)
- [Aptitude vs apt](https://www.tecmint.com/difference-between-apt-and-aptitude/#:~:text=Apt%2Dget%20being%20a%20lower,operation%20by%20entering%20required%20commands.)
- [APPArmor](https://www.howtogeek.com/118222/htg-explains-what-apparmor-is-and-how-it-secures-your-ubuntu-system/)
---

## Hostname <a name="host"></a>
> The hostname of your virtual machine must be your **login ending with 42** (e.g., abeznik42).
- **During eval:**
  - Check that the hostname of the machine is correctly formatted as follows: login42 (login of the student being evaluated).
  - Modify this hostname by replacing the login with evaluator's login, then restart the machine. If on restart, the hostname has not been updated, the evaluation stops here.
  - You can now restore the machine to the original hostname.
### [Changing hostname](hostname/README.md#section)
---

## Encrypted partitions <a name="encrypt"></a>
> You must create **at least 2 encrypted partitions using LVM**. Below is an example of the
expected partitioning:
<p align=center>
<img width="524" alt="Screen Shot 2021-10-10 at 4 03 40 PM" src="https://user-images.githubusercontent.com/43698378/136699027-5a77000c-c0f0-4b78-8919-98be71d3e2b9.png">
</p>

- **During eval:**
  - Show the partitions for this virtual machine.
    - Compare the output with the example given in the subject. Please note: if bonuses, refer to the bonus example.
  - Give a brief explanation of how LVM works and what it is all about.

Using the command `lsblk` will display the partitions.
### [Encrypt partitions with LVM](lvm/README.md#section)
---

## No graphical interface <a name="graph"></a>
> Since it is a matter of setting up a server, you will install the minimum of services. For this reason, a graphical interface is of no user here. It is therefore forbidden to install X.org or any other equivalent graphics server.
- **During eval:**
  - Ensure that the machine does not have a graphical environment at launch.

Deselect **Desktop environment** and **GNOME** from **software selection** during the install in order to get a non-GUI Debian install.

---

## sudo <a name="sudo"></a>
> To set up a strong configuration for your sudo group, you have to comply with the following requirements:
> - Authentication using sudo has to be limited to 3 attempts in the event of an incorrect password.
> - A custom message of your choice has to be displayed if an error due to a wrong password occurs when using sudo.
> - Each action using sudo has to be archived, both inputs and outputs. The log file has to be saved in the /var/log/sudo/ folder.
> - The TTY mode has to be enabled for security reasons.
> - For security reasons the paths that can be used by `sudo` must be restricted. Example: `/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin`
- **During eval:**
  - Check that the "sudo" program is properly installed on the virtual machine.
  - Show assigning new user to the "sudo" group.
  - The subject imposes strict rules for sudo. First explain the value and operation of sudo using examples.
  - Show the implementation of the rules imposed by the subject.
  - Verify that the "/var/log/sudo/" folder exists and has at least one file.
    - Check the contents of the files in this folder, You should see a history of the commands used with sudo.
  - Run a command via sudo. See if the file(s) in the "/var/log/sudo/" folder have been updated.
### [sudo installation & configuration](sudo/README.md#section)
---

## SSH service <a name="ssh"></a>
> A SSH service will be running on **port 4242 only**. For security reasons, it must **not** be
possible to connect using SSH as root.
- **During eval:**
  - Check that the SSH service is properly installed on the virtual machine.
  - Check that it is working properly.
  - Explain to you basically what SSH is and the value of using it
  - Verify that the SSH service only uses port 4242.
  - Use SSH in order to log in with the newly created user.
    - you can use a key or a simple password.
    - make sure you cannot use SSH with the "root" user.
### [SSH installation & configuration](ssh/README.md#section)
---

## UFW firewall <a name="ufw"></a>
> You have to configure your operating system with the **UFW firewall** (Uncomplicated FireWall) and thus leave **only
port 4242 open**.
- **During eval:**
  - Check that the "UFW" program is properly installed on the virtual machine.
  - Check that it is working properly.
  - Explain to you basically what UFW is and the value of using it.
  - List the active rules in UFW. A rule must exist for port 4242.
  - Add a new rule to open port 8080. Check that this one has been added by listing the active rules.
  - Finally, delete this new rule with the help of the student being evaluated.
### [UFW installation & configuration](ufw/README.md#section)
---

## Strong password policy <a name="pass"></a>
> To set up a strong password policy, you have to comply with the following requirements:
> - Password has to expire every 30 days.
> - Minimum number of days allowed before modification of a password will be set to 2.
> - User has to receive a warning message 7 days before their password expires.
> - Password must:
>   - be at least 10 characters long
>   - contain an uppercase letter and number
>   - **not** contain more than 3 consecutive identical characters
>   - **not** include the name of the user
>   - **does not apply to root password**: have at least 7 character that are **not** part of the former password
>   - **does apply to root password**: after setting up config files, you will have to change all the passwords of the acounts present on the VM.
  - **During eval:**
     - Explain advantages of this password policy.
     - Explain advantages and disadvantages of its implementation.
### [Strong password installation & configuration](passwd/README.md#section)
---

## User <a name="user"></a>
> In addition to the root user, a user with your login as username has to be present. And has to belong to `sudo` and `user42` groups.
- **During eval:**
  - A user with the login of the student being evaluated has to be already present on the virtual machine.
    - Check that it has been added and that it belongs to the "sudo" and "user42" groups.
  - Make sure the rules imposed in the subject concerning the password policy have been put in place by following the following steps.
    - Create new user.
    - Assign password of choice (respecting rules) and explain how these rules were set up. (there should be one or two modified files)
    - Create a group named "evaluating" and assign it to this user. 
      - Finally, check that this user belongs to the "evaluating" group.


### [Users, groups, ...](user/README.md#section)
---

## APPArmor <a name="apparmor"></a>
### [APPArmor set up](apparmor/README.md#section)
---


## Useful Commands <a name="cmd"></a>
### [Here are a few useful commands, cheers](cmd/README.md#section)
---

## Monitoring script <a name="script"></a>
>- `monitoring.sh` developped in `bash`.
>- At server startup, the script will display some information on all terminals every 10min (see `wall`), banner is optional, no error must be visible.
>- Following information must be displayed:
>   - Architecture of your OS and its kernel version
>   - The number of physical processors.
>   - The number of virtual processors.
>   - The current available RAM on your server and its utilization rate as a percentage.
>   - The current available memory on your server and its utilization rate as a percentage.
>   - The current utilization rate of your processors as a percentage.
>   - The date and time of the last reboot.
>   - Whether LVM is active or not.
>   - The number of active connections.
>   - The number of users using the server.
>   - The IPv4 address of your server and its MAC (Media Access Control) address.
>   - The number of commands executed with the `sudo` program.
- **During eval:**
  - How the script works, by showing the code.
  - What "cron" is.
  - How it was set up so that it runs every 10min.
  - Ensure that this script runs every minute, make sure that the script runs with dynamic values correctly.
  - Make the script stop running when the server has started up, without modifying the script itself. (you'll have to restart one last time)
  - At startup, check if the script still exists in the same place, rights have remained unchanged, and not been modified.
- Example below:
<p align=center>
  <img width="597" alt="Screen Shot 2021-10-10 at 5 11 35 PM" src="https://user-images.githubusercontent.com/43698378/136701814-cc671d24-9bd5-4d6f-8d89-bb2c19d4d6e9.png">
</p>

### [Monitoring script](script/#section)
---

## Check some of the subject’s requirements:
<p align=center>
<img width="636" alt="Screen Shot 2021-10-10 at 5 12 50 PM" src="https://user-images.githubusercontent.com/43698378/136701852-a3309cc5-fae6-4d6e-9ca5-939b0ad138f2.png">
</p>

Commands used:
```bash
head -n 2 /etc/os-release
```
```bash
/usr/sbin/aa-status
```
```bash
ss -tunlp
```
ss is used to investigate sockets (to dump socket statistics)

- `t` : display TCP sockets
- `u` : display UDP sockets
- `n` : show exact brandwidth values
- `l` : display only listening sockets
- `p` : show process using socket
```bash
/usr/sbin/ufw status
```

---

## Bonus <a name=bonus></a> (work in progress)

STEP 4 - Network adapter configuration

You may not be able to connect to your VM via SSH with standard settings in
VirtualBox. Theres a way to wix it!

1) Turn off your VM
2) Go to your VM settings in VirtualBox
3) Network -> Adapter 1 -> Advanced -> Port forwarding
4) Add new rule (little green button on right top side) and next parameters:

 Protocol | Host IP | Host Port | Guest IP | Guest Port
 -----------|---------|-----------|----------|---------
 TCP | 127.0.0.1 | 4242 | 10.0.2.15 | 4242      

6) In your host (physical) machine open Terminal and run
```bash
[ssh <vmusername>@localhost -p 4242]
```

Now you can control your virtual machine from the host terminal.

#### Useful links
- [lighttpd](https://www.rosehosting.com/blog/how-to-install-lighttpd-on-debian-9/)
- [WordPress](https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lamp-on-debian-9)



# That's all folks!
