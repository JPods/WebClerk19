//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/08/09, 11:09:13
// ----------------------------------------------------
// Method: TallyCalc
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i; $k)
$k:=Records in selection:C76([TallyChange:65])
FIRST RECORD:C50([TallyChange:65])
For ($i; 1; $k)
	If (Not:C34(Locked:C147([TallyChange:65])))
		Field:C253([TallyChange:65]FileNum:1; [TallyChange:65]FieldNum:2)->:=Field:C253([TallyChange:65]FileNum:1; [TallyChange:65]FieldNum:2)->+[TallyChange:65]ChangeID:5
		[TallyChange:65]Completed:6:=True:C214
		SAVE RECORD:C53([TallyChange:65])
	End if 
	NEXT RECORD:C51([TallyChange:65])
End for 
UNLOAD RECORD:C212([TallyChange:65])