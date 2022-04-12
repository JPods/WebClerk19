// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 07/27/16, 14:49:14
// ----------------------------------------------------
// Method: [Customer].Output
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160727_1449 reset tab order Search field first

C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
		//: ($formEvent=On Double Clicked)
		// FormEventOnDoubleClicked
	: ($formEvent=On Double Clicked:K2:5)
		FormEventOnActivate
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
		jsetInHeader(->[Customer:2])
		OLO_HereAndMenu
		
		
		ARRAY TEXT:C222(alo001; 5)
		alo001{1}:="Actions"
		alo001{2}:="Make"
		alo001{3}:="Add"
		alo001{4}:="Subtract"
		alo001{5}:="Clear"
		
		alo001:=1
		
		If (Records in selection:C76([Customer:2])=2)
			OBJECT SET ENABLED:C1123(b11; True:C214)
			OBJECT SET ENABLED:C1123(b12; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(b11; False:C215)
			OBJECT SET ENABLED:C1123(b12; False:C215)
		End if 
		
		LoadCustomFields  // load custom user fields
		
		//: ($formEvent=On Header)
	: ($formEvent=On Outside Call:K2:11)  // (Outside call)
		Prs_OutsideCall
	Else 
		
End case 
