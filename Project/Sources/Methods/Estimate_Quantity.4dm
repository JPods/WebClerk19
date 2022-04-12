//%attributes = {}
//C_Longint($tempBase)
//C_BOOLEAN($endLoop)
//C_TEXT($tempSale)
<>prcControl:=0
//Open window(Screen width-635;40;Screen width-4;550;4;"QuickQuote")
WindowOpenTaskOffSets
Process_InitLocal
ptCurTable:=(->[Customer:2])
//
vUseBase:=2
//$floatWindow:=False
//$tempBase:=vUseBase
//$tempSale:=<>aTypeSale{1}
//DELETE ELEMENT(<>aTypeSale;1;1)
bItemShow:=0
vPartNum:=""
srItem:=""
srItemMfgItemNum:=""
srItemDscrp:=""
srItemType:=""
srItemsProfile1:=""
srItemsProfile2:=""
srItemsProfile3:=""
srItemsProfile4:=""
srItemsProfile5:=""

ControlRecCheck
FORM SET INPUT:C55([Control:1]; "Estimating")

ProcessTableOpen(->[Control:1])


bItemShow:=0
vPartNum:=""
srItem:=""
srItemMfgItemNum:=""
srItemDscrp:=""
srItemType:=""
srItemsProfile1:=""
srItemsProfile2:=""
srItemsProfile3:=""
srItemsProfile4:=""
srItemsProfile5:=""
READ WRITE:C146([Item:4])
READ WRITE:C146([ItemSpec:31])
//vUseBase:=$tempBase
//If ((vHere>2)&((ptCurFile=([Order]))|(ptCurFile=([Invoice]))|
//(ptCurFile=([PO]))|(ptCurFile=([Proposal]))))
//doItemList:=True
//End if 
//If (Screen width<520)
//SET ENTERABLE(srItem;False)
//SET ENTERABLE(srItemDscrp;False)
//SET ENTERABLE(srItemType;False)
//SET ENTERABLE(srItemsProfile1;False)
//SET ENTERABLE(srItemsProfile2;False)
//SET ENTERABLE(srItemsProfile3;False)
//SET ENTERABLE(srItemsProfile4;False)
//End if 