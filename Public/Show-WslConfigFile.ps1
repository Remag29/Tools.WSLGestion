function Show-WslConfigFile {
    [CmdletBinding()]
    param (
    )
    
    $wslConfigFile = Get-Content -Path $script:ModulePath\config\configuration.json -Raw | ConvertFrom-Json

    $wslConfigFile.DefaultConfig | Format-List
}