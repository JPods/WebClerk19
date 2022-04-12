//%attributes = {}

// Modified by: Bill James (2021-12-15T06:00:00Z)
// Method: DefaultSetupsReturnValue
// Description 
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($cntParameters)
C_TEXT:C284($0; $1)
$cntParameters:=Count parameters:C259
var $rec_ent : Object
Case of 
	: ($cntParameters=1)
		$rec_ent:=ds:C1482.DefaultSetup.query("variableName =  :1"; $1).first()
	: ($cntParameters=2)
		$rec_ent:=ds:C1482.DefaultSetup.query("variableName =  :1 & machine = :2"; $1; Current machine:C483).first()
End case 
If ($rec_ent=Null:C1517)
	$0:="noRecord"
Else 
	$0:=$rec_ent.value
End if 
