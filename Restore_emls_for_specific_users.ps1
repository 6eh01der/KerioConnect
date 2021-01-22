#!/usr/bin/env pwsh
#https://github.com/IBeholderI/KerioConnect/blob/main/Restore_emls_for_specific_users.ps1
$USERS = Read-Host -Prompt 'Specify users splitted by spaces, like "user1 user2" without quotes'
$LIST = ("$USERS").split(' ')
For ($i=0; $i -lt $LIST.Count; $i++) {
    Invoke-Command { rsync -hrtzuvs --password-file=YOUR_PASSWORD_FILE --progress rsync@YOUR_BACKUP_SERVER:BACKUP_LOCATION/"$($LIST[$i])"/ /opt/kerio/mailserver/store/mail/YOUR_DOMAIN/"$($LIST[$i])" }
}
