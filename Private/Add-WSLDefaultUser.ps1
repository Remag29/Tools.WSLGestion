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
    Invoke-CommandOnWsl -WslInstanceName $WslInstanceName -Command "useradd -m -G sudo -s /bin/bash $Username"

    # Set the password for the user
    Invoke-CommandOnWsl -WslInstanceName $WslInstanceName -Command "echo $Username\:$(ConvertFrom-SecureString -AsPlainText $Password) | chpasswd"

    # Set the default user
    Invoke-CommandOnWsl -WslInstanceName $WslInstanceName -Command "echo '[user]' > /etc/wsl.conf"
    Invoke-CommandOnWsl -WslInstanceName $WslInstanceName -Command "echo 'default=$Username' >> /etc/wsl.conf"
}