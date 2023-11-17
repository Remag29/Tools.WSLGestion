function Edit-UserBashrc {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$WslInstanceName,

        [Parameter(Mandatory = $false, Position = 1)]
        [string]$Username,

        [Parameter(Mandatory = $true, Position = 2)]
        [string]$ContentToAdd
    )
    
    # Set the .bashrc file path
    $bashrcPath = "/home/$Username/.bashrc"

    # Execute the command on the WSL instance
    Invoke-CommandOnWsl -WslInstanceName $WslInstanceName -Command "echo '$ContentToAdd' >> $bashrcPath"
}