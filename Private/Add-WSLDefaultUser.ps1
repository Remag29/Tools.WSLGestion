function Add-WSLDefaultUser {
    [CmdletBinding()]
    param (

        [Parameter(Mandatory = $true, Position = 0)]
        [string]$WslInstanceName,
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$Username,
        [Parameter(Mandatory = $true, Position = 2)]
        [securestring]$Password
    )
    
    # Test if the instance exists
    if (-not (Test-WSLInstance -Name $WslInstanceName)) {
        throw "Cannot create new user $Username. The instance $WslInstanceName doesn't exist"
    }

    # Test if the user already exists
    if (Test-WSLUsername -WslInstanceName $WslInstanceName -Username $Username) {
        throw "Cannot create new user $Username. The user already exists"
    }

    # Create the user
    wsl.exe --distribution $WslInstanceName -e bash -c "useradd -m -G sudo -s /bin/bash $Username"

    # Set the password for the user
    wsl.exe --distribution $WslInstanceName -e bash -c "echo $Username\:$(ConvertTo-SecureString -AsPlainText -Force $Password) | chpasswd"

    # Set the default user
    wsl.exe --distribution $WslInstanceName -e bash -c "echo '[user]' > /etc/wsl.conf"
    wsl.exe --distribution $WslInstanceName -e bash -c "echo 'default=$Username' >> /etc/wsl.conf"

    # Terminate the WSL instance
    wsl.exe --terminate $WslInstanceName
}