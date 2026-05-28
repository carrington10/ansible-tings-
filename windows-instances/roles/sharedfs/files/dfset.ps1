param(
    [string] $computer,
    [string] $dfsfolder,
)
## create dfs set namespace
new-dfsnroot -path "\\kingdom.local\shares" -targetpath "\\$computer\shares" -type domainv2 -erroraction silentlycontinue
## create dfs folder 
new-dfsnfolder -path "\\kingdom.local\shares\$dfsfolder" -targetpath "\\$computer\$dfsfolder" -erroraction silentlycontinue