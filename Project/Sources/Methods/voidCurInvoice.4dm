//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/09/16, 09:54:14
// ----------------------------------------------------
// Method: voidCurInvoice
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160909_0954 journaled invoices can not be voided.

// ### jwm ### 20170821_2013 ADD FLAG TO FOLLOW UP WHEN CUSTOMER RECORD IS LOCKED QQQ

C_BOOLEAN:C305($OrdAvail; $myGO)
C_LONGINT:C283($o; $j)
TRACE:C157
// ### jwm ### 20160909_0954 journaled invoices can not be voided.
If (([Invoice:26]jrnlComplete:48=True:C214) | ([Invoice:26]dateLinked:31#!00-00-00!))
	ALERT:C41("ERROR: Invoice "+String:C10([Invoice:26]invoiceNum:2)+" was added to Sales Journals on "+String:C10([Invoice:26]dateLinked:31)+" and can not be Voided.")
Else 
	jLOADunLocked(->[Invoice:26]; "Record "+String:C10([Invoice:26]invoiceNum:2)+" is locked by another user."; ->unLocked)
	If (unLocked=0)
		ALERT:C41("Invoice "+String:C10([Invoice:26]invoiceNum:2; "0000-0000")+" is locked, no action.")
	Else 
		
		// Modified by: William James (2014-03-27T00:00:00 Subrecord eliminated)
		// in case of zero also
		
		If ([Invoice:26]orderNum:1>9)  // 
			QUERY:C277([Order:3]; [Order:3]orderNum:2=[Invoice:26]orderNum:1)
			If (Records in selection:C76([Order:3])=1)
				jLOADunLocked(->[Order:3]; "Record "+String:C10([Order:3]orderNum:2)+" is locked by another user."; ->unLocked)
				If (unLocked=0)
					$myGO:=False:C215
					ALERT:C41("Order "+String:C10([Order:3]orderNum:2; "0000-0000")+" is locked, no action.")
				Else 
					$myGO:=True:C214
				End if 
				$OrdAvail:=True:C214
			Else 
				$OrdAvail:=False:C215
			End if 
		Else 
			$myGO:=True:C214
		End if 
		
		If ($myGO)
			If ([Customer:2]customerID:1#[Invoice:26]customerID:3)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
			End if 
			If (False:C215)  // void even if customer is locked // ### jwm ### 20170602_1104
				If (Locked:C147([Customer:2]))
					ALERT:C41("Customer "+[Customer:2]company:2+" is locked, no action.")
					$myGo:=False:C215
				End if 
			End if 
		End if 
		If ($myGo)
			If (allowAlerts_boo)
				CONFIRM:C162("Do you seriously want to void Invoice "+String:C10([Invoice:26]invoiceNum:2)+".")
			Else 
				OK:=1
			End if 
			If (OK=1)
				PKDeleteLoadTags(->[Invoice:26])
				[Customer:2]salesYTD:47:=Round:C94([Customer:2]salesYTD:47-[Invoice:26]amount:14; <>tcDecimalTt)
				[Customer:2]salesMTD:46:=Round:C94([Customer:2]salesMTD:46-[Invoice:26]amount:14; <>tcDecimalTt)
				[Customer:2]costsYTD:75:=Round:C94([Customer:2]costsYTD:75-[Invoice:26]totalCost:37; <>tcDecimalTt)
				[Customer:2]costsMTD:76:=Round:C94([Customer:2]costsMTD:76-[Invoice:26]totalCost:37; <>tcDecimalTt)
				IVNT_dRayInit
				VoidInvPay
				[Invoice:26]commentProcess:73:=[Invoice:26]commentProcess:73+"\r"+"//////  VOID  "+String:C10(Current date:C33)+" -- "+String:C10(Current time:C178)+" -- "+Current user:C182+"\r"+"\r"
				QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
				$o:=Records in selection:C76([InvoiceLine:54])
				FIRST RECORD:C50([InvoiceLine:54])
				For ($j; 1; $o)
					If ((<>vbDoSrlNums) & ([InvoiceLine:54]serialRc:26>0))
						Srl_SalvageSale([InvoiceLine:54]serialRc:26; ->[Invoice:26]invoiceNum:2)  //salvage deleted lines        
					End if 
					[Invoice:26]commentProcess:73:=[Invoice:26]commentProcess:73+"\r"+[InvoiceLine:54]itemNum:4+"\t"+String:C10([InvoiceLine:54]qty:7)+"\t"+String:C10([InvoiceLine:54]extendedPrice:11)+"\t"+String:C10([InvoiceLine:54]extendedCost:13)
					
					$dOnHand:=[InvoiceLine:54]qty:7
					
					If ([Invoice:26]orderNum:1>9)  //for POS changes on hand
						$dOnOrd:=$dOnHand*Num:C11([InvoiceLine:54]qty:7>0)
						QUERY:C277([OrderLine:49]; [OrderLine:49]idNum:50=[InvoiceLine:54]orderLineNum:48)
						If (Records in selection:C76([OrderLine:49])=1)
							[OrderLine:49]qtyShipped:7:=[OrderLine:49]qtyShipped:7-[InvoiceLine:54]qty:7
							[OrderLine:49]qtyBackLogged:8:=[OrderLine:49]qty:6-[OrderLine:49]qtyShipped:7
							If ([OrderLine:49]qtyBackLogged:8#0)
								[OrderLine:49]complete:48:=False:C215
								[OrderLine:49]backOrdAmount:26:=Round:C94([OrderLine:49]qtyBackLogged:8*[OrderLine:49]unitPrice:9*(1-([OrderLine:49]discount:10*0.01)); <>tcDecimalTt)
							Else 
								[OrderLine:49]backOrdAmount:26:=0
							End if 
						Else 
							ALERT:C41("Item Number "+[InvoiceLine:54]itemNum:4+" is no longer listed in Order "+String:C10([Order:3]orderNum:2)+".")
						End if 
					End if 
					If ($dOnHand#0)
						Invt_dRecCreate("IV"; [Invoice:26]invoiceNum:2; 0; [Invoice:26]customerID:3; [Invoice:26]projectNum:50; "void Invoice"; 1; [InvoiceLine:54]idNum:47; [InvoiceLine:54]itemNum:4; [InvoiceLine:54]qty:7; $dOnOrd; [InvoiceLine:54]unitCost:12; ""; vsiteID; 0)  //<>tcsiteID
					End if 
					[InvoiceLine:54]comment:40:=[InvoiceLine:54]comment:40+"\r"+[InvoiceLine:54]itemNum:4+"\t"+String:C10([InvoiceLine:54]qtyRemain:6)+"\t"+String:C10([InvoiceLine:54]qty:7)+"\t"+String:C10([InvoiceLine:54]extendedPrice:11)
					NEXT RECORD:C51([InvoiceLine:54])
					If ([Invoice:26]orderNum:1>9)
						SAVE RECORD:C53([OrderLine:49])
						UNLOAD RECORD:C212([OrderLine:49])
					End if 
				End for 
				
				//  ?????  Create a sysnc Record  ACTIONBYBILL
				
				DELETE SELECTION:C66([InvoiceLine:54])
				
				INVT_dInvtApply
				
				If ($OrdAvail)
					
					[Order:3]amountBackLog:54:=Sum:C1([OrderLine:49]backOrdAmount:26)
					[Customer:2]balanceOpenOrders:78:=[Customer:2]balanceOpenOrders:78+[Order:3]amountBackLog:54
					//        VoidSetOrderDt  
					Accept_CalcStat(->[Order:3]; False:C215; ->[OrderLine:49]qtyShipped:7; ->[OrderLine:49]qtyBackLogged:8)
					SAVE RECORD:C53([Order:3])
				End if 
				
				SAVE RECORD:C53([Customer:2])
				READ WRITE:C146([InvoiceLine:54])
				QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
				DELETE SELECTION:C66([InvoiceLine:54])
				READ ONLY:C145([InvoiceLine:54])
				SAVE RECORD:C53([Invoice:26])
				Ledger_InvSave
			End if 
		End if 
	End if 
End if 
