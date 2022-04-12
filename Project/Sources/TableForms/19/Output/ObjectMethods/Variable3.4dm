// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/12/09, 15:45:05
// ----------------------------------------------------
// Method: Object Method: bPWCreate
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(bPWCreate; bPWChange)
TRACE:C157
C_LONGINT:C283(bPWCreate; bPWChange)
TRACE:C157
CONFIRM:C162("Create passwords for active employees?")
If (OK=1)
	C_LONGINT:C283($cntRec; $incRec)
	$cntRec:=Records in selection:C76([Employee:19])
	FIRST RECORD:C50([Employee:19])
	For ($incRec; 1; $cntRec)
		If ([Employee:19]active:12=True:C214)
			PassWordCreate(2)  //create if employee does not exist
		End if 
		NEXT RECORD:C51([Employee:19])
	End for 
	jpwCreate
End if 