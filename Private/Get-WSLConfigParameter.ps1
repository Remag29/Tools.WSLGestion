function Get-WSLConfigParameter {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [AllowEmptyString()]
        [string]$DistoPath,

        [Parameter(Mandatory = $true, Position = 1)]
        [AllowEmptyString()]
        [string]$VhdDestinationFolder,

        [Parameter(Mandatory = $true, Position = 2)]
        [AllowEmptyString()]
        [string]$Username
    )
    
    # Get the config file content
    $configFileContent = (Get-Content -Path $HOME\.tools.wslgestion\config.json -Raw | ConvertFrom-Json).DefaultConfig
    Write-Host "|-- Load parameters from config file" -ForegroundColor Cyan

    # Get parameters from the config file if there are missing on the command line
    if ( $DistoPath -eq "" ) {
        $DistoPath = $configFileContent.DistroPath
        Write-Host "DistroPath: $DistoPath" -ForegroundColor Magenta
    }

    if ( $VhdDestinationFolder -eq "" ) {
        $VhdDestinationFolder = $configFileContent.VhdDestinationFolder
        Write-Host "VhdDestinationFolder: $VhdDestinationFolder" -ForegroundColor Magenta
    }

    if ( $Username -eq "" ) {
        $Username = $configFileContent.Username
        Write-Host "Username: $Username" -ForegroundColor Magenta
    }

    # Return the new set of parameters
    return @{
        DistroPath = $DistoPath
        VhdDestinationFolder = $VhdDestinationFolder
        Username = $Username
    }
}