# Tools.WSLGestion

This module makes it easy to add and remove instances of WSL via PowerShell commands.

## Installation

You can place the module on you're Module repository. By default, it's `C:\Users\CHANGE_ME\Documents\WindowsPowerShell\Modules`, but it can be different.

You can now import the module with the following command :

```powershell
Import-Mdule Tools.WSLGestion -Force
```

> Noted that it is best to use the `-Force` to ensure that any older versions are overwritten.

The module commands are now visible in the PowerShell console.

## Utilisation

### Basics

You can create a new WSL instance with the command `New-WSL` :

```powershell
New-WSL -Name "My-WSL-Instance" -DistroPath ".\ubuntu-jammy-wsl-amd64-wsl.rootfs.tar.gz" -VhdDestinationFolder ".\Test-module\" -Username "bob"
```

| Parameter                  | Description                                     |
| -------------------------- | ----------------------------------------------- |
| **_Name_**                 | Name of the new WSL instance                    |
| **_DistroPath_**           | Path to the distro archive                      |
| **_VhdDestinationFolder_** | Path to the folder where the VHD will be stored |
| **_Username_**             | Username of the default user                    |

You can remove a WSL instance with the command `Remove-WSL` :

```powershell
Remove-WSL -Name "My-WSL-Instance"
```

### With the configuration file

You can use the command `New-WSL` with only few parameters if you have a configuration file. The mandatory parameters that the module needs will be automatically retrieve from the configuration file.

Parameters `DistroPath`, `VhdDestinationFolder` and `Username` are not mandatory if you have set them in the configuration file.

```powershell
New-WSL -Name "My-WSL-Instance"
```

You can print the file content with the function `Show-WSLConfig`.

The file is store on the folder `.\config\` of the module. You can edit the content here or use the function `Edit-WSLConfig`.

```powershell
Edit-WSLConfig -DistrosPath ".\my\distro.tar.gz" -VhdDestinationFolder ".\vhd\" -Username "bob"
```

> Note that you can only specify the parameters that you want to change. The others will not be modified.

## Uninstallation

To uninstall the module, simply delete the folder `Tools.WSLGestion` from your module repository.

## Other informations

### Default User

By default, root is the only user available on a new WSL instance.

The module automatically create a new user with the username specify on the parameter `Username` when you create a new instance.

To automatically connect to a user when you start a WSL instance, the module use the config file `/etc/wsl.conf`.

It's simply add the following lines to the file :

```conf
[user]
default=MY_USERNAME
```

A very great documentation from microsoft on the subject : [Advanced settings configuration in WSL](https://learn.microsoft.com/en-us/windows/wsl/wsl-config)

### Distro

WSL use specific distro version to initiate new instance. So, you need to specify the `.tar.gz` or `.tar` archive that contains the distro image.

Consider to use official WSL images

For example, you can find some Ubuntu image for WSL at the link below :
[WSL Ubuntu image](https://cloud-images.ubuntu.com/wsl/)

Most distros are available through the Microsoft Store for direct installations. So, it will probably take some research to find them in the archive format.

### Virtual Disk (VHD)

WSL create and use VHD disk to store data of each instance.

A WSL instance is simply a specific virtual machine that starts very quickly.

By default, VHD are store at `C:\Users\CHANGE_ME\AppData\Local\Packages\YOU_DISTRO_NAME\LocalState`.

When tou create an instance with the module, the vhd file is store on the folder specify on the parameter `VhdDestinationFolder`

Here is a great documentation from microsoft on the subject : [How to manage WSL disk space](https://learn.microsoft.com/en-us/windows/wsl/disk-space)

### Default folder

By default, new WSL instances are using the default windows home folder, monted on the vm.

For more convenience, the module is automatically place the user on his WSL home folder when he start an instance.

For example, if the user `bob` start an instance, he will be place on the folder `/home/bob` instead of `/mnt/c/Users/bob` by default.

To do this, the module add the command `cd ~` on the file `~/.bashrc` of the user.
