//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-09-03T00:00:00, 22:27:11
// ----------------------------------------------------
// Method: WC__TableFieldStringtoPointers
// Description
// Modified: 09/03/17
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $workingText; $tableName; $fieldName)
C_POINTER:C301($2; $ptTableNum; $3; $ptFieldNum)
C_LONGINT:C283($tableNum; $fieldNum; $p; $0)
$workingText:=$1
$p:=Position:C15("["; $workingText)
If ($p#1)
	$0:=-1
Else 
	$p:=Position:C15("]"; $workingText)
	If ($p<2)
		$0:=-1
	Else 
		$tableName:=Substring:C12($workingText; 2; $p-2)
		$fieldName:=Substring:C12($workingText; $p+1)
		$tableNum:=STR_GetTableNumber($tableName)
		$2->:=$tableNum
		$fieldNum:=STR_GetFieldNumber($tableName; $fieldName)
		$3->:=$fieldNum
	End if 
End if 
