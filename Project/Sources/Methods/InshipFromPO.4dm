//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/20/13, 22:33:39
// ----------------------------------------------------
// Method: InshipFromPO
// Description
// 
//
// Parameters
// ----------------------------------------------------




myOK:=12

ControlRecCheck
DISABLE MENU ITEM:C150(1; 4)
FORM SET INPUT:C55([Control:1]; "InshipAdj")
MODIFY RECORD:C57([Control:1])
Try_AdjRayFill(0)
myOK:=33

