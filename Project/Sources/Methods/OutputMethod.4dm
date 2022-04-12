//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-05-25T00:00:00, 20:42:56
// ----------------------------------------------------
// Method: OutputMethod
// Description
// Modified: 05/25/13
// 
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1)

C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Open Detail:K2:23)
		FormEventOnOpenDetail
	: ($formEvent=On Display Detail:K2:22)
		FormEventOnDisplayDetail
	: ($formEvent=On Activate:K2:9)
		FormEventOnActivate
	: ($formEvent=On Close Detail:K2:24)
		FormEventCloseDetail
	: ($formEvent=On Unload:K2:2)
		FormEventOnUnloadOLO
	: ($formEvent=On Selection Change:K2:29)
		FormEventOnSelectionChange
	: ($formEvent=On Close Box:K2:21)
		FormEventOnCloseBox
	: ($formEvent=On Header:K2:17)
		FormEventOnHeader
	: (($formEvent=On Load:K2:1) & (vHere<<>outLayoutTrigger))  //In header
		If (False:C215)
			TCNavigationChange005
		End if 
		jsetInHeader($1)
		OLO_HereAndMenu
		//: ($formEvent=On Header)
	: ($formEvent=On Outside Call:K2:11)  // (Outside call)
		Prs_OutsideCall
End case 

