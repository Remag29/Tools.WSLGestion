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