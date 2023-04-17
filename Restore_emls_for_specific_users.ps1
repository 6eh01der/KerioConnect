#!/usr/bin/env pwsh
#https://github.com/6eh01der/KerioConnect/blob/main/Restore_emls_for_specific_users.ps1
$USERS = Read-Host -Prompt 'Specify users splitted by spaces, like "user1 user2" without quotes'
$LIST = ("$USERS").split(' ')
$PATH = $args[0]
$DOMAIN = $args[1]
$BACKUP_SERVER = $args[2]
$BACKUP_LOCATION = $args[3]
For ($i=0; $i -lt $LIST.Count; $i++) {
    Invoke-Command { rsync -hrtzuvs --password-file=YOUR_PASSWORD_FILE --progress "rsync@$BACKUP_SERVER`:$BACKUP_LOCATION/$($LIST[$i])/" "$PATH/$DOMAIN/$($LIST[$i])" }
}
