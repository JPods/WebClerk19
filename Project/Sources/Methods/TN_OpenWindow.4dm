//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2018-08-08T00:00:00, 20:28:44
// ----------------------------------------------------
// Method: TN_OpenWindow
// Description
// Modified: 08/08/18
// Structure: gkgkgk
// 
//
// Parameters
// ----------------------------------------------------



Process_InitLocal
<>prcControl:=0
// If (<>WriteHere)
srTNName:=""
srTNSubject:=""
ARRAY TEXT:C222(aTNName; 0)
ARRAY TEXT:C222(aTNSub; 0)
READ ONLY:C145([TechNote:58])
vi1:=0
ControlRecCheck
DISABLE MENU ITEM:C150(1; 4)
FORM SET INPUT:C55([Control:1]; "TechNote")
ptCurTable:=(->[Control:1])
jSetMenuNums(1; 5; 6)
C_LONGINT:C283($formwidth)
$formwidth:=810
If (Screen width:C187<700)
	Open window:C153(Screen width:C187-$formwidth; 40; Screen width:C187-4; 920+40; 4; "Tech Note"; "")
Else 
	Open window:C153(Screen width:C187-$formwidth-40; 40; Screen width:C187-4-40; 920+40; 4; "Tech Note"; "")
End if 
ProcessTableOpen(->[Control:1])
READ WRITE:C146([TechNote:58])
//Process_Running 
POST OUTSIDE CALL:C329(<>theProcessList)