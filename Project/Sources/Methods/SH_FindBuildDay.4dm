//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/08/09, 11:11:07
// ----------------------------------------------------
// Method: SH_FindBuildDay
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i; $k; $1; $buildRecs)
If (Count parameters:C259=0)
	$buildRecs:=1
Else 
	$buildRecs:=$1
End if 
jDateTimeUserCl  //vdStDate vdEndDate
CONFIRM:C162("Build daily pacing history from "+String:C10(vdStDate)+"; "+String:C10(vdEndDate))
If (OK=1)
	//
	QUERY:C277([TallyChange:65]; [TallyChange:65]idAlpha:1=Table:C252(->[DInventory:36]); *)
	QUERY:C277([TallyChange:65];  & [TallyChange:65]complete:6=False:C215)
	$k:=Records in selection:C76([TallyChange:65])
	If ($k>0)
		READ WRITE:C146([DInventory:36])
		READ WRITE:C146([TallyChange:65])
		FIRST RECORD:C50([TallyChange:65])
		For ($i; 1; $k)
			LOAD RECORD:C52([TallyChange:65])
			If (Not:C34(Locked:C147([TallyChange:65])))
				GOTO RECORD:C242([DInventory:36]; [TallyChange:65]idNumKey:4)
				LOAD RECORD:C52([DInventory:36])
				If (Not:C34(Locked:C147([DInventory:36])))
					
					
					// MustFixQQQZZZ: Bill James (2022-06-24T05:00:00Z)
					// look at pacing reporting
					
					//If ([TallyChange]obHistory=Table(->[DInventory]pacing))
					//[DInventory]paceTallied:=[TallyChange]booleanValue
					//SAVE RECORD([DInventory])
					//[TallyChange]complete:=True
					//SAVE RECORD([TallyChange])
					//End if 
				End if 
			End if 
		End for 
		READ ONLY:C145([TallyChange:65])
		READ ONLY:C145([DInventory:36])
	End if 
	//
	READ ONLY:C145([Customer:2])
	READ ONLY:C145([Order:3])
	READ ONLY:C145([Item:4])
	READ ONLY:C145([Rep:8])
	READ ONLY:C145([TechNote:58])
	//
	$doSkip:=(SH_TallyPendCha#0)
	If ($doSkip)
		jAlertMessage(10014)
	Else 
		$k:=vdEndDate-vdStDate+1
		TRACE:C157
		For ($i; 1; $k)
			vdEndDate:=vdStDate
			vlDTStart:=DateTime_DTTo(vdStDate; ?00:00:00?)
			vlDTEnd:=DateTime_DTTo(vdEndDate; ?23:59:59?)
			QUERY:C277([DInventory:36]; [DInventory:36]typeID:14="IV"; *)
			QUERY:C277([DInventory:36];  | [DInventory:36]typeID:14="SO"; *)
			QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15>=vlDTStart; *)
			QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15<=vlDTEnd; *)
			QUERY:C277([DInventory:36];  & [DInventory:36]paceTallied:24=False:C215; *)
			QUERY:C277([DInventory:36];  & [DInventory:36]pacing:23=True:C214)
			//  ProcessTableOpen ([dInventory])
			If (Records in selection:C76([DInventory:36])>0)
				SH_FillRays(0)
				SH_OrderElem(0)
				//If ($buildRecs=1)
				SH_BuildRecs
				//End if 
			End if 
			vdStDate:=vdStDate+1
		End for 
		READ WRITE:C146([Customer:2])
		READ WRITE:C146([Order:3])
		READ WRITE:C146([Item:4])
		READ WRITE:C146([Rep:8])
		READ WRITE:C146([TechNote:58])
		
		UNLOAD RECORD:C212([Customer:2])
		UNLOAD RECORD:C212([Order:3])
		UNLOAD RECORD:C212([Item:4])
		UNLOAD RECORD:C212([Rep:8])
		UNLOAD RECORD:C212([DInventory:36])
		UNLOAD RECORD:C212([TechNote:58])
	End if 
End if 