//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: DocEditorWindow
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
//July 10, 1996
C_LONGINT:C283($i)
C_POINTER:C301($ptVar)
If (<>prcControl=1)
	<>prcControl:=0
	Open window:C153(4; 40; 657; 604; 8)
	Process_InitLocal
	ptCurTable:=(->[Control:1])
End if 
ControlRecCheck
FORM SET INPUT:C55([Control:1]; "DocumentManagement")
ptCurTable:=(->[Control:1])
// calSupport:=File([Service])//to be used for mixing calanders between files
ProcessTableOpen(->[Control:1]; "skip")