//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-26T00:00:00, 08:18:14
// ----------------------------------------------------
// Method: List_Adjustment
// Description
// Modified: 08/26/13
// 
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1)

//TRACE
C_POINTER:C301($2)
C_LONGINT:C283($i; $k)
SELECTION TO ARRAY:C260([Item:4]retired:64; aTmpBoo3; [Item:4]backOrder:24; aTmpBoo1; [Item:4]serialized:41; aTmpBoo2; [Item:4]itemNum:1; aLsItemNum; [Item:4]description:7; aLsItemDesc; [Item:4]; aLsSrRec; [Item:4]qtyOnHand:14; aLsQtyOH; [Item:4]costAverage:13; aLsCost; [Item:4]leadTimeSales:12; aLsLeadTime; [Item:4]bomHasChild:48; aLsItemChild)
$k:=Size of array:C274(aTmpBoo1)
List_RaySize($k)
ARRAY REAL:C219(aLsDiscount; $k)  //Discount
ARRAY REAL:C219(aLsDiscountPrice; $k)  //Discounted Price
For ($i; 1; $k)
	aLsDocType{$i}:=""
	aLsReason{$i}:=""
	aLSQtyPO{$i}:=aLsQtyOH{$i}  //set total equal to current on hand
	If (aTmpBoo3{$i})  //[Item]BackOrder
		aLsDocType{$i}:="R"
	End if 
	If (aTmpBoo1{$i})  //[Item]BackOrder
		aLsDocType{$i}:=aLsDocType{$i}+"b"
	End if 
	If (aTmpBoo2{$i})  //([Item]Serialized)
		aLsDocType{$i}:="s"+aLsDocType{$i}
	End if 
	If (aLsItemChild{$i})
		aLsItemChildStr{$i}:="X"
	Else 
		aLsItemChildStr{$i}:=" "
	End if 
	aLsDiscount{$i}:=0
	aLsDiscountPrice{$i}:=0
End for 