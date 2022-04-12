//%attributes = {"publishedWeb":true}
Process_InitLocal
ControlRecCheck
C_LONGINT:C283($viProcess)
$viProcess:=Current process:C322
SET MENU BAR:C67(6; $viProcess; *)
DISABLE MENU ITEM:C150(1; 4)
FORM SET INPUT:C55([Control:1]; "QA")
Open window:C153(Screen width:C187-580; 50; Screen width:C187-20; 700; 5; "Questions & Answers"; "Wind_CloseBox")
DIALOG:C40([Control:1]; "QA")
CLOSE WINDOW:C154
//ptCurFile:=([Control])
// calSupport:=File([Service])//to be used for mixing calanders between files
//ProcessTableOpen ([Control])