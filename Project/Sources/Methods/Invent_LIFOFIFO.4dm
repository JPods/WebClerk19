//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-26T00:00:00, 12:20:16
// ----------------------------------------------------
// Method: Invent_LIFOFIFO
// Description
// Modified: 01/26/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($AdjCnt)
C_REAL:C285($QtyShort; $inventValue)
C_POINTER:C301($1; $2; $3; $4)  //item; qty; cost; inventory value
QUERY:C277([InventoryStack:29]; [InventoryStack:29]itemNum:2=$1->; *)
QUERY:C277([InventoryStack:29]; [InventoryStack:29]qtyAvailable:14>0)
$QtyShort:=$2->
If (vInvValue="Fifo")
	ORDER BY:C49([InventoryStack:29]; [InventoryStack:29]idNum:1; >)
Else   // (vInvValue="Lifo")  
	ORDER BY:C49([InventoryStack:29]; [InventoryStack:29]idNum:1; <)
End if 
//
$AdjCnt:=Records in selection:C76([InventoryStack:29])
$inventValue:=0
FIRST RECORD:C50([InventoryStack:29])
While ($AdjCnt>0)  //)    //(($QtyShort>0)|
	$AdjCnt:=$AdjCnt-1
	Case of 
		: ([InventoryStack:29]qtyAvailable:14<=$QtyShort)
			$inventValue:=$inventValue+([InventoryStack:29]qtyAvailable:14*[InventoryStack:29]unitCost:11)
			$QtyShort:=$QtyShort-[InventoryStack:29]qtyAvailable:14
			[InventoryStack:29]qtyAvailable:14:=0
		: (([InventoryStack:29]qtyAvailable:14>$QtyShort) & ($QtyShort>0))
			[InventoryStack:29]qtyAvailable:14:=[InventoryStack:29]qtyAvailable:14-$QtyShort
		Else 
			[InventoryStack:29]qtyAvailable:14:=0
	End case 
	SAVE RECORD:C53([InventoryStack:29])
	NEXT RECORD:C51([InventoryStack:29])
End while 
//While (($QtyShort>0)&($AdjCnt>0))
//$AdjCnt:=$AdjCnt-1
//If ([InvStack]QtyAvailable<$QtyShort)
//$inventValue:=$inventValue+([InvStack]QtyAvailable*[InvStacks
//]UnitCost)
//$QtyShort:=$QtyShort-[InvStack]QtyAvailable
//[InvStack]QtyAvailable:=0
//Else 
//[InvStack]QtyAvailable:=[InvStack]QtyAvailable-$QtyShort
//$QtyShort:=0
//End if 
//SAVE RECORD([InvStack])
//NEXT RECORD([InvStack])
//End while 
If ($QtyShort=0)
	$4->:=$inventValue
Else 
	CREATE RECORD:C68([InventoryStack:29])
	
	[InventoryStack:29]itemNum:2:=$1->
	[InventoryStack:29]dateEntered:3:=Current date:C33
	[InventoryStack:29]projectNum:4:=-2
	[InventoryStack:29]docid:5:=0
	[InventoryStack:29]changeReason:6:="autoAdjust"
	[InventoryStack:29]comment:7:=""
	[InventoryStack:29]createdBy:8:=Current user:C182
	[InventoryStack:29]dateEntered:3:=Current date:C33
	[InventoryStack:29]qtyOnHand:9:=$QtyShort  //$2-$TotAvail
	If (True:C214)  //change to run by 
		[InventoryStack:29]qtyAvailable:14:=$QtyShort  //use if totaling inventory value for item o/h
	Else 
		[InventoryStack:29]qtyAvailable:14:=0  //use if valueing invoice lines
	End if 
	[InventoryStack:29]vendorID:10:="Added by LIFOFIFO"
	[InventoryStack:29]unitCost:11:=$3->
	[InventoryStack:29]lineNum:12:=0
	[InventoryStack:29]receiptid:16:=-2
	[InventoryStack:29]extendedCost:17:=[InventoryStack:29]unitCost:11*[InventoryStack:29]qtyOnHand:9
	[InventoryStack:29]typeid:19:=-4
	SAVE RECORD:C53([InventoryStack:29])
	$4->:=$inventValue+[InventoryStack:29]extendedCost:17
End if 