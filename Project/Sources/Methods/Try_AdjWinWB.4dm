//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Try_AdjWinWB
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
TRACE:C157
//Procedure: Try_AdjWin
If (<>prcControl=1)
	<>prcControl:=0
	Open window:C153(4; 40; 944; 720; 8)
	Process_InitLocal
	ptCurTable:=(->[Control:1])
End if 
ControlRecCheck
DISABLE MENU ITEM:C150(1; 4)
FORM SET INPUT:C55([Control:1]; "VendorInvoiceAdjust")
ProcessTableOpen(->[Control:1])
Try_AdjRayFill(0)
jsetDefaultFile(->[Item:4])
C_LONGINT:C283($viProcess)
$viProcess:=Current process:C322
SET MENU BAR:C67(splashMenu; $viProcess; *)