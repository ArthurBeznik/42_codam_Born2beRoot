## SSH installation and configuration
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
sudo nano /etc/ssh/sshd_config
```
**Warning:** search how to use `sudo vi`, it's **VERY** confusing to use! Or just use `sudo nano`, nice interface, way easier to use.

Look for the following line.
```bash
#Port 22

Port 4242
```
**Uncomment the line you edit**, or it will not consider the changes.

Make sure to change your port to one that is not reserved for other protocols. Be careful when you change your default SSH port, **you will have to specify it when connecting to it**.

#### 2. Disabling Root Login on your SSH server
> Since the root user is universal for all Linux and Unix systems it was always the preferred bruteforce victim by hackers to access systems. To bruteforce an unprivileged account the hacker must learn the username first and even if succeeding  the attacker stays limited unless using a local exploit.

By default, on recent distributions, root login is set to “prohibit-password”. This option means that all interactive authentication methods are banned, allowing only public keys to be used. In short, you need to setup SSH keys and to use them in order to connect as root.
```bash
#PermitRootLogin prohibit-password

PermitRootLogin no
```
Save by pressing `CTRL+X` then `Y` and `return`.

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
