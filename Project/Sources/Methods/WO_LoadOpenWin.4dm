//%attributes = {"publishedWeb":true}
//Procedure: WO_LoadOpenWin
//July 10, 1996
TRACE:C157
C_LONGINT:C283($i)
C_POINTER:C301($ptVar)
If (<>prcControl=1)
	<>prcControl:=0
	Process_InitLocal
	WindowOpenTaskOffSets
	ptCurTable:=(->[Control:1])
End if 
ControlRecCheck
FORM SET INPUT:C55([Control:1]; "WorkLoad")
ptCurTable:=(->[Control:1])
// calSupport:=File([Service])//to be used for mixing calanders between files
ProcessTableOpen(->[Control:1]; "skip")
WO_FillArrays(0)
Tm_FixedArray(0)
For ($i; 1; 11)
	$ptVar:=Get pointer:C304("vR"+String:C10($i))
	$ptVar->:=0
End for 
vL1:=0
vL2:=0