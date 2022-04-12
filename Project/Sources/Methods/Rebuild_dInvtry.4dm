//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-17T00:00:00, 11:54:57
// ----------------------------------------------------
// Method: Rebuild_dInvtry
// Description
// Modified: 01/17/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


//### jwm ### 20130319_1645 changed <>tcsiteID to [Invoice]siteID
//### jwm ### 20130319_1655 changed <>tcsiteID to [Order]siteID
//### jwm ### 20130319_1656 changed <>tcsiteID to [PO]siteID

C_REAL:C285($dOnOrd; $discntPrice)
C_LONGINT:C283($i; $k; $relatedInc; $relatedRec; $doAction; $dtCreate; $viUniqueID)
KeyModifierCurrent
CONFIRM:C162("Create d_Inventory Records?")
If (OK=1)
	If (CmdKey=1)
		READ WRITE:C146([DInventory:36])
		QUERY:C277([DInventory:36]; [DInventory:36]typeID:14="i@"; *)
		QUERY:C277([DInventory:36];  | [DInventory:36]typeID:14="S@"; *)
		QUERY:C277([DInventory:36];  | [DInventory:36]typeID:14="P@")
		DELETE SELECTION:C66([DInventory:36])
	End if 
	IVNT_dRayInit
	vlReceiptID:=-1
	If (OptKey=0)
		ALERT:C41("Search for desired Invoices.")
		QUERY:C277([Invoice:26])
	Else 
		ALL RECORDS:C47([Invoice:26])
	End if 
	FIRST RECORD:C50([Invoice:26])
	$k:=Records in selection:C76([Invoice:26])
	For ($i; 1; $k)
		If (($i%100)=1)
			MESSAGE:C88("Processing record "+String:C10($i))
		End if 
		QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]idNumInvoice:1=[Invoice:26]idNum:2)
		FIRST RECORD:C50([InvoiceLine:54])
		$relatedRec:=Records in selection:C76([InvoiceLine:54])
		For ($relatedInc; 1; $relatedRec)
			$discntPrice:=DiscountApply([InvoiceLine:54]unitPrice:9; [InvoiceLine:54]discount:10; <>tcDecimalUP)
			If ([Invoice:26]idNumOrder:1=1)
				$doAction:=4
				$dOnOrd:=[InvoiceLine:54]qty:7
			Else 
				$doAction:=3
				$dOnOrd:=0
			End if 
			
			Invt_dRecCreate("IV"; [Invoice:26]idNum:2; [Invoice:26]idNumOrder:1; [Invoice:26]customerID:3; [Invoice:26]idNumProject:50; "+ Inv After"; $doAction; [InvoiceLine:54]idNum:47; [InvoiceLine:54]itemNum:4; -[InvoiceLine:54]qty:7; $dOnOrd; [InvoiceLine:54]unitCost:12; ""; vsiteID; $discntPrice)
			
			NEXT RECORD:C51([InvoiceLine:54])
		End for 
		
		$dtCreate:=DateTime_Enter([Invoice:26]dateDocument:35)
		dInventoryFillFromArray($dtCreate)
		// RRAY TO SELECTION(dItemNumKey;[dInventory]ItemNum;dQtyOnHand;[dInventory]QtyOnHand;dQtyOnSO;[dInventory]QtyOnSO;dQtyOnPO;[dInventory]QtyOnPO;dQtyOnWO;[dInventory]QtyOnWO;dQtyOnAdj;[dInventory]QtyOnAdj;dUnitCost;[dInventory]UnitCost;dJobID;[dInventory]projectNum;dDocID;[dInventory]DocID;dLineNum;[dInventory]UniqueIDLine;dReceiptID;[dInventory]ReceiptID;dSource;[dInventory]custVendID;dReason;[dInventory]Reason;dType;[dInventory]typeID;dDTCreated;[dInventory]DTCreated;dNote;[dInventory]Note;dTakeAction;[dInventory]TakeAction;dSite;[dInventory]siteID;dUnitPrice;[dInventory]UnitPrice;dChangeBy;[dInventory]ChangedBy)
		// PPLY TO SELECTION([dInventory];[dInventory]DTItemCard:=$dtCreate)
		NEXT RECORD:C51([Invoice:26])
	End for 
	//
	
	If (OptKey=0)
		ALERT:C41("Search for desired Orders.")
		QUERY:C277([Order:3])
	Else 
		ALL RECORDS:C47([Order:3])
	End if 
	FIRST RECORD:C50([Order:3])
	$k:=Records in selection:C76([Order:3])
	For ($i; 1; $k)
		If (($i%100)=1)
			MESSAGE:C88("Processing record "+String:C10($i))
		End if 
		QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
		$relatedRec:=Records in selection:C76([OrderLine:49])
		For ($relatedInc; 1; $relatedRec)
			$discntPrice:=DiscountApply([OrderLine:49]unitPrice:9; [OrderLine:49]discount:10; <>tcDecimalUP)
			Invt_dRecCreate("SO"; [Order:3]idNum:2; 0; [Order:3]customerID:1; [Order:3]projectNum:50; "+Ord After"; 1; [OrderLine:49]idNum:50; [OrderLine:49]itemNum:4; 0; [OrderLine:49]qty:6; [OrderLine:49]unitCost:12; ""; vsiteID; $discntPrice)
			NEXT RECORD:C51([OrderLine:49])
		End for 
		
		$dtCreate:=DateTime_Enter([Order:3]dateDocument:4)
		dInventoryFillFromArray($dtCreate)
		
		NEXT RECORD:C51([Order:3])
	End for 
	//
	IVNT_dRayInit
	If (OptKey=0)
		ALERT:C41("Search for desired POs.")
		QUERY:C277([PO:39])
	Else 
		ALL RECORDS:C47([PO:39])
	End if 
	FIRST RECORD:C50([PO:39])
	$k:=Records in selection:C76([PO:39])
	For ($i; 1; $k)
		If (($i%100)=1)
			MESSAGE:C88("Processing record "+String:C10($i))
		End if 
		QUERY:C277([PO:39]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
		$relatedRec:=Records in selection:C76([POLine:40])
		For ($relatedInc; 1; $relatedRec)
			If ([POLine:40]qtyReceived:4#0)
				$discntPrice:=DiscountApply([POLine:40]unitCost:7; [POLine:40]discount:8; <>tcDecimalUC)
				
				If (vlReceiptID=-1)
					vlReceiptID:=PORcpt_CreateNew([PO:39]idNum:5; [PO:39]vendorID:1)
				End if 
				
				Invt_dRecCreate("PO"; [PO:39]idNum:5; vlReceiptID; [PO:39]vendorID:1; [PO:39]idNumProject:6; "+PO After"; 4; [POLine:40]lineNum:14; [POLine:40]itemNum:2; [POLine:40]qtyReceived:4; 0; $discntPrice; ""; vsiteID; 0)
				
			End if 
			NEXT RECORD:C51([POLine:40])
		End for 
		$dtCreate:=DateTime_Enter([PO:39]dateOrdered:2)
		dInventoryFillFromArray($dtCreate)
		
		NEXT RECORD:C51([PO:39])
	End for 
End if 
READ ONLY:C145([DInventory:36])

REDRAW WINDOW:C456
REDUCE SELECTION:C351([Order:3]; 0)
REDUCE SELECTION:C351([OrderLine:49]; 0)
REDUCE SELECTION:C351([Invoice:26]; 0)
REDUCE SELECTION:C351([InvoiceLine:54]; 0)
REDUCE SELECTION:C351([PO:39]; 0)
REDUCE SELECTION:C351([POLine:40]; 0)