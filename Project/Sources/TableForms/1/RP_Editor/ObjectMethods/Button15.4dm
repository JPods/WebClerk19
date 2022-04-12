C_TEXT:C284($script)
$script:="QUERY([SyncRelation];[SyncRelation]Active=True)"
DB_ShowCurrentSelection(->[SyncRelation:103]; $script; 0; " -- Active -- "; 1)


