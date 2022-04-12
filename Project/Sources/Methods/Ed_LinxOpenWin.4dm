//%attributes = {"publishedWeb":true}
//Procedure: Ed_LinxOpenWin
//Thursday, October 15, 1998
C_LONGINT:C283($i)
C_POINTER:C301($ptVar)
If (<>prcControl=1)
	<>prcControl:=0
	Process_InitLocal
	WindowOpenTaskOffSets
	ptCurTable:=(->[Control:1])
End if 
ControlRecCheck
FORM SET INPUT:C55([Control:1]; "Linx")
ptCurTable:=(->[Control:1])
// calSupport:=File([Service])//to be used for mixing calanders between files
ProcessTableOpen(->[Control:1]; "skip")