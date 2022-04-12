//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 04/12/13, 15:52:20
// ----------------------------------------------------
// Method: voidCurOrder
// Description
// File: voidCurOrder.txt
// Parameters
// ----------------------------------------------------
//### jwm ### 20130412_1550 QtyOnHand should never change due to an Order changed [Orderline]QtyShipped to 0 zero

//VoidCurOrder
C_LONGINT:C283($allUnLocked)
If (vHere>1)
	CONFIRM:C162("Do you seriously want to void Order "+String:C10([Order:3]orderNum:2)+".")
Else 
	OK:=1
End if 
If (OK=1)
	jLOADunLocked(->[Order:3]; "This order is locked by another user."; ->unlocked)
	If (unLocked=0)
		ALERT:C41("Order "+String:C10([Order:3]orderNum:2; "0000-0000")+" is locked, no action.")
	Else 
		QUERY:C277([Invoice:26]; [Invoice:26]orderNum:1=[Order:3]orderNum:2)
		$allUnLocked:=1
		FIRST RECORD:C50([Invoice:26])
		$k:=Records in selection:C76([Invoice:26])
		$i:=0
		While ($i<$k)
			$i:=$i+1
			jLOADunLocked(->[Invoice:26]; "This order is locked by another user."; ->unlocked)
			If (unLocked=0)
				ALERT:C41("Invoice "+String:C10([Invoice:26]invoiceNum:2)+" is locked.  Process STOPPED for Order "+String:C10([Invoice:26]orderNum:1)+".")
				$allUnLocked:=0
				$i:=$k
			End if 
			NEXT RECORD:C51([Invoice:26])
		End while 
		If ($allunLocked=1)
			If (($k=0) | (vHere<2))
				OK:=1
			Else 
				CONFIRM:C162("This will also void "+String:C10(Records in selection:C76([Invoice:26]))+" Invoices.")
			End if 
			If (OK=1)
				If ([Customer:2]customerID:1#[Order:3]customerID:1)
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
				End if 
				[Customer:2]balanceOpenOrders:78:=[Customer:2]balanceOpenOrders:78-[Order:3]amountBackLog:54
				SAVE RECORD:C53([Customer:2])
				PKDeleteLoadTags(->[Order:3])
				IVNT_dRayInit
				[Order:3]weightEstimate:49:=0  //False means this has been counted
				//
				[Order:3]dateInvoiceComp:6:=Current date:C33
				[Order:3]complete:83:=2
				[Order:3]status:59:="Completed"
				//
				[Order:3]datePrinted:7:=Current date:C33
				[Order:3]repID:8:="Nul"
				[Order:3]repCommission:9:=0
				[Order:3]salesCommission:11:=0
				[Order:3]shipVia:13:="Manual"
				[Order:3]typeSale:22:="VOID"
				[Order:3]terms:23:="VOID"
				[Order:3]total:27:=0
				[Order:3]amount:24:=0
				[Order:3]shipMiscCosts:25:=0
				[Order:3]shipAdjustments:26:=0
				[Order:3]salesTax:28:=0
				[Order:3]shipTotal:30:=0
				[Order:3]shipFreightCost:38:=0
				[Order:3]totalCost:42:=0
				[Order:3]repCommission:9:=0
				[Order:3]salesCommission:11:=0
				[Order:3]adSource:41:=""
				[Order:3]amountCancel:60:=0
				[Order:3]amountBackLog:54:=0
				[Order:3]balanceDueEstimated:107:=0
				[Order:3]commentProcess:12:=[Order:3]commentProcess:12+"\r"+"\r"+"*///////////  VOID  //////////////*"+"\r"
				READ WRITE:C146([OrderLine:49])
				QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
				FIRST RECORD:C50([OrderLine:49])
				$o:=Records in selection:C76([OrderLine:49])
				[Order:3]commentProcess:12:=[Order:3]commentProcess:12+"\r"+"Deleted Lines:"+String:C10(Current date:C33)+" -- "+String:C10(Current time:C178)+" -- "+Current user:C182+"\r"+"\r"
				For ($i; 1; $o)
					[Order:3]commentProcess:12:=[Order:3]commentProcess:12+"\r"+[OrderLine:49]itemNum:4+"\t"+String:C10([OrderLine:49]qty:6)+"\t"+String:C10([OrderLine:49]qtyShipped:7)+"\t"+String:C10([OrderLine:49]extendedPrice:11)+"\t"+String:C10([OrderLine:49]extendedCost:13)
					$dOnHand:=[OrderLine:49]qtyShipped:7
					$dOnOrd:=-[OrderLine:49]qty:6+[OrderLine:49]qtyShipped:7
					If (($dOnHand#0) | ($dOnOrd#0))
						Invt_dRecCreate("SO"; [Order:3]orderNum:2; 0; [Order:3]customerID:1; [Order:3]projectNum:50; "Void SO Line"; 1; [OrderLine:49]idNum:50; [OrderLine:49]itemNum:4; 0; -[OrderLine:49]qtyBackLogged:8; [OrderLine:49]unitCost:12; ""; vsiteID; 0)
					End if 
					NEXT RECORD:C51([OrderLine:49])
				End for 
				DELETE SELECTION:C66([OrderLine:49])
				READ ONLY:C145([OrderLine:49])
				SAVE RECORD:C53([Order:3])
				
				INVT_dInvtApply
				
				//
				FIRST RECORD:C50([Invoice:26])
				For ($i; 1; Records in selection:C76([Invoice:26]))
					VoidInvPay
					READ WRITE:C146([InvoiceLine:54])
					[Invoice:26]commentProcess:73:=[Invoice:26]commentProcess:73+"\r"+"//////  Deleted Lines  "+String:C10(Current date:C33)+" -- "+String:C10(Current time:C178)+" -- "+Current user:C182+"\r"+"\r"
					QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
					$o:=Records in selection:C76([InvoiceLine:54])
					FIRST RECORD:C50([InvoiceLine:54])
					For ($j; 1; $o)
						If ((<>vbDoSrlNums) & ([InvoiceLine:54]serialRc:26>0))
							Srl_SalvageSale([InvoiceLine:54]serialRc:26)  //salvage deleted lines        
						End if 
						[Invoice:26]commentProcess:73:=[Invoice:26]commentProcess:73+"\r"+[InvoiceLine:54]itemNum:4+"\t"+String:C10([InvoiceLine:54]qty:7)+"\t"+String:C10([InvoiceLine:54]extendedPrice:11)+"\t"+String:C10([InvoiceLine:54]extendedCost:13)
						NEXT RECORD:C51([InvoiceLine:54])
					End for 
					DELETE SELECTION:C66([InvoiceLine:54])
					READ ONLY:C145([InvoiceLine:54])
					SAVE RECORD:C53([Invoice:26])
					Ledger_InvSave
					NEXT RECORD:C51([Invoice:26])
				End for 
			End if 
		End if 
	End if 
End if 