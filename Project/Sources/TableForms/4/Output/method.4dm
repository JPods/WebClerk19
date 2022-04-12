
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 06/20/16, 13:17:08
// ----------------------------------------------------
// Method: [Item].Output
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160620_1317 condensed space to make all toolbar items visible for samll windows.
// ### jwm ### 20160620_1318 deleted duplicate Script pull down menu
// ### jwm ### 20160727_1453 reset tab order Serch field first

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
		If (False:C215)
			TCNavigationChange005
		End if 
		jsetInHeader(->[Item:4])
		KeyModifierCurrent
		If (<>vbQtyAvailable)
			iLoText1:="Available"  //###_jwm_### 20100913 spelled out whole word Available
			//iLoReal1:=[Item]QtyAvailable
		Else 
			iLoText1:="O/H"
			//iLoReal1:=[Item]QtyOnHand
		End if 
		ARRAY TEXT:C222(aLooLoProcedures; 7)
		aLooLoProcedures{1}:="Procedures"
		aLooLoProcedures{2}:="BarCode39"
		aLooLoProcedures{3}:="BOM_Top Levels"
		aLooLoProcedures{4}:="LifoFifo_Value"
		aLooLoProcedures{5}:="Mark_XRef"
		aLooLoProcedures{6}:="Repeat_PriceQty"
		aLooLoProcedures{7}:="XRefLoadByClass"
		aLooLoProcedures:=1
		//
		//// Modified by: williamjames (110519)
		ORDER BY:C49([Item:4]; [Item:4]itemNum:1)
		OLO_HereAndMenu
		//: ($formEvent=On Header)
		
		//aLooLoScripts{1}:="Scripts"  // ### jwm ### 20160620_1401 where should this go ???
		//aLooLoScripts:=1  // ### jwm ### 20160620_1401 where should this go ???
		
		LoadCustomFields  // load custom user fields
		
	: ($formEvent=On Outside Call:K2:11)  // (Outside call)
		Prs_OutsideCall
End case 
