#!/usr/bin/env pwsh
#https://github.com/IBeholderI/KerioConnect/blob/main/Backup_emls_older_specific_date.ps1
$Day = Read-Host -Prompt 'Specify number of the day in a month, for example 17'
$Month = Read-Host -Prompt 'Specify number of the month in a year, for example 3'
$Year = Read-Host -Prompt 'Specify year, for example 2020'
$USERS = Read-Host -Prompt 'Specify users splitted by spaces, like "user1 user2" without quotes'
$DATE = Get-Date -Year $Year -Month $Month -Day $Day
$PATH = '/opt/kerio/mailserver/store/mail/YOUR_DOMAIN'
If ($USERS -ne "") {
$LIST = ("$USERS").split(' ')
} Else {
    $LIST = Get-ChildItem $PATH
} 
$EML_LIST = For ($i=0; $i -lt $LIST.Count; $i++) {
    Get-ChildItem "$PATH/$($LIST[$i])/*" -Exclude '#assoc', '__*', 'Journal' | Get-ChildItem -Include *.eml -Recurse | Where CreationTime -lt $DATE
}
$EML_LIST = For ($i=0; $i -lt $EML_LIST.Count; $i++) {
    $($EML_LIST.FullName[$i]).replace('/opt/kerio/mailserver/store/mail/', '')
}
For ($i=0; $i -lt $EML_LIST.Count; $i++) {
    Invoke-Command { rsync -hrRtluvpogs --password-file=YOUR_PASSWORD_FILE --progress /opt/kerio/mailserver/store/mail/./"$($EML_LIST[$i])" YOUR_USER@YOUR_BACKUP_SERVER:/BACKUP_LOCATION/
}
