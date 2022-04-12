//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/16/21, 20:24:37
// ----------------------------------------------------
// Method: ActionBy
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0)
C_TEXT:C284($1; $tableName; $2; $vtUserName; $vtRole; $vtData)
C_DATE:C307($3; $vdBegin; $4; $vdEnd)
C_OBJECT:C1216($veSelection; $veRec; $voRecords)
C_TEXT:C284($vtQuery)
ARRAY OBJECT:C1221($vaSelection; 0)
If (Count parameters:C259=0)
	$tableName:="Customer"
	$vtUserName:="Dale"
	$vdBegin:=!2021-01-01!
	$vdEnd:=!2021-01-31!
Else 
	$tableName:=$1
	$vtUserName:=$2
	$vdBegin:=$3
	$vdEnd:=$4
End if 
$vtRole:="Sales"

If ($vtUserName="all")
	$vtQuery:="ActionDate >= :1 AND ActionDate <= :2"
Else 
	$vtQuery:="ActionDate >= :1 AND ActionDate <= :2 AND ActionBy = :3 "
End if 
$veSelection:=ds:C1482[$tableName].query($vtQuery; $vdBegin; $vdEnd; $vtUserName)
If ($veSelection=Null:C1517)
	$0:="[]"
Else 
	If (voFieldsByRole[$vtRole].list[$tableName]=Null:C1517)
		$vtfieldList:="id,Action,ActionBy,ActionDate,Address1,City,Company"
	Else 
		$vtFieldList:=voFieldsByRole[$vtRole].list[$tableName]
	End if 
	vResponse:=API_EntityToText($veSelection; $vtfieldList)
End if 