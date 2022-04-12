
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/05/19, 08:15:12
// ----------------------------------------------------
// Method: [ChangeLog].Output
// Description
// 
//
// Parameters
// ----------------------------------------------------

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
	: (($formEvent=On Load:K2:1) & (vHere<<>outLayoutTrigger))  //In header
		If (UserInPassWordGroup("Control"))
			
			jsetInHeader(->[ChangeLog:149])
			OLO_HereAndMenu
		End if 
		//: ($formEvent=On Header)
	: ($formEvent=On Outside Call:K2:11)  // (Outside call)
		Prs_OutsideCall
End case 

