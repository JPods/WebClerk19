//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/14/13, 16:16:54
// ----------------------------------------------------
// Method: Method: DSCreateRecord
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($currentMachine; $machineOwner; $currentUser; $1; $2; $3; $4)
If (Count parameters:C259=4)
	$currentMachine:=Current machine:C483
	$machineOwner:=Current system user:C484
	$currentUser:=Current user:C182
	CREATE RECORD:C68([DefaultSetup:86])
	
	[DefaultSetup:86]machine:13:=Current machine:C483
	[DefaultSetup:86]machineOwner:14:=Current system user:C484
	[DefaultSetup:86]nameID:1:=Current user:C182
	[DefaultSetup:86]variableName:7:=$1
	
	//build dialog to fill in from choices
	
	[DefaultSetup:86]value:9:=$2
	[DefaultSetup:86]type:8:=$3
	[DefaultSetup:86]howUsed:10:=$4
	//
	[DefaultSetup:86]dtCreated:19:=DateTime_Enter
	SAVE RECORD:C53([DefaultSetup:86])
Else 
	ALERT:C41("Default setup requires Value, Type, Name and How Used.")
End if 