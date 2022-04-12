//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 05/17/20, 18:45:59
// ----------------------------------------------------
// Method: KeyWordMakeSelection
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $ptTable)  // pointer to the key field
If (Count parameters:C259>0)
	$ptTable:=$1
Else 
	$ptTable:=ptCurTable
End if 
C_TEXT:C284($tableName)
$tableName:=Table name:C256($ptTable)

FIRST RECORD:C50($ptTable->)
$k:=Records in selection:C76($ptTable->)
If (allowAlerts_boo)
	
	$viProgressID:=Progress New
End if 
For ($i; 1; $k)
	If (allowAlerts_boo)
		//Thermo_Update ($i)
		ProgressUpdate($viProgressID; $i; $k; "Processing "+$tableName)
	End if 
	If (<>ThermoAbort)
		$i:=$k
	End if 
	KeyWordsMake($ptTable)
	NEXT RECORD:C51($ptTable->)
End for 
If (allowAlerts_boo)
	//Thermo_Close 
	Progress QUIT($viProgressID)
End if 