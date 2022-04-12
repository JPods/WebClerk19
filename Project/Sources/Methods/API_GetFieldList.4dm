//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/16/21, 22:09:42
// ----------------------------------------------------
// Method: API_GetFieldList
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (False:C215)  // testing
	
	If (False:C215)  // document these
		WCapi_FieldList_Create
		WCapi_FieldRecordRole_Create
	End if 
End if 
C_TEXT:C284($1; $tableName; $2; $vtRole; $3; $vtPurpose; $vtFieldList)
C_TEXT:C284($vtQuery)
$vtRole:="Sales"
$vtPurpose:="list"
$tableName:="Customer"
If (Count parameters:C259>0)
	$tableName:=$1
	If (Count parameters:C259>1)
		$vtRole:=$2
		If (Count parameters:C259>2)
			$vtPurpose:=$3
		End if 
	End if 
End if 
$vtQuery:="Purpose = :1 AND Roles = :2 "

C_OBJECT:C1216(voFieldsByRole)
C_COLLECTION:C1488($vcFields)
C_OBJECT:C1216($voFields)
If (voFieldsByRole=Null:C1517)
	Roles_Startup
	$vbClear:=True:C214
End if 

If (voFieldsByRole[$vtRole][$vtPurpose][$tableName]#Null:C1517)
	$vtFieldList:=voFieldsByRole[$vtRole][$vtPurpose][$tableName]
Else 
	$vtFieldList:=voFieldsByRole[$vtPurpose][$tableName]
End if 


If ($vtFieldList="")
	
	
	$vtFieldList:="id"
End if 
If (Position:C15("id"; $vtFieldList)<1)
	
	$vtFieldList:=FieldList_ForceUUIDFirst($vtFieldList)
End if 
$0:=$vtFieldList

If ($vbClear)
	voFieldsByRole:=New object:C1471
End if 