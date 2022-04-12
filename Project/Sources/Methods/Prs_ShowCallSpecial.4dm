//%attributes = {"publishedWeb":true}
//Method: Prs_ShowCallSpecial



If (Application type:C494#4D Server:K5:6)
	DELAY PROCESS:C323(Current process:C322; <>delayProcessUnload)  // 
	
	
	C_LONGINT:C283($viProcess; $1; seniorProcess)
	seniorProcess:=$1
	$viProcess:=Current process:C322
	SET MENU BAR:C67(6; $viProcess; *)
	Process_InitLocal
	myOK:=0
	ptCurTable:=<>ptCurTable
	myOK:=1
	<>prcControl:=0
	//<>aPrsName{$viProcess}:="SalesSpecial"
	doService:=True:C214  //mark service changes
	C_LONGINT:C283($theOffSet)
	READ ONLY:C145([Item:4])
	WindowOpenTaskOffSets
	ControlRecCheck
	//DISABLE MENU ITEM(1;4)
	FORM SET INPUT:C55([Control:1]; "SalesActions")
	ProcessTableOpen(->[Control:1])
	//Prs_ListActive 
End if 