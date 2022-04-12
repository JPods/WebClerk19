//%attributes = {"publishedWeb":true}
//C_Longint($tempBase)
//C_BOOLEAN($endLoop)
//C_TEXT($tempSale)
<>prcControl:=0
Process_InitLocal
WindowOpenTaskOffSets
ptCurTable:=(->[Customer:2])
//
ControlRecCheck
DISABLE MENU ITEM:C150(1; 4)
TRACE:C157
FORM SET INPUT:C55([Control:1]; "Requisition")
ProcessTableOpen(->[Control:1])
