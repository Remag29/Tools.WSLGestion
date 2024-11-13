<#
.SYNOPSIS
This function shows the content of the configuration file

.DESCRIPTION
This function shows the content of the configuration file

.EXAMPLE
Show-WslConfigFile

#>
function Show-WslConfigFile {
    [CmdletBinding()]
    param (
    )
    
    $wslConfigFile = Get-Content -Path $HOME\.tools.wslgestion\config.json -Raw | ConvertFrom-Json

    $wslConfigFile.DefaultConfig | Format-List
}