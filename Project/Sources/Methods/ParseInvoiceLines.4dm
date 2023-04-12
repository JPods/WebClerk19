//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/17/11, 14:46:06
// ----------------------------------------------------
// Method: ParseInvoiceLines
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($w; $i; $invoiceLineUniqueID; $lineDelete; $viInvoiceNum; $0)
C_BOOLEAN:C305($lockedInvoiceLines; $lockedInvoices; $lockedOrders; $lockedCustomers)
C_LONGINT:C283($dAction)
$viInvoiceNum:=[InvoiceLine:54]idNumInvoice:1
$0:=[InvoiceLine:54]idNumInvoice:1
If ([Invoice:26]idNum:2#[InvoiceLine:54]idNumInvoice:1)
	QUERY:C277([Invoice:26]; [Invoice:26]idNum:2=[InvoiceLine:54]idNumInvoice:1)
End if 
If ([Customer:2]customerID:1#[InvoiceLine:54]customerID:2)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[InvoiceLine:54]customerID:2)
End if 
If ([Invoice:26]idNumOrder:1>9)
	QUERY:C277([Order:3]; [Order:3]idNum:2=[Invoice:26]idNumOrder:1)
Else 
	REDUCE SELECTION:C351([Order:3]; 0)
End if 
$lockedInvoiceLines:=Locked:C147([InvoiceLine:54])
$lockedInvoices:=((Locked:C147([Invoice:26])) | ([Invoice:26]jrnlComplete:48=True:C214))
$lockedOrders:=Locked:C147([Order:3])
$lockedCustomers:=Locked:C147([Customer:2])
If (($lockedInvoiceLines) | ($lockedInvoices) | ($lockedOrders) | ($lockedCustomers))
	vResponse:="Locked Records, Customers: "+String:C10(Num:C11($lockedCustomers))+"; Orders: "+String:C10(Num:C11($lockedOrders))+"; Invoices: "+String:C10(Num:C11($lockedInvoices))+"; InvoiceLines: "+String:C10(Num:C11($lockedInvoiceLines))
	$0:=-11
Else 
	
	If ([Invoice:26]idNum:2#[InvoiceLine:54]idNumInvoice:1)
		QUERY:C277([Invoice:26]; [Invoice:26]idNum:2=[InvoiceLine:54]idNumInvoice:1)
	End if 
	If ([InvoiceLine:54]typeSale:27#(Old:C35([InvoiceLine:54]typeSale:27)))
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[InvoiceLine:54]itemNum:4)
		DscntSetPrice([InvoiceLine:54]typeSale:27; [Invoice:26]dateShipped:4)
		OrdSetPrice(->[InvoiceLine:54]unitPrice:9; ->[InvoiceLine:54]discount:10; [InvoiceLine:54]qty:7; ->pComm)
		vComRep:=CM_FindRate(->[Invoice:26]repID:22; -><>aReps; -><>aRepRate)
		vComSales:=CM_FindRate(->[Invoice:26]salesNameID:23; -><>aComNameID; -><>aEmpRate)
		[InvoiceLine:54]commRateSales:23:=vComSales*pComm*0.01
		[InvoiceLine:54]commRateRep:18:=vComRep*pComm*0.01
		//OrdSetPrice (->pUnitPrice;->pDiscnt;aOQtyOrder{$i};->pComm)
	End if 
	
	//dInventory before processing the order
	//  ??????  Check this critical
	
	$thisRecord:=Record number:C243([InvoiceLine:54])
	$invoiceLineUniqueID:=[InvoiceLine:54]idNum:47
	If ([InvoiceLine:54]description:5="delete")  //Num(([InvoiceLine]Status="delete") | 
		GOTO RECORD:C242([InvoiceLine:54]; $thisRecord)  // reload the record to ignor any edits
		invoicelinedelete
	Else 
		
		InvoiceLinesorderlinesChange
		$dOnOrd:=0
		$dOnHand:=[InvoiceLine:54]qty:7-Old:C35([InvoiceLine:54]qty:7)
		[InvoiceLine:54]discountedPrice:59:=DiscountApply([InvoiceLine:54]unitPrice:9; [InvoiceLine:54]discount:10; <>tcDecimalUP)
		$dAction:=1
		Case of 
			: (Is new record:C668([InvoiceLine:54]))
				$dAction:=4
			Else 
				$dAction:=3
		End case 
		
		If ($dOnHand#0)
			Invt_dRecCreate("IV"; [Invoice:26]idNum:2; [Invoice:26]idNumOrder:1; [Invoice:26]customerID:3; [Invoice:26]idNumProject:50; "ivc+ship"; $dAction; [InvoiceLine:54]idNum:47; [InvoiceLine:54]itemNum:4; $dOnHand; $dOnOrd; [InvoiceLine:54]unitCost:12; ""; vsiteID; [InvoiceLine:54]discountedPrice:59)
		End if 
		//  zzzzzzz
		
		SAVE RECORD:C53([InvoiceLine:54])
		
		Execute_TallyMaster("InvoiceLinesAfterParse"; "WebScript")
		
	End if 
End if 