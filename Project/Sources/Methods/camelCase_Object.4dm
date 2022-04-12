//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/24/21, 22:14:37
// ----------------------------------------------------
// Method: camelCase_Object
// Description
// 
//
// Parameters
// ----------------------------------------------------
#DECLARE($tableName : Text; $obIncoming : Object; $vtUse : Text)->$return : Object
C_COLLECTION:C1488($cBefore; $cTested; $cFailed)
$cFailed:=New collection:C1472
$cTested:=New collection:C1472
$return:=New object:C1471($vtUse; ""; $vtUse+"Fail"; "")
$cBefore:=New collection:C1472
If ($obIncoming[$vtUse]=Null:C1517)
	$cTested.push("id")
Else 
	$cBefore:=Split string:C1554($obIncoming[$vtUse]; ",")
	$obFieldDef:=STR_GetTableDefinition($tableName)
	For each ($vtBefore; $cBefore)
		If ($obFieldDef[$vtBefore]=Null:C1517)
			$vtBefore:=camelCase_FixFieldName($vtBefore)
			If ($obFieldDef[$vtBefore]=Null:C1517)
				$cFailed.push($vtBefore)
			Else 
				$cTested.push($vtBefore)
			End if 
		Else 
			$cTested.push($vtBefore)
		End if 
	End for each 
End if 
$return[$vtUse]:=$cTested.join(",")
$return[$vtUse+"Fail"]:=$cFailed.join(",")
$return.form:=""
If ($return[$vtUse+"Fail"]#"")
	ConsoleMessage($tableName+"---"+$vtUse+"---"+$return[$vtUse+"Fail"])
End if 

