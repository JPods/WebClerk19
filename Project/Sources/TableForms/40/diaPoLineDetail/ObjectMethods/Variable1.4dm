C_LONGINT:C283(bShowItem)
CANCEL:C270

$script:="QUERY([Item];[Item]ItemNum=\""+pPartNum+"\")"
$childProcess:=New process:C317("ProcessTableQuery"; <>tcPrsMemory; String:C10(Count user processes:C343)+"- Items"; Current process:C322; $script; ""; Table:C252(->[Item:4]))
vLastProcessLaunched:=$childProcess