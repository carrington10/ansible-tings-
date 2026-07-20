
param(
    [string] $computer,
    [string] $dfsfolder
)

$rootPath = "\\kingdom.local\shares"
$folderPath = "\\kingdom.local\shares\$dfsfolder"
$changedRoot = $false
$changedFolder = $false
if (-not (Get-DfsnRoot -Path $rootPath -ErrorAction SilentlyContinue)) {
    New-DfsnRoot -Path $rootPath -TargetPath "\\$computer\shares" -Type DomainV2
    $changedRoot = $true
}

if (-not (Get-DfsnFolder -Path $folderPath -ErrorAction SilentlyContinue)) {
    New-DfsnFolder -Path $folderPath -TargetPath "\\$computer\$dfsfolder"
    $changedFolder = $true
}

$result = @{
    changedRoot = $changedRoot
    changedFolder = $changedFolder
}

write-output ($result | ConvertTo-Json -Compress)