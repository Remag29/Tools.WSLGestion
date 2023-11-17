<#
.SYNOPSIS
This function edits the content of the configuration file

.DESCRIPTION
This function edits the content of the configuration file. You can edit the path to the distro archive, the path to the folder where the VHD will be stored and the username of the default user.

.PARAMETER DistroPath
Define the path to the distro archive to set in the configuration file

.PARAMETER VhdDestinationFolder
Define the path to the folder where the VHD will be stored to set in the configuration file

.PARAMETER Username
Define the username of the default user to set in the configuration file

.EXAMPLE
Edit-WSLConfigFile -DistroPath "C:\Users\Public\Documents\WSL\Ubuntu.tar.gz" -VhdDestinationFolder "C:\Users\Public\Documents\WSL" -Username "ubuntu"

.EXAMPLE
Edit-WSLConfigFile -DistroPath "C:\Users\Public\Documents\WSL\Ubuntu.tar.gz"

.EXAMPLE
Edit-WSLConfigFile -Username "ubuntu"

#>
function Edit-WSLConfigFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, Position = 0)]
        [AllowEmptyString()]
        [ValidateScript({
                # Test if the distro archive exists and if it's a tar.gz file
                if ((Split-Path -Path $_ -Leaf) -match '\.tar\.gz$') {
                    $true
                }
                else {
                    throw "The distro archive must be a tar.gz file"
                }
            })]
        [string]$DistroPath,

        [Parameter(Mandatory = $false, Position = 1)]
        [AllowEmptyString()]
        [ValidateScript({
                # Test if the path is valide and it's a folder
                if ((Get-Item $_).PSIsContainer) {
                    $true
                }
                else {
                    throw "The VHD destination path must be a folder"
                }
            })]
        [string]$VhdDestinationFolder,

        [Parameter(Mandatory = $false, Position = 2)]
        [AllowEmptyString()]
        [string]$Username
    )
    
    # Get the content of the config file
    $configFileContent = (Get-Content -Path $script:ModulePath\config\configuration.json -Raw | ConvertFrom-Json).DefaultConfig
    
    # Edit the config file content with non-empty parameters
    if ( $DistroPath ) {
        $configFileContent.DistroPath = $DistroPath
    }

    if ( $VhdDestinationFolder ) {
        $configFileContent.VhdDestinationFolder = $VhdDestinationFolder
    }

    if ( $Username ) {
        $configFileContent.Username = $Username
    }

    # Save the new config file content
    $newContent = @{ DefaultConfig = $configFileContent }
    $newContent | ConvertTo-Json | Set-Content -Path $script:ModulePath\config\configuration.json -Force

    # Print the new config file content
    Show-WslConfigFile
}