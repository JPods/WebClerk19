//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/03/20, 23:28:03
// ----------------------------------------------------
// Method: MySaleSerFieldList
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $tableName; $0; $2)

$0:=$2
$tableName:=$1
C_OBJECT:C1216($obRec; $obSel)
$obSel:=ds:C1482.TallyMaster.query("purpose = :1 AND name = :2"; "MySalesService"; $tableName)
If ($obSel.first()#Null:C1517)
	$0:=$obSel.first().build
End if 
