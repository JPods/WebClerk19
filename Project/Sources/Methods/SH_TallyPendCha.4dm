//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/08/09, 11:09:52
// ----------------------------------------------------
// Method: SH_TallyPendCha
// Description
// 
//
// Parameters
// ----------------------------------------------------

QUERY:C277([TallyChange:65]; [TallyChange:65]Completed:6=False:C215; *)
QUERY:C277([TallyChange:65];  & [TallyChange:65]FileNum:1=(Table:C252(->[TallyResult:73])))
$0:=0
If (Records in selection:C76([TallyChange:65])>0)
	C_LONGINT:C283($i; $k; $0)
	READ WRITE:C146([DInventory:36])
	$k:=Records in selection:C76([TallyChange:65])
	FIRST RECORD:C50([TallyChange:65])
	For ($i; 1; $k)
		LOAD RECORD:C52([TallyChange:65])
		If (Not:C34(Locked:C147([TallyChange:65])))
			GOTO RECORD:C242([TallyResult:73]; [TallyChange:65]LongIntKey:4)
			LOAD RECORD:C52([TallyResult:73])
			If (Not:C34(Locked:C147([TallyResult:73])))
				C_POINTER:C301($changeField)
				$changeField:=Field:C253([TallyChange:65]FileNum:1; [TallyChange:65]FieldNum:2)
				If (Type:C295($changeField->)=6)
					$changeField->:=[TallyChange:65]BooleanValue:8
				Else 
					$changeField->:=$changeField->+[TallyChange:65]ChangeID:5
				End if 
				SAVE RECORD:C53([TallyResult:73])
				[TallyChange:65]Completed:6:=True:C214
				SAVE RECORD:C53([TallyChange:65])
			End if 
		End if 
		NEXT RECORD:C51([TallyChange:65])
	End for 
	READ ONLY:C145([DInventory:36])
	QUERY:C277([TallyChange:65]; [TallyChange:65]Completed:6=False:C215; *)
	QUERY:C277([TallyChange:65];  & [TallyChange:65]FileNum:1=(->[TallyResult:73]))
	$0:=Records in selection:C76([TallyChange:65])
End if 