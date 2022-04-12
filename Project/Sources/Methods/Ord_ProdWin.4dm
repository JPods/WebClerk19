//%attributes = {"publishedWeb":true}
//Procedure: Ord_ProdWin
<>prcControl:=0
$doPrcWind:=True:C214
Process_InitLocal
ControlRecCheck

jSetMenuNums(1; 5; 6)


C_LONGINT:C283($screenHeight; $screenWidth)
$screenHeight:=Screen height:C188
$screenWidth:=Screen width:C187
If ($screenWidth>1000)
	Open window:C153(4; 40; 1000; 830; 8; "Order Production"; "")
Else 
	Open window:C153(4; 40; 635; 600; 8; "Order Production"; "")
End if 
ptCurTable:=(->[Control:1])
FORM SET INPUT:C55([Control:1]; "Production")
ProcessTableOpen(->[Control:1])
//Process_Running 