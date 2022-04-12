//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: TryFixInvStacks
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
$w:=0


ARRAY LONGINT:C221($aRecNum; 0)
ARRAY REAL:C219($aCostUnitGoods; 0)
ARRAY REAL:C219($aQtyGoods; 0)
ARRAY REAL:C219($aCostExtendedGoods; 0)
ARRAY TEXT:C222($aitemNumRay; 0)
TRACE:C157

FIRST RECORD:C50([POReceipt:95])
$cntPOReceipts:=Records in selection:C76([POReceipt:95])
For ($incPOReceipts; 1; $cntPOReceipts)
	QUERY:C277([InventoryStack:29]; [InventoryStack:29]receiptid:16=[POReceipt:95]idNum:1)
	SELECTION TO ARRAY:C260([InventoryStack:29]; $aRecNum; [InventoryStack:29]unitCost:11; $aCostUnitGoods; [InventoryStack:29]qtyOnHand:9; $aQtyGoods; [InventoryStack:29]extendedCost:17; $aCostExtendedGoods; [InventoryStack:29]itemNum:2; $aitemNumRay)
	$cntRay:=Size of array:C274($aRecNum)
	If ($cntRay<1)
		ALERT:C41("No Stacks: "+String:C10([POReceipt:95]idNum:1))
		[POReceipt:95]comment:9:="No Stacks for this PO Receipt"
		SAVE RECORD:C53([POReceipt:95])
		[POReceipt:95]stackValues:10:=0
	Else 
		If ([POReceipt:95]vendorInvoiceFreight:6#0)
			$w:=Find in array:C230($aitemNumRay; "FreightPO")
			If ($w<1)
				CREATE RECORD:C68([InventoryStack:29])
				
				[InventoryStack:29]itemNum:2:="FreightPO"
				[InventoryStack:29]unitCost:11:=1
				[InventoryStack:29]receiptid:16:=[POReceipt:95]idNum:1
				[InventoryStack:29]qtyOnHand:9:=1
				[InventoryStack:29]extendedCost:17:=[POReceipt:95]vendorInvoiceFreight:6
				[InventoryStack:29]vendorID:10:=[POReceipt:95]vendorID:3
				[InventoryStack:29]dateEntered:3:=[POReceipt:95]vendorInvoiceDate:5
				[InventoryStack:29]docid:5:=[POReceipt:95]poNum:2
				[InventoryStack:29]dateVendorInvc:27:=[POReceipt:95]vendorInvoiceDate:5
				[InventoryStack:29]tableNum:30:=Table:C252(->[POReceipt:95])
				SAVE RECORD:C53([InventoryStack:29])
				//QUERY([InvStack];[InvStack]ReceiptID=[POReceipt]ReceiptID)
				//SELECTION TO ARRAY([InvStack];$aRecNum;[InvStack]UnitCost
				//;$aCostUnitGoods;[InvStack]QtyOnHand;$aQtyGoods;[InvStack]ExtendedCost;$aCost
				//;$aitemNumRay;[InvStack]ItemNum)
			Else 
				DELETE FROM ARRAY:C228($aRecNum; $w; 1)
				DELETE FROM ARRAY:C228($aCostUnitGoods; $w; 1)
				DELETE FROM ARRAY:C228($aQtyGoods; $w; 1)
				DELETE FROM ARRAY:C228($aCostExtendedGoods; $w; 1)
				DELETE FROM ARRAY:C228($aitemNumRay; $w; 1)
				$cntRay:=$cntRay-1
			End if 
		End if 
	End if 
	$totalCosts:=0
	$totalCosts222:=0
	$totalQty:=0
	For ($incRay; 1; $cntRay)
		$totalCosts:=$totalCosts+$aCostExtendedGoods{$incRay}
		$totalQty:=$totalQty+$aQtyGoods{$incRay}
	End for 
	$costDiff:=[POReceipt:95]vendorInvoiceAmount:7-[POReceipt:95]vendorInvoiceFreight:6-$totalCosts
	If (($costDiff#0) & ($totalCosts#0))
		//If ($cntRay>1)
		ARRAY REAL:C219($aCostAdd2Line; $cntRay)
		For ($incRay; 1; $cntRay)
			$perLineFraction:=$aCostExtendedGoods{$incRay}/$totalCosts
			$aCostAdd2Line{$incRay}:=$costDiff*$perLineFraction
			$aCostExtendedGoods{$incRay}:=Round:C94($aCostExtendedGoods{$incRay}+$aCostAdd2Line{$incRay}; 2)
			$totalCosts222:=$totalCosts222+$aCostExtendedGoods{$incRay}
			If ($aQtyGoods{$incRay}#0)
				$aCostUnitGoods{$incRay}:=Round:C94($aCostExtendedGoods{$incRay}/$aQtyGoods{$incRay}; 5)
			End if 
		End for 
		$costDiff:=[POReceipt:95]vendorInvoiceAmount:7-[POReceipt:95]vendorInvoiceFreight:6-$totalCosts222
		For ($incRay; 1; $cntRay)
			GOTO RECORD:C242([InventoryStack:29]; $aRecNum{$incRay})
			If (($incRay=1) & (vR6#0))
				$aCostExtendedGoods{$incRay}:=$aCostExtendedGoods{$incRay}+$costDiff
			End if 
			[InventoryStack:29]unitCost:11:=$aCostUnitGoods{$incRay}
			[InventoryStack:29]extendedCost:17:=$aCostExtendedGoods{$incRay}
			SAVE RECORD:C53([InventoryStack:29])
		End for 
		//Else 
		//GOTO RECORD([InvStack];$aRecNum{1})
		//vR5:=$costDiff/[InvStack]QtyOnHand
		//[InvStack]UnitCost:=[InvStack]UnitCost+vR5
		//[InvStack]ExtendedCost:=Round([InvStack]UnitCost*[InvStacks
		//]QtyOnHand)
		//If ([InvStack]ExtendedCost=[POReceipt]VendorInvoiceAmount)
		////SAVE RECORD([InvStack])
		//End if 
		//End if 
	End if 
	NEXT RECORD:C51([POReceipt:95])
End for 

If (False:C215)
	myDoc:=Create document:C266("")
	If (OK=1)
		vi9:=0
		FIRST RECORD:C50([POReceipt:95])
		vi2:=Records in selection:C76([POReceipt:95])
		If (vi9=0)
			SEND PACKET:C103(myDoc; "VendorID"+"\t"+"ReceiptID"+"\t"+"PONum"+"\t"+"VendorInvoice"+"\t"+"Freight"+"\t"+"InvoiceTotal"+"\t"+"StackTotal"+"\t"+"Difference"+"\r")
		End if 
		For (vi1; 1; vi2)
			MESSAGE:C88(String:C10(vi1))
			QUERY:C277([InventoryStack:29]; [InventoryStack:29]receiptid:16=[POReceipt:95]idNum:1)
			vR1:=Sum:C1([InventoryStack:29]extendedCost:17)
			vR2:=[POReceipt:95]vendorInvoiceAmount:7-vR1
			If (Abs:C99(vR2)>1)
				If (vi9=1)
					ALERT:C41("ReceiptID/PO: "+String:C10([POReceipt:95]idNum:1)+"/"+String:C10([POReceipt:95]poNum:2)+", Off by: "+String:C10(vR2))
				Else 
					SEND PACKET:C103(myDoc; [POReceipt:95]vendorID:3+"\t"+String:C10([POReceipt:95]idNum:1)+"\t"+String:C10([POReceipt:95]poNum:2)+"\t"+[POReceipt:95]vendorInvoiceNum:4+"\t"+String:C10([POReceipt:95]vendorInvoiceFreight:6)+"\t"+String:C10([POReceipt:95]vendorInvoiceAmount:7)+"\t"+String:C10(vR1)+"\t"+String:C10(vR2)+"\r")
				End if 
			End if 
			NEXT RECORD:C51([POReceipt:95])
		End for 
		CLOSE DOCUMENT:C267(myDoc)
	End if 
	
End if 


If (False:C215)
	READ WRITE:C146([InventoryStack:29])
	FIRST RECORD:C50([POReceipt:95])
	vi2:=Records in selection:C76([POReceipt:95])
	For (vi1; 1; vi2)
		QUERY:C277([InventoryStack:29]; [InventoryStack:29]receiptid:16=[POReceipt:95]idNum:1)
		vR1:=Sum:C1([InventoryStack:29]extendedCost:17)
		vR2:=[POReceipt:95]vendorInvoiceAmount:7-vR1
		vR3:=Abs:C99(vR2)
		Case of 
			: (vi9<1)
				ALERT:C41("No Stacks: "+String:C10([POReceipt:95]idNum:1))
				[POReceipt:95]comment:9:="No Stacks for this PO Receipt"
				[POReceipt:95]stackValues:10:=0
				SAVE RECORD:C53([POReceipt:95])
			: (vR3<0.2)
				FIRST RECORD:C50([InventoryStack:29])
				LOAD RECORD:C52([InventoryStack:29])
				[InventoryStack:29]extendedCost:17:=[InventoryStack:29]extendedCost:17+vR2
				SAVE RECORD:C53([InventoryStack:29])
				[POReceipt:95]stackValues:10:=Sum:C1([InventoryStack:29]extendedCost:17)
				SAVE RECORD:C53([POReceipt:95])
		End case 
		NEXT RECORD:C51([POReceipt:95])
	End for 
	
End if 

