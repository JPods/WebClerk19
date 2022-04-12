//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: PKFindinOrdLine
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
$imagePath:=""
QUERY:C277([Item:4]; [Item:4]itemNum:1=aOItemNum{aoLnSelect{1}})
If (Records in selection:C76([Item:4])=1)
	srItem:=[Item:4]itemNum:1
	srItemAltNum:=aOAltItem{aoLnSelect{1}}
	srItemDscrp:=[Item:4]description:7
	//Item_GetSpec 
	ImageGetPict
	UNLOAD RECORD:C212([Item:4])
	UNLOAD RECORD:C212([ItemSpec:31])
End if 
$packQty:=aOQtyBL{aoLnSelect{1}}-aOQtyPack{aoLnSelect{1}}
iLoReal1:=$packQty
iLoReal2:=Round:C94($packQty*aOUnitWt{aoLnSelect{1}}; viWtPrecision)
iLoReal7:=0
iLoReal8:=0
READ ONLY:C145([Item:4])
// TRACE
Case of 
	: (viScanByAction=1)
		iLoReal3:=Num:C11($packQty>0)
		iLoReal4:=Round:C94(iLoReal3*aOUnitWt{aoLnSelect{1}}; viWtPrecision)
	Else 
		iLoReal3:=$packQty
		iLoReal4:=Round:C94(iLoReal3*aOUnitWt{aoLnSelect{1}}; viWtPrecision)
End case 