function New-WSL {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Name,

        [Parameter(Mandatory = $true, Position = 1)]
        [ValidateScript({
            # Test if the distro archive exists and if it's a tar.gz file
            if (Split-Path -Path $_ -Parent | Test-Path) {
                if ((Split-Path -Path $_ -Leaf) -match '\.tar\.gz$') {
                    $true
                } else {
                    throw "The distro archive must be a tar.gz file"
                }
            } else {
                throw "The distro archive doesn't exist"
            }
        })]
        [string]$DistroPath,

        [Parameter(Mandatory = $true, Position = 2)]
        [ValidateScript({
            # Test if the path is valide and it's a folder
            if (Test-Path $_) {
                if ((Get-Item $_).PSIsContainer) {
                    $true
                } else {
                    throw "The VHD destination path must be a folder"
                }
            } else {
                throw "The VHD destination path doesn't exist"
            }
        })]
        [string]$VhdDestinationFolder
    )

    # Test if the WSL instance already exists
    if (Test-WSLInstance -Name $Name) {
        Write-Host "The WSL instance $Name already exists" -ForegroundColor Red
        return
    }

    # Create the WSL instance
    Write-Host "Creating the WSL instance $Name" -ForegroundColor Cyan
    wsl.exe --import $Name $VhdDestinationFolder $DistroPath

    # Add defaul user to the WSL instance
    # TODO

    # Test if the WSL instance has been created
    if (Test-WSLInstance -Name $Name) {
        Write-Host "The WSL instance $Name has been created" -ForegroundColor Green
    } else {
        Write-Host "The WSL instance $Name hasn't been created" -ForegroundColor Red
    }
    
}