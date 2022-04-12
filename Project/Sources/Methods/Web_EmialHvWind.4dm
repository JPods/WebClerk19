//%attributes = {"publishedWeb":true}
//Procedure: TC_LaunchWindow
C_LONGINT:C283($i; $k; $found)
C_BOOLEAN:C305($doPrcWind)
<>prcControl:=0
$doPrcWind:=True:C214
Process_InitLocal
ControlRecCheck
DISABLE MENU ITEM:C150(1; 4)
FORM SET INPUT:C55([Control:1]; "eMailHav")
ptCurTable:=(->[Control:1])
jSetMenuNums(1; 5; 6)
Open window:C153(Screen width:C187-460; 42; Screen width:C187-6; 210; 8; "Email Harvest"; "")
ProcessTableOpen(->[Control:1])