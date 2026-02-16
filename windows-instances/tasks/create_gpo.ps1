
# powershell script to create a gpo and linked it to a given ou

param (
    [string] $gponame,
    [string] $targetOu

)
Import-Module grouppolicy
$gpo = get-gpo -name $gponame

    if(-not $gpo)
    {
        write-host " creating gpo  $gponame"
        new-gpo -name $gponame
    }
    else{
        write-host "gpo already existts."
    }
# link gpo if not already linked 
$inheritance = get-inheritance -target $targetOu
    if ($inheritance.gpolinks.displayname -notcontains $gponame){
    write-host " linking gpo to ou "
    new-gplink -name $gponame -target $targetou -enforced yes
    }
    else {
        write-host " gpo already linked."
    }