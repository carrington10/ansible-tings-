param (
    [string]$gponame,
    [string]$targetou
)

$ErrorActionPreference = "Stop"

[PSCustomObject]@{
    received_gpo = $gponame
    received_ou  = $targetou
} | ConvertTo-Json -Compress