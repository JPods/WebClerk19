//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/08/13, 01:09:07
// ----------------------------------------------------
// Method: PO_LnRtnValueWa
// Description
// 
//
// Parameters
// ----------------------------------------------------
//// Modified by: williamjames (130308)
//Procedure: PO_LnRtnValueWa
C_REAL:C285($1; $2)
C_REAL:C285(pQtySO; pQtyPO; pCostLast; pCostAverage; pQtyOH; pQtyAvailable)
C_POINTER:C301($3)
READ ONLY:C145([Item:4])
QUERY:C277([Item:4]; [Item:4]itemNum:1=$3->)  //aPoItemNum{aPOLineAction})
pQtyAvailable:=[Item:4]qtyAvailable:73
pQtyOH:=[Item:4]qtyOnHand:14
pQtySO:=[Item:4]qtyOnSalesOrder:16
pQtyPO:=[Item:4]qtyOnPo:20
pCostLast:=[Item:4]costLastInShip:47
pCostAverage:=[Item:4]costAverage:13
If ($1<0)  // (pQtyShip<0)
	If ([Item:4]costAverage:13#[Item:4]costLastInShip:47)
		ALERT:C41("On saving, journals will account for diff:"+"\r"+"Inventory value: "+String:C10([Item:4]costAverage:13)+"\r"+"Return value: "+String:C10($2))
	End if 
End if 
READ WRITE:C146([Item:4])
UNLOAD RECORD:C212([Item:4])