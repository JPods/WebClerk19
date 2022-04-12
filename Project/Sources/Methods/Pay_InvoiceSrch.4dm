//%attributes = {"publishedWeb":true}
//Procedure: Pay_InvoiceSrch
Case of 
	: ([Invoice:26]orderNum:1<10)
		// QUERY([Payment];[Payment]InvoiceNum=[Invoice]InvoiceNum;*)
		// QUERY([Payment]; | [Payment]AmountAvailable#0;*)
		// QUERY([Payment]; & [Payment]customerID=[Invoice]customerID)
		
		QUERY:C277([Payment:28]; [Payment:28]invoiceNum:3=[Invoice:26]invoiceNum:2)
	Else 
		QUERY:C277([Payment:28]; [Payment:28]orderNum:2=[Invoice:26]orderNum:1; *)
		QUERY:C277([Payment:28];  | [Payment:28]invoiceNum:3=[Invoice:26]invoiceNum:2)
End case 