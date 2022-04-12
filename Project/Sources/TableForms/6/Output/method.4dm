C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
		
	: ($formEvent=On Double Clicked:K2:5)
		
		If ((ptCurTable=(->[Project:24])) & (Record number:C243([Service:6])>-1))
			TRACE:C157
			ONE RECORD SELECT:C189([Service:6])
			ProcessTableOpen(Table:C252(->[Service:6])*-1)
			DELAY PROCESS:C323(Current process:C322; 30)
			QUERY:C277([Service:6]; [Service:6]projectNum:28=[Project:24]projectNum:1)
		End if 
		
	: ($formEvent=On Activate:K2:9)
		FormEventOnActivate
	: ($formEvent=On Close Detail:K2:24)
		FormEventCloseDetail
	: ($formEvent=On Unload:K2:2)
		FormEventOnUnloadOLO
	: ($formEvent=On Display Detail:K2:22)
		FormEventOnDisplayDetail
	: ($formEvent=On Header:K2:17)
		FormEventOnHeader
	: ($formEvent=On Selection Change:K2:29)
		FormEventOnSelectionChange
	: ($formEvent=On Open Detail:K2:23)
		FormEventOnOpenDetail
	: ($formEvent=On Close Box:K2:21)
		FormEventOnCloseBox
	: (($formEvent=On Load:K2:1) & (vHere<<>outLayoutTrigger))  //In header
		If (False:C215)
			TCNavigationChange005
		End if 
		jsetInHeader(->[Service:6])
		OLO_HereAndMenu
		//: ($formEvent=On Header)
	: ($formEvent=On Outside Call:K2:11)  // (Outside call)
		Prs_OutsideCall
End case 

