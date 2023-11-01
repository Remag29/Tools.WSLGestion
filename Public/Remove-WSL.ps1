function Remove-WSL {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Name
    )
    
    # Test if the WSL instance exists
    if (Test-WSLInstance -Name $Name) {
        # Alert message and demande confirmation
        Write-Host "The WSL instance $Name will be removed" -ForegroundColor Yellow
        $confirmation = Read-Host "Do you want to continue? (Y/N)"

        if ($confirmation -ne 'Y') {
            Write-Host "The WSL instance $Name hasn't been removed" -ForegroundColor Yellow
            return
        }

        # Stop the WSL instance
        Write-Host "Stopping the WSL instance $Name ..." -ForegroundColor Cyan
        wsl.exe --terminate $Name

        # Remove the WSL instance
        Write-Host "Removing the WSL instance $Name ..." -ForegroundColor Cyan
        wsl.exe --unregister $Name
    } else {
        Write-Host "The WSL instance $Name doesn't exist" -ForegroundColor Red
    }
    
}