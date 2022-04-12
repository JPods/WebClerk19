//%attributes = {"publishedWeb":true}


If (False:C215)
	//Method: TRY_InshipOpenWindow
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
TRACE:C157
If (<>prcControl=1)
	<>prcControl:=0
	Process_InitLocal
	//Open window(4+10;40+10;<>vWindowWidth+80;<>vWindowHeight+40;8)
	WindowOpenTaskOffSets(0; 80; 0)
	//WindowOpenTaskOffSets 
	ptCurTable:=(->[Item:4])
End if 
ControlRecCheck
DISABLE MENU ITEM:C150(1; 4)
FORM SET INPUT:C55([Control:1]; "InShipGoods")
//ptCurFile:=([Control])
// calSupport:=File([Service])//to be used for mixing calanders between files
ProcessTableOpen(->[Control:1])
jsetDefaultFile(->[Item:4])
C_LONGINT:C283($viProcess)
$viProcess:=Current process:C322
SET MENU BAR:C67(splashMenu; $viProcess; *)


//TryFixInvStacks 