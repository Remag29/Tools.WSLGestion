function Reset-WSLConfigFile {
    [CmdletBinding()]
    param (
    )
    
    $content = @{
        DefaultConfig = @{
            DistroPath = ""
            VhdDestinationFolder = ""
            Username = ""
        }
    }

    $content | ConvertTo-Json | Out-File -FilePath "$script:ModulePath\config\configuration.json" -Encoding utf8 -Force
}