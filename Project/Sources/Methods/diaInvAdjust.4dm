//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/04/15, 14:01:38
// ----------------------------------------------------
// Method: diaInvAdjust
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20150721_1518 Check Authority to adjust inventory


//(P)  diaInvAdjust

C_BOOLEAN:C305($adjByBOM; $adjByItems)
$adjByBOM:=(UserInPassWordGroup("AdjustByBOM"))
$adjByItems:=(UserInPassWordGroup("AdjustByItem"))

If (Not:C34($adjByBOM | $adjByItems))
	ALERT:C41(Current user:C182+": Does Not Have Authority to Adjust Inventory")
Else 
	
	If (<>prcControl=1)
		<>prcControl:=0
		Process_InitLocal
		ptCurTable:=(->[Control:1])
	End if 
	viRecordsInSelection:=0
	vMod:=False:C215
	DISABLE MENU ITEM:C150(3; 4)
	C_LONGINT:C283($k)
	ARRAY TEXT:C222(a20Str1; 0)
	jCenterWindow(760; 550; 5; "Adjust"; "Wind_CloseBox")
	DIALOG:C40([Default:15]; "AdjustInventory")
	CLOSE WINDOW:C154
	If ((OK=1) & (vMod))
		If ($adjByItems)
			// InvtAdjDiaSave // ### jwm ### 20160119_1029 unintended changes on save
			vMod:=False:C215
		End if 
	End if 
	ENABLE MENU ITEM:C149(3; 4)
	$k:=0
	List_RaySize(0)  //initialize the arrays
	vi1:=0
	vr1:=0
	vr2:=0
	vr3:=0
	vr4:=0
	vr5:=0
	v1:=""
	v2:=""
	v3:=""
	vPartNum:=""
	ARRAY TEXT:C222(a20Str1; 0)  //clear reason array
	ARRAY TEXT:C222(aItemChild; 0)  //clear item child array
	
End if   // End Check Group