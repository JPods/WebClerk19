//%attributes = {}
$params:=New object:C1471
$params.pictureName:="Logo"
$params.useSelection:=False:C215
$params.tableName:="Customer"
$params.dialogName:="OutputDS"
CALL WORKER:C1389(1; "W_show"; "Customer"; $params)