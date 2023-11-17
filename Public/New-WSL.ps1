<#
.SYNOPSIS
This function creates a new WSL instance

.DESCRIPTION
This function creates a new WSL instance and add the default user to it. It also set the default start folder to the user home folder.
To create the WSL instance, you need to provide the name of the instance, the path to the distro archive, the path to the folder where the VHD will be stored and the username of the default user.
If you don't provide the path to the distro archive, the path to the folder where the VHD will be stored and the username of the default user, the function will try to extract them from the config file.

.PARAMETER Name
Define the name of the WSL instance

.PARAMETER DistroPath
Define the path to the distro archive

.PARAMETER VhdDestinationFolder
Define the path to the folder where the VHD will be stored

.PARAMETER Username
Define the username of the default user

.EXAMPLE
New-WSL -Name "Ubuntu" -DistroPath "C:\Users\Public\Documents\WSL\Ubuntu.tar.gz" -VhdDestinationFolder "C:\Users\Public\Documents\WSL" -Username "ubuntu"

.EXAMPLE
New-WSL -Name "Ubuntu"

#>
function New-WSL {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Name,

        [Parameter(Mandatory = $false, Position = 1)]
        [ValidateScript({
                # Test if the distro archive exists and if it's a tar.gz file
                if (Split-Path -Path $_ -Parent | Test-Path) {
                    if ((Split-Path -Path $_ -Leaf) -match '\.tar\.gz$') {
                        $true
                    }
                    else {
                        throw "The distro archive must be a tar.gz file"
                    }
                }
                else {
                    throw "The distro archive doesn't exist"
                }
            })]
        [string]$DistroPath = "",

        [Parameter(Mandatory = $false, Position = 2)]
        [ValidateScript({
                # Test if the path is valide and it's a folder
                if (Test-Path $_) {
                    if ((Get-Item $_).PSIsContainer) {
                        $true
                    }
                    else {
                        throw "The VHD destination path must be a folder"
                    }
                }
                else {
                    throw "The VHD destination path doesn't exist"
                }
            })]
        [string]$VhdDestinationFolder = "",

        [Parameter(Mandatory = $false, Position = 3)]
        [string]$Username = ""
    )

    # Test if the WSL instance already exists
    if (Test-WSLInstance -Name $Name) {
        Write-Host "The WSL instance $Name already exists" -ForegroundColor Red
        return
    }

    # Test non mandatory parameters and try to extract them from the config file if missing
    if ($DistroPath -and $VhdDestinationFolder -and $Username) {
        # Nothing to do
    }
    else {
        # Test the config file
        if (-not (Test-WSLConfigFile)) {
            Write-Host "The config file doesn't exist ! You can use the command Reset-WSLConfigFile to create/reset it." -ForegroundColor Red
            return
        }
        # Test if missing parameters are in the config file
        if (Test-WSLConfigParameter -DistroPath $DistroPath -VhdDestinationFolder $VhdDestinationFolder -Username $Username) {
            # Get the config file content
            $newParameters = Get-WSLConfigParameter -DistoPath $DistroPath -VhdDestinationFolder $VhdDestinationFolder -Username $Username
            $DistroPath = $newParameters.DistroPath
            $VhdDestinationFolder = $newParameters.VhdDestinationFolder
            $Username = $newParameters.Username
        }
        else {
            return
        }
    }

    # Create the WSL instance
    Write-Host ""
    Write-Host "|-- Creating the WSL instance $Name" -ForegroundColor Cyan
    wsl.exe --import $Name $VhdDestinationFolder $DistroPath

    # Add defaul user to the WSL instance
    Write-Host "╰─ Adding the default user to the WSL instance $Name" -ForegroundColor Cyan

    # Ask for the password and confirm it
    $passwordIncorrect = $true
    while ($passwordIncorrect) {
        $password = Read-Host "> Enter the password for the user $Username" -AsSecureString
        $passwordConfirmation = Read-Host "> Confirm the password for the user $Username" -AsSecureString
        
        if (Compare-SecureString -secureString1 $password -secureString2 $passwordConfirmation) {
            $passwordIncorrect = $false
        }
        else {
            Write-Host "The passwords don't match. Please retry" -ForegroundColor Red
        }
    }
    Add-WSLDefaultUser -WslInstanceName $Name -Username $Username -Password $password

    # Set the default start folder
    Edit-UserBashrc -WslInstanceName $Name -Username $Username -ContentToAdd "cd ~"

    # Test if the WSL instance has been created
    if (Test-WSLInstance -Name $Name) {
        Write-Host ""
        Write-Host "|- The WSL instance $Name has been created" -ForegroundColor Green
    }
    else {
        Write-Host ""
        Write-Host "|- The WSL instance $Name hasn't been created" -ForegroundColor Red
    }
    
}