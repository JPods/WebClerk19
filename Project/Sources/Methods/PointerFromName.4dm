//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/16/11, 11:48:39
// ----------------------------------------------------
// Method: PointerFromName
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $tablename; $fieldName)
C_POINTER:C301($0)
// $0:=Nil
C_LONGINT:C283($p; $tableNum; $fieldNum)
$p:=Position:C15("]"; $1)
If ($p>0)
	$tablename:=Substring:C12($1; 2; $p-2)
	$fieldName:=Substring:C12($1; $p+1)
	$tableNum:=STR_GetTableNumber($tableName)
	$fieldNum:=STR_GetFieldNumber($tableName; $fieldName)
	If (($tableNum>0) & ($fieldNum>0))
		$0:=Field:C253($tableNum; $fieldNum)
	End if 
Else 
	If (Length:C16($1)>0)
		$0:=Get pointer:C304($1)
	End if 
End if 