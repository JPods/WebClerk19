//%attributes = {"publishedWeb":true}
//Method: ShowInshipOpen
If (<>prcControl=1)
	<>prcControl:=0
	Open window:C153(4; 40; 635; 475; 8)
	Process_InitLocal
	ptCurTable:=(->[Control:1])
End if 
QUERY:C277([InventoryStack:29]; [InventoryStack:29]qtyAvailable:14#0)
ProcessTableOpen(->[InventoryStack:29])