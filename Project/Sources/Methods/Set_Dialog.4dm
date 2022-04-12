//%attributes = {"publishedWeb":true}
//Procedure: Set_Dialog
//jCenterWindow (410;555;3)  //600

$vhReference:=Open form window:C675([Control:1]; "diaSets")
DIALOG:C40([Control:1]; "diaSets")

//CLOSE WINDOW
C_LONGINT:C283($viProcess)
$viProcess:=Current process:C322

Case of 
	: (vHere=0)
		SET MENU BAR:C67(splashMenu; $viProcess; *)
	: (vHere=1)
		SET MENU BAR:C67(oLoMenu; $viProcess; *)
	Else 
		SET MENU BAR:C67(iLoMenu; $viProcess; *)
End case 

ARRAY LONGINT:C221(aTmpLong2; 0)
ARRAY LONGINT:C221(aTmpLong1; 0)
ARRAY TEXT:C222(aText4; 0)
ARRAY TEXT:C222(aText3; 0)
ARRAY TEXT:C222(aText5; 0)