//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/22/21, 21:01:27
// ----------------------------------------------------
// Method: STR_FixCaseTableName

#DECLARE($tableName : Text)->$result : Text
ARRAY TEXT:C222($arrNames; 0)
ARRAY LONGINT:C221($arrTypes; 0)
OB GET PROPERTY NAMES:C1232(ds:C1482; $arrNames; $arrTypes)
$w:=Find in array:C230($arrNames; $tableName)  // this is not case sensitive
If ($w>0)
	$result:=$arrNames{$w}
Else 
	$result:=""
End if 