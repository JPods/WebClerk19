//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/16/21, 21:03:51
// ----------------------------------------------------
// Method: API_EntityToText
// Description
// $employees:=Create entity selection([Employee])
////USE ENTITY SELECTION
// get $vtFieldList from 
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($1; $veSelection; $veRec)
C_TEXT:C284($2; $vtFilter; $0)
C_COLLECTION:C1488($vCollection)
C_TEXT:C284($tableName; $3)
If ($vCollection=Null:C1517)
	$vCollection:=New collection:C1472
End if 
$veSelection:=$1
$vtFilter:=""
If (Count parameters:C259=2)
	$vtFilter:=$2
End if 
If (Count parameters:C259=3)
	$tableName:=$3
End if 
If ($veSelection=Null:C1517)
	$0:="[]"
Else 
	$vCollection:=$veSelection.toCollection()
	// $vCollection:=$veSelection.toCollection($vtFilter)
	Case of 
		: ($tableName="InvoiceLine")
		: ($tableName="OrderLine")
	End case 
	If ((cErrors.length>0) & (<>VIDEBUGMODE>410))
		C_OBJECT:C1216($obErr)
		$obErr:=New object:C1471
		$obErr.errors:=cErrors
		$vCollection.push($obErr)
	End if 
	$0:=JSON Stringify:C1217($vCollection)
End if 