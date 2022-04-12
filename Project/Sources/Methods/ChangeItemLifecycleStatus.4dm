//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/04/19, 12:35:30
// ----------------------------------------------------
// Method: ChangeItemLifecycleStatus
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ********************************************************* //
// ** TYPE AND INITIALIZE PARAMETERS *********************** //
// ********************************************************* //

// PARAMETER 1 IS THE NAME OF THE PROCESS VARIABLE
// THAT WE WANT TO RETURN THE VALUE OF.
C_TEXT:C284($1; $vtNewStatus)
$vtNewStatus:=$1

C_TEXT:C284($2; $vtItemNum)
$vtItemNum:=$2

// ********************************************************* //
// ** LOAD THE SPECIFIED RECORD, THEN CHANGE THE STATUS***** //
// ********************************************************* //

QUERY:C277([Item:4]; [Item:4]itemNum:1=$vtItemNum)

If (Records in selection:C76([Item:4])=1)
	
	FIRST RECORD:C50([Item:4])
	ChangeCurItemLifecycleStatus($vtNewStatus)
	SAVE RECORD:C53([Item:4])
	UNLOAD RECORD:C212([Item:4])
	
End if 