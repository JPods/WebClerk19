//%attributes = {"publishedWeb":true}
//Procedure: FlxShip_OpenWin

C_LONGINT:C283($i; $k; $found)
C_BOOLEAN:C305($doPrcWind)
<>prcControl:=0
$doPrcWind:=True:C214
Process_InitLocal
ControlRecCheck
DISABLE MENU ITEM:C150(1; 4)
FORM SET INPUT:C55([Control:1]; "FlexShip")
ptCurTable:=(->[Control:1])
jSetMenuNums(1; 5; 6)
Open window:C153(Screen width:C187-635; 40; Screen width:C187-4; 475; 4; "FlexShip")
ProcessTableOpen(->[Control:1])
FlxShip_FillRay(0)


