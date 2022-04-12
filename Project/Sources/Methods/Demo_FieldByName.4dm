//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/26/21, 22:39:27
// ----------------------------------------------------
// Method: Demo_FieldByName
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $tableName; $0)
$tableName:=$1
$tableName:="Customer"
C_LONGINT:C283($cntField; $incField; $viType; $viKeyType; $viTableNum)
C_POINTER:C301($ptTable; $ptFieldUnique; $ptField)
$ptTable:=STR_GetTablePointer($tableName)
If (Is nil pointer:C315($ptTable))
	$0:="Error: Invalid Table Name: "+$tableName
Else 
	$viTableNum:=Table:C252($ptTable)
	$ptFieldUnique:=STR_GetUniqueFieldPointer($tableName)
	GET FIELD PROPERTIES:C258($viTableNum; Field:C253($ptFieldUnique); $viType)  // file #, field #, type, length, index
	If ($viType=Is longint:K8:6)
		QUERY:C277($ptTable->; $ptFieldUnique->=411)
		$viKeyType:=1
	Else 
		QUERY:C277($ptTable->; $ptFieldUnique->="411")
		$viKeyType:=0
	End if 
	If (Records in selection:C76($ptTable->)=0)
		CREATE RECORD:C68($ptTable->)
	End if 
	$cntField:=Get last field number:C255($ptTable)
	For ($incField; 1; $cntField)
		$ptField:=Field:C253($viTableNum; $incField)
		GET FIELD PROPERTIES:C258($viTableNum; $incField; $viType)  // file #, field #, type, length, index
		Case of 
			: (($viType=Is alpha field:K8:1) | ($viType=Is text:K8:3))
				Field:C253($viTableNum; $incField)->:=Field name:C257($viTableNum; $incField)
			: ($viType=Is longint:K8:6)
				Field:C253($viTableNum; $incField)->:=$incField
			: ($viType=Is boolean:K8:9)
				Field:C253($viTableNum; $incField)->:=True:C214
			: ($viType=Is date:K8:7)
				Field:C253($viTableNum; $incField)->:=!2011-04-11!
			: ($viType=Is time:K8:8)
				Field:C253($viTableNum; $incField)->:=?01:44:00?
			: ($viType=Is object:K8:27)
				Field:C253($viTableNum; $incField)->:=New object:C1471("objName"; Field name:C257($viTableNum; $incField))
		End case 
		
		
		
	End for 
	TRACE:C157
	If ($viKeyType=1)
		$ptFieldUnique->:=411
	Else 
		$ptFieldUnique->:="411"
	End if 
	$ptFieldUnique:=STR_GetFieldPointer($tableName; "ActionBy")
	If (Not:C34(Is nil pointer:C315($ptFieldUnique)))
		$ptFieldUnique->:="Dawn"
	End if 
	
	SAVE RECORD:C53($ptTable->)
End if 

TRACE:C157