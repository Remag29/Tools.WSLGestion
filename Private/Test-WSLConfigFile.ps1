function Test-WSLConfigFile {
    [CmdletBinding()]
    param (
        
    )
    
    # Test if the config file exists
    if (Test-Path -Path $HOME\.tools.wslgestion\config.json) {
        return $true
    }

    return $false
}