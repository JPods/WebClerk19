//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method:Method: PKShredInvoice
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
If (Size of array:C274(aInvoiceRecSel)>0)
	If (aInvoiceRecSel{1}<=Size of array:C274(aInvoices))
		QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=aInvoices{aInvoiceRecSel{1}})
		If (Locked:C147([Invoice:26]))
			ALERT:C41("Invoice is locked.  Cannot be deleted")
		Else 
			If (Records in selection:C76([Invoice:26])=1)
				//   voidCurInvoice 
				//IVNT_dRayInit 
				TRACE:C157
				QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
				$o:=Records in selection:C76([InvoiceLine:54])
				FIRST RECORD:C50([InvoiceLine:54])
				For ($j; 1; $o)
					If ((<>vbDoSrlNums) & ([InvoiceLine:54]serialRc:26>0))
						Srl_SalvageSale([InvoiceLine:54]serialRc:26; ->[Invoice:26]invoiceNum:2)  //salvage deleted lines        
					End if 
					$dOnHand:=[InvoiceLine:54]qty:7
					If ($dOnHand#0)
						Invt_dRecCreate("IV"; [Invoice:26]invoiceNum:2; 0; [Invoice:26]customerID:3; [Invoice:26]projectNum:50; "void Invoice"; 1; [InvoiceLine:54]idNum:47; [InvoiceLine:54]itemNum:4; [InvoiceLine:54]qty:7; $dOnOrd; [InvoiceLine:54]unitCost:12; ""; vsiteID; 0)
					End if 
					[InvoiceLine:54]qty:7:=0
					[InvoiceLine:54]comment:40:=[InvoiceLine:54]comment:40+"\r"+[InvoiceLine:54]itemNum:4+"\t"+String:C10([InvoiceLine:54]qtyRemain:6)+"\t"+String:C10([InvoiceLine:54]qty:7)+"\t"+String:C10([InvoiceLine:54]extendedPrice:11)
					NEXT RECORD:C51([InvoiceLine:54])
				End for 
				SAVE RECORD:C53([Invoice:26])
				IvcLnFillRays  //vLineCnt set if no order
				vMod:=calcInvoice(True:C214)
				SAVE RECORD:C53([Invoice:26])
				INVT_dInvtApply
				TallyInventory
				//
				QUERY:C277([LoadTag:88]; [LoadTag:88]invoiceNum:19=[Invoice:26]invoiceNum:2)
				C_LONGINT:C283($i; $k; $cntLoadItems; $incLoadItems)
				$k:=Records in selection:C76([LoadTag:88])
				FIRST RECORD:C50([LoadTag:88])
				For ($i; 1; $k)
					[LoadTag:88]invoiceNum:19:=0
					[LoadTag:88]status:6:="Pending"
					QUERY:C277([LoadItem:87]; [LoadItem:87]loadTagid:8=[LoadTag:88]idNum:1)
					$cntLoadItems:=Records in selection:C76([LoadItem:87])
					For ($incLoadItems; 1; $cntLoadItems)
						[LoadItem:87]invoiceNum:14:=0
						SAVE RECORD:C53([LoadItem:87])
						NEXT RECORD:C51([LoadItem:87])
					End for 
					SAVE RECORD:C53([LoadTag:88])
					NEXT RECORD:C51([LoadTag:88])
				End for 
				PkOrderLoad(srSO; eOrdList)
			End if 
		End if 
	End if 
End if 

