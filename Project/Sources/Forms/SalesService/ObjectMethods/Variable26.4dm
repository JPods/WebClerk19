// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/08/10, 09:37:50
// ----------------------------------------------------
// Method: Object Method: <>aServOpt
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($obEvent)
$obEvent:=FORM Event:C1606
Case of 
	: ($obEvent.code=On Load:K2:1)
		
	: (<>aServOpt>1)
		
		READ ONLY:C145([TallyMaster:60])
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="ServiceOptions"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=<>aServOpt{<>aServOpt})
		If (Records in selection:C76([TallyMaster:60])=1)
			ExecuteText(0; [TallyMaster:60]script:9)
			READ WRITE:C146([TallyMaster:60])
			vMod:=False:C215
			doSearch:=6
		Else 
			BEEP:C151
		End if 
	: (<>aServOpt=1)
		KeyModifierCurrent
		If (OptKey=1)
			TRACE:C157
			C_BOOLEAN:C305($inGroup)
			$inGroup:=UserInPassWordGroup("UnlockRecord")
			If ($inGroup)
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="ServiceOptions")
				If (Records in selection:C76([TallyMaster:60])>0)
					ProcessTableOpen(Table:C252(->[TallyMaster:60])*-1)
				End if 
			End if 
		End if 
End case 