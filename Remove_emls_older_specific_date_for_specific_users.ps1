#!/usr/bin/env pwsh
#https://github.com/IBeholderI/KerioConnect/blob/main/Remove_emls_older_specific_date_for_specific_users.ps1
$Day = Read-Host -Prompt 'Specify number of the day in a month, for example 17'
$Month = Read-Host -Prompt 'Specify number of the month in a year, for example 3'
$Year = Read-Host -Prompt 'Specify year, for example 2020'
$USERS = Read-Host -Prompt 'Specify users splitted by spaces, like "user1 user2" without quotes'
$DATE = Get-Date -Year $Year -Month $Month -Day $Day
$PATH = '/opt/kerio/mailserver/store/mail/YOUR_DOMAIN'
$LIST = ("$USERS").split(' ')
For ($i=0; $i -lt $LIST.Count; $i++) {
    Get-ChildItem "$PATH/$($LIST[$i])/*" -Exclude '#assoc', '__*', 'Journal' | Get-ChildItem -Include *.eml -Recurse | Where CreationTime -lt  $DATE | Remove-Item -Recurse
}
