//%attributes = {"publishedWeb":true}

<>prcControl:=0

Process_InitLocal
ptCurTable:=(->[Customer:2])
//
ControlRecCheck
Open window:C153(4; 40; 635; 475; 8)
DISABLE MENU ITEM:C150(1; 4)
FORM SET INPUT:C55([Control:1]; "WebSetup")
ProcessTableOpen(->[Control:1])
CLEAR VARIABLE:C89(pagePict1)
