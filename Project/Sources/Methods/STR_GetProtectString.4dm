//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/17/21, 17:30:49
// ----------------------------------------------------
// Method: STR_GetProtectString
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($ptProtectedField; $ptTable)
C_TEXT:C284($1; $0; $tableName)
C_TEXT:C284($vtFieldName; $0)
C_LONGINT:C283($viTableNum; $viFieldNum)
$0:=""
$tableName:=$1
$ptProtectedField:=STR_GetUniqueFieldPointer($tableName)
If (Not:C34(Is nil pointer:C315($ptProtectedField)))
	C_LONGINT:C283($fieldType; $uniqueNum)
	$fieldType:=Type:C295($ptProtectedField->)
	If ($fieldType=Is longint:K8:6)
		// Get new values directly from CounterNew
		If ($ptProtectedField->>9)
			$0:=String:C10($ptProtectedField->)
		End if 
	Else 
		// Get new values directly from CounterNew
		$0:=$ptProtectedField->
	End if 
End if 
