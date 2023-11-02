# Tools.WSLGestion

This module makes it easy to add and remove instances of WSL via PowerShell commands.

## Installation

You can place the module on you're Module repository. By default, it's `C:\Users\CHANGE_ME\Documents\WindowsPowerShell\Modules`, but it can be different.

You can now import the module with the following command :
```powershell
Import-Mdule Tools.WSLGestion -Force
```

> Note Noted that it is best to use the `-Force` to ensure that any older versions are overwritten.

The module commands are now visible in the PowerShell console.

## Utilisation

You can create a new WSL instance with the command `New-WSL` :
```powershell
New-WSL -Name "My-WSL-Instance" -DistroPath ".\ubuntu-jammy-wsl-amd64-wsl.rootfs.tar.gz" -VhdDestinationFolder ".\Test-module\"
```

You can remove a WSL instance with the command `Remove-WSL` :
```powershell
Remove-WSL -Name "My-WSL-Instance"
```

## Other informations

### Distro

WSL use specific distro version to initiate new instance. So, you need to specify the `.tar.gz` or `.tar` archive that contains the distro image.

Consider to use official WSL images

For example, you can find some Ubuntu image for WSL at the link below :
https://cloud-images.ubuntu.com/wsl/

Most distros are available through the Microsoft Store for direct installations. So, it will probably take some research to find them in the archive format.

### Virtual Disk (VHD)

WSL create and use VHD disk to store data of each instance.

A WSL instance is simply a specific virtual machine that starts very quickly.

By default, VHD are store at `C:\Users\CHANGE_ME\AppData\Local\Packages\YOU_DISTRO_NAME\LocalState`.

When tou create an instance with the module, the vhd file is store on the folder specify on the parameter `VhdDestinationFolder`

Here is a great documentation from microsoft on the subject : [How to manage WSL disk space](https://learn.microsoft.com/en-us/windows/wsl/disk-space)