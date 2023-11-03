function Test-WSLConfigParameter {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [AllowEmptyString()]
        [string]$DistroPath,

        [Parameter(Mandatory = $true, Position = 1)]
        [AllowEmptyString()]
        [string]$VhdDestinationFolder,

        [Parameter(Mandatory = $true, Position = 2)]
        [AllowEmptyString()]
        [string]$Username
    )
    
    # Get the config file content
    $configFileContent = (Get-Content -Path $script:ModulePath\config\configuration.json -Raw | ConvertFrom-Json).DefaultConfig

    if ( $DistroPath -eq "" -and $configFileContent.DistroPath -eq "" ) {
        Write-Host "The distro path is missing on the command line and in the config file, please specify it"  -ForegroundColor Red
        return $false
    }

    if ( $VhdDestinationFolder -eq "" -and $configFileContent.VhdDestinationFolder -eq "" ) {
        Write-Host "The VHD destination folder is missing on the command line and in the config file, please specify it" -ForegroundColor Red
        return $false
    }

    if ( $Username -eq "" -and $configFileContent.Username -eq "" ) {
        Write-Host "The username is missing on the command line and in the config file, please specify it" -ForegroundColor Red
        return $false
    }

    return $true
}