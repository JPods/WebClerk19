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

QUERY:C277([TallyChange:65]; [TallyChange:65]complete:6=False:C215; *)
QUERY:C277([TallyChange:65];  & [TallyChange:65]idAlpha:1=(Table:C252(->[TallyResult:73])))
$0:=0
If (Records in selection:C76([TallyChange:65])>0)
	//PPP 19-FORCED
	//C_LONGINT($i; $k; $0)
	//READ WRITE([DInventory])
	//$k:=Records in selection([TallyChange])
	//FIRST RECORD([TallyChange])
	//For ($i; 1; $k)
	//LOAD RECORD([TallyChange])
	//If (Not(Locked([TallyChange])))
	//GOTO RECORD([TallyResult]; [TallyChange]idNumKey)
	//LOAD RECORD([TallyResult])
	//If (Not(Locked([TallyResult])))
	//C_POINTER($changeField)
	//$changeField:=Field([TallyChange]idAlpha; [TallyChange]fieldNum)
	//If (Type($changeField->)=6)
	//$changeField->:=[TallyChange]booleanValue
	//Else 
	//$changeField->:=$changeField->+[TallyChange]obEntity
	//End if 
	//SAVE RECORD([TallyResult])
	//[TallyChange]complete:=True
	//SAVE RECORD([TallyChange])
	//End if 
	//End if 
	//NEXT RECORD([TallyChange])
	//End for 
	READ ONLY:C145([DInventory:36])
	QUERY:C277([TallyChange:65]; [TallyChange:65]complete:6=False:C215; *)
	QUERY:C277([TallyChange:65];  & [TallyChange:65]idAlpha:1=(->[TallyResult:73]))
	$0:=Records in selection:C76([TallyChange:65])
End if 