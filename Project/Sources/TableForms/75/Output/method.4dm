
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 06/23/16, 15:03:07
// ----------------------------------------------------
// Method: [EventLog].Output
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160623_1503 added eventID as Column 1
// ### jwm ### 20180130_1340 added splitters to columns

C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
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
	: ($formEvent=On Clicked:K2:4)
		FormEventOnClicked
	: ($formEvent=On Double Clicked:K2:5)
		FormEventOnDoubleClicked
	: (($formEvent=On Load:K2:1) & (vHere<<>outLayoutTrigger))  //In header
		If (UserInPassWordGroup("Time"))
			jsetInHeader(->[EventLog:75])
			OLO_HereAndMenu
		End if 
		//: ($formEvent=On Header)
	: ($formEvent=On Outside Call:K2:11)  // (Outside call)
		Prs_OutsideCall
End case 

