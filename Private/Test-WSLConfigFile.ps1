function Test-WSLConfigFile {
    [CmdletBinding()]
    param (
        
    )
    
    # Test if the config file exists
    if (Test-Path -Path $script:ModulePath\config\configuration.json) {
        return $true
    }

    return $false
}