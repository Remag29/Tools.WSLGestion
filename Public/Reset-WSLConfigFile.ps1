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

    $content | ConvertTo-Json | Out-File -FilePath "$script:ModulePath\config\configuration.json" -Encoding utf8 -Force
}