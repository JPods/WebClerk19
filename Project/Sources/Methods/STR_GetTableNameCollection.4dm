//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/03/21, 08:51:41
// ----------------------------------------------------
// Method: STR_GetTableNameCollection
// Description

// STR_GetTableNameList

C_OBJECT:C1216($obProperty; $obStore; $obClass)
C_COLLECTION:C1488($cTableNames)
$cTableNames:=New collection:C1472
// OB GET PROPERTY NAMES(ds;$atTableNames)
For each ($vtProperty; ds:C1482)
	If ($vtProperty#"zz@")  // ignore tables beginning with zz or "_@"
		$cTableNames.push(New object:C1471("tableName"; $vtProperty))
	End if 
End for each 
$0:=$cTableNames