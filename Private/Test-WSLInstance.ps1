function Test-WSLInstance {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Name
    )
    
    $wslInstance = wsl.exe --list --quiet
    foreach ($instance in $wslInstance) {
        if ($instance -eq $Name) {
            return $true
        }
    }

    return $false
}