//%attributes = {"publishedWeb":true}
//Procedure: TC_LaunchWindow
C_LONGINT:C283($i; $k; $found)
C_BOOLEAN:C305($doPrcWind)
<>prcControl:=0
$doPrcWind:=True:C214
Process_InitLocal
ControlRecCheck
$k:=Size of array:C274(<>aNameID)
ARRAY TEXT:C222(aText1; ($k-1))
For ($i; 2; $k)
	aText1{($i-1)}:=<>aNameID{$i}
End for 
DISABLE MENU ITEM:C150(1; 4)
FORM SET INPUT:C55([Control:1]; "Time_SignInOut")
ptCurTable:=(->[Control:1])
jSetMenuNums(1; 5; 6)
Open window:C153(Screen width:C187-650; 40; Screen width:C187-4; 550; 8; "Time clock"; "")
ProcessTableOpen(->[Control:1])