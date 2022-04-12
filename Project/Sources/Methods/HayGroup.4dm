//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-07-07T00:00:00, 14:19:36
// ----------------------------------------------------
// Method: HayGroup
// Description
// Modified: 07/07/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

myDoc:=Create document:C266(""; "Name Catalog Master")
If (OK=1)
	vi2:=Records in selection:C76([InvoiceLine:54])
	
	SEND PACKET:C103(myDoc; "InvoiceNum"+"\t"+"Company"+"\t"+"customerID"+"\t"+"ItemNum"+"\t"+"Description"+"\t"+"QtyShipped"+"\t"+"ExtendedPrice"+"\t"+"DateInvoiced"+"\t"+"Attention"+"\t"+"email"+"\t"+"phone"+"\t"+"Address1"+"\t"+"Address2"+"\t"+"City"+"\t"+"State"+"\t"+"Zip"+"\t"+"Original"+"\t"+"New/Exist"+"\t"+"Campaign"+"\t"+"OrgType"+"\t"+"CustPONum"+"\r")
	
	For (vi1; 1; vi2)
		If ([InvoiceLine:54]invoiceNum:1#[Invoice:26]invoiceNum:2)
			QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=[InvoiceLine:54]invoiceNum:1)
		End if 
		SEND PACKET:C103(myDoc; String:C10([Invoice:26]invoiceNum:2)+"\t"+[Invoice:26]company:7+"\t"+[Invoice:26]customerID:3+"\t"+[InvoiceLine:54]itemNum:4+"\t"+[InvoiceLine:54]description:5+"\t"+String:C10([InvoiceLine:54]qty:7)+"\t"+String:C10([InvoiceLine:54]extendedPrice:11)+"\t"+String:C10([Invoice:26]dateInvoiced:35)+"\t"+[Invoice:26]attention:38+"\t"+[Invoice:26]email:76+"\t"+[Invoice:26]phone:54+"\t"+[Invoice:26]address1:8+"\t"+[Invoice:26]address2:9+"\t"+[Invoice:26]city:10+"\t"+[Invoice:26]state:11+"\t"+[Invoice:26]zip:12+"\t"+[Invoice:26]adSource:52+"\t"+[Invoice:26]consignment:63+"\t"+[Invoice:26]repID:22+"\t"+[Invoice:26]typeSale:49+"\t"+[Invoice:26]customerPO:29+"\r")
		NEXT RECORD:C51([InvoiceLine:54])
	End for 
	UNLOAD RECORD:C212([InvoiceLine:54])
	UNLOAD RECORD:C212([Invoice:26])
	CLOSE DOCUMENT:C267(myDoc)
End if 