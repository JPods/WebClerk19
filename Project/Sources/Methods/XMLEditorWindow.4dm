//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/30/21, 22:08:27
// ----------------------------------------------------
// Method: XMLEditorWindow
// Description
// 
// Parameters
// ----------------------------------------------------


//July 10, 1996
C_LONGINT:C283($i)
C_POINTER:C301($ptVar)
If (<>prcControl=1)
	<>prcControl:=0
	//Open window(4;40;635;600;8)
	Process_InitLocal
	WindowOpenTaskOffSets(0; 30; 270)
	ptCurTable:=(->[Control:1])
End if 
ControlRecCheck
FORM SET INPUT:C55([Control:1]; "XMLEditor")
ptCurTable:=(->[Control:1])
// calSupport:=File([Service])//to be used for mixing calanders between files
ProcessTableOpen(->[Control:1]; "skip")