# Get Module Path
$script:ModulePath = Split-Path -Parent $PSCommandPath

# Loading Private methods
Get-ChildItem -Path "$script:ModulePath\Private" -Filter "*.ps1" | Where-Object { . $_.FullName }

# Loading Public methods
Get-ChildItem -Path "$script:ModulePath\Public" -Filter "*.ps1" | Where-Object { . $_.FullName }