//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-26T00:00:00, 08:15:47
// ----------------------------------------------------
// Method: Item_Info2Ray
// Description
// Modified: 08/26/13
// 
// 
//
// Parameters
// ----------------------------------------------------


MESSAGES OFF:C175
C_LONGINT:C283($1)
C_POINTER:C301($2)
If ([Item:4]itemNum:1#$2->)
	QUERY:C277([Item:4]; [Item:4]itemNum:1=$2->)
End if 
C_LONGINT:C283($i; $k; $subInc; $subCnt)
List_RaySize(0)
List_RaySize(5)
//use "h" to trigger a search

aLsSrRec{1}:=-1  //Record number([Item])
aLsSrRec{2}:=-1  //Record number([Item])
aLsSrRec{3}:=-1  //Record number([Item])
aLsSrRec{4}:=-1  //Record number([Item])
aLsSrRec{5}:=-1  //Record number([Item])
aLsDocType{1}:="h"
aLsDocType{2}:="h"
aLsDocType{3}:="h"
aLsDocType{4}:="h"
aLsDocType{5}:="h"

aLsItemNum{1}:="Price Avg/A-D"
aLsItemDesc{1}:=String:C10(Round:C94([Item:4]avgSellPrice:51; 2))
aLsQtyOH{1}:=[Item:4]priceA:2
aLsQtySO{1}:=[Item:4]priceB:3
aLsQtyPO{1}:=[Item:4]priceC:4
aLsMargin{1}:=[Item:4]priceD:5
//
aLsItemNum{2}:="Cost Last/Std"
aLsItemDesc{2}:=String:C10([Item:4]dateLastCost:54)
aLsQtyOH{2}:=[Item:4]costLastInShip:47
aLsQtySO{2}:=[Item:4]costAverage:13
//
aLsItemNum{3}:="UM/OH/SO/PO/Dif"
aLsItemDesc{3}:=[Item:4]unitOfMeasure:11
aLsQtyOH{3}:=[Item:4]qtyOnHand:14
aLsQtySO{3}:=[Item:4]qtyOnSalesOrder:16
aLsQtyPO{3}:=[Item:4]qtyOnPo:20
aLsLeadTime{3}:=Round:C94([Item:4]qtyOnHand:14-[Item:4]qtyOnSalesOrder:16; 0)

aLsItemNum{4}:="Vendor/Lead/RO"
aLsItemDesc{4}:=[Item:4]vendorID:45+" - "+[Item:4]vendorItemNum:40
aLsQtyOH{4}:=[Item:4]leadTimeSales:12
aLsQtySO{4}:=[Item:4]reOrdQty:27

aLsItemNum{5}:="Mfg"
aLsItemDesc{5}:=[Item:4]mfrID:53+" - "+[Item:4]mfrItemNum:39

//
// -- AL_SetHeaders($1; 1; 8; "T"; [Item]itemNum; [Item]description; ""; ""; ""; ""; "")
// -- AL_SetHeaders($1; 9; 8; ""; ""; ""; ""; ""; ""; ""; "")
// -- AL_SetWidths($1; 1; 8; 3; 81; 80; 45; 45; 45; 45; 30)
// -- AL_SetWidths($1; 9; 8; 3; 3; 30; 30; 61; 120; 120; 30)
//  --  CHOPPED  AL_UpdateArrays($1; -2)
UNLOAD RECORD:C212([Item:4])
MESSAGES ON:C181