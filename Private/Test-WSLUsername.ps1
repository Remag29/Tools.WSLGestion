function Test-WSLUsername {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$WslInstanceName,
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$Username
    )
    
    # Test if the instance exists
    if (-not (Test-WSLInstance -Name $WslInstanceName)) {
        Write-Host "Cannot test user $Username. The instance $WslInstanceName doesn't exist" -ForegroundColor Red
        return $false
    }

    # Test if the user already exists
    $wslUserMatch = wsl.exe --distribution $WslInstanceName -e bash -c "cat /etc/passwd | grep $Username"
    if ($wslUserMatch -match "^$Username\:.*") {
        return $true
    }

    return $false
}