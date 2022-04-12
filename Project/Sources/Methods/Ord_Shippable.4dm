//%attributes = {"publishedWeb":true}
C_LONGINT:C283($k; $i)
//acceptOrders 
//TallyInventory 
vMod:=calcOrder(True:C214)
READ ONLY:C145([Item:4])
$k:=Size of array:C274(aOItemNum)
ARRAY TEXT:C222(aPartNum; $k)
ARRAY TEXT:C222(aPartDesc; $k)
ARRAY REAL:C219(aPartQty; $k)  //BL
ARRAY REAL:C219(aQtyOnHand; $k)  //shippable
ARRAY REAL:C219(aCosts; $k)  //ext cost
ARRAY REAL:C219(aQtyOrd; $k)  //ext price  
C_REAL:C285($sumPrice; $sumWt; $sumCost)
$sumPrice:=0
$sumCost:=0
$sumWt:=0
For ($i; 1; $k)
	aPartNum{$i}:=aOItemNum{$i}  //aOItemNum//[OrderLine]ItemNum
	aPartDesc{$i}:=aODescpt{$i}  //aODescpt//[OrderLine]Description
	aPartQty{$i}:=aOQtyBL{$i}  //aOQtyBL//[OrderLine]QtyBackOrdered  
	QUERY:C277([Item:4]; [Item:4]itemNum:1=aPartNum{$i})
	
	$avail:=[Item:4]qtyOnHand:14-[Item:4]qtyOnSalesOrder:16
	Case of 
		: ($avail<=0)  //none to ship
			aQtyOnHand{$i}:=0  //qty to ship      
		: ($avail>=aPartQty{$i})  //more than is needed
			aQtyOnHand{$i}:=aPartQty{$i}  //aOUnitPrice;aODiscnt;<>tcDecimalUP)            
		Else 
			aQtyOnHand{$i}:=$avail  //aOUnitPrice;aODiscnt;<>tcDecimalUP)  
	End case 
	aCosts{$i}:=Round:C94(aQtyOnHand{$i}*aOUnitCost{$i}; <>tcDecimalUP)
	aQtyOrd{$i}:=Round:C94(aQtyOnHand{$i}*aODscntUP{$i}; <>tcDecimalUP)
	$sumCost:=$sumCost+aCosts{$i}
	$sumPrice:=$sumPrice+aQtyOrd{$i}
	$sumWt:=$sumWt+(aQtyOnHand{$i}*aOUnitWt{$i})
End for 
C_REAL:C285(vR10)
vR1:=$sumCost
vR2:=$sumPrice
vR10:=$sumWt
//ShippingCost ([Order]ShipVia;[Order]Zone;[Order]WeightEstimate;
//[Order]ShipFreightCost;[Order]ShipMiscCosts;[Order]ShipAdjustments;
//[Order]Terms;[Order]Amount;[Order]LabelCount)
vR9:=0  //must be set so it will calc
vR8:=0
vR7:=0
If ([Order:3]autoFreight:40)
	ShippingCost(->[Order:3]shipVia:13; ->[Order:3]zone:14; ->vR10; ->vR7; ->vR8; ->vR9; ->[Order:3]terms:23; ->vR2; ->[Order:3]labelCount:32)
End if 
vR3:=vR7+vR8+vR9
vR4:=Round:C94(vR2+vR3; <>tcDecimalUP)
vR5:=[Order:3]amount:24+[Order:3]shipTotal:30
vR7:=[Order:3]amount:24-[Order:3]totalCost:42
vR6:=Round:C94(vR7/[Order:3]amount:24*100; 1)
vR9:=vR2-vR1
vR8:=Round:C94(vR9/vR2*100; 1)
Open window:C153(Screen width:C187-464; 40; Screen width:C187-4; 308; -724; "Shippable"; "Wind_CloseBox")
//jCenterWindow (460;268;1)
DIALOG:C40([Order:3]; "Shippable")
CLOSE WINDOW:C154
List_RaySize(0)
//  --  CHOPPED  AL_UpdateArrays(eItemOrd; -2)
READ WRITE:C146([Item:4])