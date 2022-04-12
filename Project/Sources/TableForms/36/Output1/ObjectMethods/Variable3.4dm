// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 04/04/13, 10:23:21
// ----------------------------------------------------
// Method: Object Method: b11
// Description
// File: Object Method: [dInventory]odInventory_9.b11.txt
// Parameters
// ----------------------------------------------------
//### jwm ### 20130404_1022 use existing siteID from dInventory record

If (False:C215)
	//Date: 03/15/02
	//Who: Dan Bentson, Arkware
	//Description: Bug fix.  Qty adjust only asked once now
	VERSION_960
End if 

FIRST RECORD:C50([DInventory:36])
C_POINTER:C301($ptField)
C_BOOLEAN:C305($doBOM)
C_TEXT:C284($doFileLtr)
$doBOM:=False:C215
Case of 
	: ([DInventory:36]typeID:14="")  // Modified by: williamjames (111216 checked for <= length protection)
		$doFileLtr:="p"
	: ([DInventory:36]typeID:14[[1]]="i")
		$ptField:=(->[DInventory:36]qtyOnHand:2)
		CONFIRM:C162("Adjust Inventory base on changes in INVOICES."+"\r"+"\r"+"Changes CANNOT be undone?")
		$doBOM:=(OK=1)
		$doFileLtr:="i"
	: ([DInventory:36]typeID:14[[1]]="s")
		$ptField:=(->[DInventory:36]qtyOnSO:3)
		CONFIRM:C162("Adjust BOM by On Order Qty."+"\r"+"\r"+"Changes CANNOT be undone?")
		$doBOM:=(OK=1)
		$doFileLtr:="s"
	Else 
		$doFileLtr:="p"
End case 
If ($doBOM)
	C_LONGINT:C283($i; $k; $e; $f; $totalCnt)
	C_TEXT:C284($partNum; $docType; $docID)
	C_REAL:C285($qtyTotal; $offBy; $belowZero; $fullCost)
	CONFIRM:C162("Are you sure, changes CANNOT be undone?")
	If (OK=1)
		
		C_BOOLEAN:C305($AccountForQtyOnHand)
		CONFIRM:C162("Do you want to account for Quantity on Hand?")
		$bAccountForQtyOnHand:=(OK=1)
		
		ORDER BY:C49([DInventory:36]itemNum:1)
		$i:=0  //[dInventory]QtyOnHand
		$k:=Records in selection:C76([DInventory:36])
		FIRST RECORD:C50([DInventory:36])
		While ($i<$k)
			$totalCnt:=0
			$partNum:=[DInventory:36]itemNum:1
			QUERY:C277([Item:4]; [Item:4]itemNum:1=$partNum)
			$belowZero:=[Item:4]qtyOnHand:14*Num:C11([Item:4]qtyOnHand:14<0)
			$vrOffBy:=0
			Repeat 
				$i:=$i+1
				$totalCnt:=$totalCnt+$ptField->
				NEXT RECORD:C51([DInventory:36])
			Until ([DInventory:36]itemNum:1#$partNum)
			If ($doFileLtr="s")
				$totalCnt:=-$totalCnt
			End if 
			
			QUERY:C277([BOM:21]; [BOM:21]itemNum:1=$partNum)
			If (Records in selection:C76([BOM:21])>0)
				$adjID:=DateTime_Enter
				vsiteID:=[DInventory:36]siteID:20  //### jwm ### 20130404_1022 use existing siteID from dInventory record
				vR1:=BOM_Consume(-1111; ->[Item:4]itemNum:1; $totalCnt; $adjID; $bAccountForQtyOnHand)
				//Invt_dRecCreate ("BM";$adjID;0;"BOM";0;"Build by BOM";4;0;$partNum
				//;-$totalCnt;0;vR1;"";vsiteID;0)
			End if 
		End while 
		
		REDUCE SELECTION:C351([DInventory:36]; 0)
		If (Size of array:C274(dItemNumKey)>0)
			// READ WRITE([dInventory])
			// RRAY TO SELECTION(dItemNumKey;[dInventory]ItemNum;dQtyOnHand;[dInventory]QtyOnHand;dQtyOnSO;[dInventory]QtyOnSO;dQtyOnPO;[dInventory]QtyOnPO;dQtyOnWO;[dInventory]QtyOnWO;dQtyOnAdj;[dInventory]QtyOnAdj;dUnitCost;[dInventory]UnitCost;dJobID;[dInventory]projectNum;dDocID;[dInventory]DocID;dLineNum;[dInventory]UniqueIDLine;dReceiptID;[dInventory]ReceiptID;dSource;[dInventory]custVendID;dReason;[dInventory]Reason;dType;[dInventory]typeID;dDTCreated;[dInventory]DTCreated;dNote;[dInventory]Note;dTakeAction;[dInventory]TakeAction;dSite;[dInventory]siteID;dUnitPrice;[dInventory]UnitPrice;dChangeBy;[dInventory]ChangedBy;dTableNum;[dInventory]TableNum)
			// READ ONLY([dInventory])
			// IVNT_dRayInit 
			
			dInventoryFillFromArray
			
		End if 
		
		TallyInventory
		SET WINDOW TITLE:C213(Table name:C256(ptCurTable)+":  "+String:C10(Records in selection:C76(ptCurTable->)))
	End if 
End if 

