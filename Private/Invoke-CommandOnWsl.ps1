function Invoke-CommandOnWsl {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$WslInstanceName,

        [Parameter(Mandatory = $true, Position = 1)]
        [string]$Command
    )

    # Test if the instance exists
    if (-not (Test-WSLInstance -Name $WslInstanceName)) {
        throw "Cannot execute command $Command. The instance $WslInstanceName doesn't exist"
    }

    # Execute the command
    wsl.exe --distribution $WslInstanceName -e bash -c "$Command"

    # Terminate the WSL instance
    wsl.exe --terminate $WslInstanceName
}