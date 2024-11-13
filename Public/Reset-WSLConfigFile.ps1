<#
.SYNOPSIS
This function resets the content of the configuration file or create it if it doesn't exist

.DESCRIPTION
This function resets the content of the configuration file or create it if it doesn't exist.
The file has 3 parameters :
- DistroPath : The path to the distro archive
- VhdDestinationFolder : The path to the folder where the VHD will be stored
- Username : The username of the default user

.EXAMPLE
Reset-WslConfigFile

#>
function Reset-WslConfigFile {
    [CmdletBinding()]
    param (
    )
    
    $content = @{
        DefaultConfig = @{
            DistroPath = ""
            VhdDestinationFolder = ""
            Username = ""
        }
    }

    $defaultPath = "$HOME\.tools.wslgestion\"

    # Test the folder
    if (-not (Test-Path -Path $defaultPath)) {
        New-Item -Path $defaultPath -ItemType Directory | Out-Null
    }

    # Test the file
    if (-not (Test-Path -Path "$defaultPath\config.json")) {
        Write-Host "[Reset-WslGestion] - File not found. Create it." -ForegroundColor Cyan
        New-Item -Path "$defaultPath\config.json" -ItemType File | Out-Null
    }
    else {
        Write-Host "[Reset-WslGestion] - Reseting the configuration file..." -ForegroundColor Cyan
    }

    $content | ConvertTo-Json | Out-File -FilePath "$defaultPath\config.json" -Encoding utf8 -Force

    Write-Host "[Reset-WslGestion] - File created or reset successfuly !" -ForegroundColor Green
}