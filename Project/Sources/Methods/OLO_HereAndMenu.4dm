//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/12/10, 00:28:21
// ----------------------------------------------------
// Method: OLO_HereAndMenu
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(vWindowTitle)
vHere:=1
doOLO:=False:C215
LoadCustomFields  // load custom user fields
MenuTitle
oLoMenu:=2
iLoMenu:=3
SET MENU BAR:C67(oLoMenu)
If (ptCurTable#(->[TallyMaster:60]))
	Execute_TallyMaster(Table name:C256(ptCurTable); "oloOpen")
End if 

GOTO OBJECT:C206(srkeyword)  // ### jwm ### 20190404_0919

If (Form event code:C388=On Load:K2:1)
	// ### bj ### 20190131_1722
	// I think this needs to be active  jm 95a was commented
	
	// ### jwm ### 20190208_1543 do not want to override users saved position.
	//FormSetoLoSize 
End if 
