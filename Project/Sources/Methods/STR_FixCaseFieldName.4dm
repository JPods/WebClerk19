//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/22/21, 21:17:41
// ----------------------------------------------------
// Method: STR_FixCaseFieldName
// Description
// 
//
// Parameters
// ----------------------------------------------------
#DECLARE($tableName : Text; $vtFieldName : Text)->$return : Text
C_LONGINT:C283($w)
C_POINTER:C301($ptFieldArray)
C_OBJECT:C1216($obDataStore)
ARRAY TEXT:C222($arrNames; 0)
ARRAY LONGINT:C221($arrTypes; 0)
$return:=""

//var $names_c : Collection
//$names_c:=New collection
//$obClass:=ds[$tableName]
//$names_c.push($obClass.name)
If (ds:C1482[$tableName]#Null:C1517)
	OB GET PROPERTY NAMES:C1232(ds:C1482[$tableName]; $arrNames; $arrTypes)
	$w:=Find in array:C230($arrNames; $vtFieldName)
	If ($w>0)
		$return:=$arrNames{$w}
	End if 
End if 