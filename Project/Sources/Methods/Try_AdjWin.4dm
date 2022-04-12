//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/24/13, 15:08:51
// ----------------------------------------------------
// Method: Try_AdjWin
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("Archive"))
	If (<>prcControl=1)
		<>prcControl:=0
		//Open window(4;40;635;475;8)
		Open window:C153(4; 40; 770; 560; 8)
		Process_InitLocal
		ptCurTable:=(->[Control:1])
	End if 
	ControlRecCheck
	DISABLE MENU ITEM:C150(1; 4)
	FORM SET INPUT:C55([Control:1]; "InshipAdj")
	ProcessTableOpen(->[Control:1])
	Try_AdjRayFill(0)
	jsetDefaultFile(->[Item:4])
	C_LONGINT:C283($viProcess)
	$viProcess:=Current process:C322
	SET MENU BAR:C67(splashMenu; $viProcess; *)
End if 

