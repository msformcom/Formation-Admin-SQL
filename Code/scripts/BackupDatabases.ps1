# install-module sqlserver -AllowClobber
# uninstall-module dbatools
#  install-module dbatools -AllowClobber
# import-module SqlServer
#  import-module dbatools
# get-module
param(
    [string]
$instanceName=".\Sql1",
   [string]
$BackupPath  = "c:\Data DM\"         # Répertoire de sauvegarde
)
$DateStamp   = Get-Date -Format "yyyyMMdd_HHmmss"


$databases=Get-SqlDatabase -ServerInstance $instanceName
$modecomplet =$databases  | Where-Object RecoveryModel -eq full
$m= $modecomplet | measure

    foreach($db in $modecomplet){
        
        $path="$BackupPath$($db.Name)$DateStamp.bak"
        write-host $db.Name
        Backup-SqlDatabase -DatabaseObject $db -BackupFile $path
    }
