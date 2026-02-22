# powershell script to create a gpo and linked it to a given ou

param (
    [string] $gponame,
    [string] $targetou

)
Import-Module grouppolicy
$changed = $false;
$gpo = get-gpo -name $gponame -erroraction silentlycontinue

    if(-not $gpo)
    {
        write-host " creating gpo  $gponame"
        new-gpo -name $gponame | out-null
        $changed = $true;
    }
    else{
        write-host "gpo already existts."
    }
# link gpo if not already linked 
$inheritance =  Get-GPInheritance -target $targetou
$linked = $false;
    if ($inheritance.GpoLinks) {
        foreach ($link in $inheritance.GpoLinks) {
            if ($link.DisplayName -eq $gponame) {
                $linked = $true;
                write-host "gpo already linked to ou."
            }
        }
    }
    if (-not $linked){
        write-host "linking gpo to ou $targetuu"
         new-gplink -name $gponame -target $targetou | out-null
         $changed = $true;
    }
    else{
        write-host "gpo already linked to ou."
    }
[PSCustomObject]@{
    changed = $changed
} | convertto-json -compress