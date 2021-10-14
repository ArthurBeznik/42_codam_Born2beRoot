## sudo installation & configuration
### Installation
On a fresh Debian install `sudo` does not work by default. You need to add your user to the `sudo` group in order to get the command working.

#### 1. Get root first

If you are already logged in on another user, use the `su` command. Enter your root password that you set during installation to get the root prompt.

#### 2. Add user to the sudo group

This will add your user to the sudo group.

`sudo adduser <username> sudo`

After this, start logout and login again. Try running the commands with sudo now and they will work for your user.

Additionally in some cases like the minimal installations of Debian, the sudo program/command itself might not be present. In that case you will also need to install sudo.

`apt install sudo`

### Configuration

***Always edit sudo file using `sudo visudo`.***

#### 1. Set a Secure PATH

This is the path used for every command run with sudo, it has two importances:

- Used when a system administrator does not trust sudo users to have a secure PATH environment variable
- To separate “root path” and “user path”, only users defined by exempt_group are not affected by this setting.

To set it, add the line:

``` bash
Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
```
Most of the line should already be there, except for the very end `:/snap/bin`

#### 2. Enable sudo on TTY User Login Session

From [Wikipedia](https://en.wikipedia.org/wiki/Tty_(unix))
> In computing, tty is a command in Unix and Unix-like operating systems to print the file name of the terminal connected to standard input.
> tty stands for TeleTYpewriter.

To enable sudo to be invoked from a real tty but not through methods such as cron or cgi-bin scripts, add the line:

```bash
Defaults  requiretty 
```

#### 3. Change default sudo Log File

By default, sudo logs through syslog(3). However, to specify a custom log file, add the following line:

```bash
Defaults  syslog=local1
```
Save and close the file. `CTRL+X` followed by `Y`.

Next, edit `/etc/rsyslog.conf`
```bash
sudo nano /etc/rsyslog.conf
```
And add the following line before the `auth,authpriv.*;local1.none` line:
```bash
local1.*  /var/log/sudo/sudo.log
```
Save and close the file

Restart `rsyslog` service to take effect the changes:
```bash
sudo systemctl restart rsyslog
```
From now on, all sudo attempts will be logged in /var/log/sudo/sudo.log file.

#### 4. Log sudo Command Input/Output

The log_input and log_output parameters enable sudo to run a command in pseudo-tty and log all user input and all output sent to the screen receptively.

The default I/O log directory is /var/log/sudo-io, and if there is a session sequence number, it is stored in this directory. You can specify a custom directory through the iolog_dir parameter.

``` bash
Defaults   log_input, log_output
Defaults   iolog_dir=/var/log/sudo/
```

```bash
Three sudo commands are stored in 3 separate directory. 
# ls /var/log/sudo/00/00/
   01  02  03

Each command stores command output in 7 different files. 
# ls /var/log/sudo/00/00/01/|wc -l
7
# ls /var/log/sudo/00/00/02/|wc -l
7
# ls /var/log/sudo/00/00/03/|wc -l
7
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
