C_TEXT:C284($script)
$script:="QUERY([SyncRecord];[SyncRecord]DTCompleted=0)"
ProcessTableOpen(Table:C252(->[SyncRecord:109]); $script; "Pending")