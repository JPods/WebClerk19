//%attributes = {}
//This method handles calculations specific to some DataClasses, like related DataClasses 
//For instance, modifications on INVOICE_LINES implies an update of INVOICES
//
$isNew:=$1  //True for a new Record

Case of   //Special cases depending on the Table
	: (Form:C1466.dataClassName="Invoices")
		If (Not:C34(Form:C1466.editEntity.Invoices_to_Invoice_Lines=Null:C1517))
			Form:C1466.editEntity.Total:=Form:C1466.editEntity.Invoices_to_Invoice_Lines.sum("Total")
			Form:C1466.editEntity.Tax:=Form:C1466.editEntity.Invoices_to_Invoice_Lines.sum("Total_Tax")
			OBJECT Get pointer:C1124(Object named:K67:5; "_TOTAL_Quantity")->:=Form:C1466.editEntity.Invoices_to_Invoice_Lines.sum("Quantity")
			OBJECT Get pointer:C1124(Object named:K67:5; "_TOTAL_TEXT_Quantity")->:=Get localized string:C991("Total")
			OBJECT Get pointer:C1124(Object named:K67:5; "_TOTAL_Total")->:=Form:C1466.editEntity.Total
			OBJECT Get pointer:C1124(Object named:K67:5; "_TOTAL_TEXT_Total")->:=Get localized string:C991("Total")
			
		End if 
		If ($isNew)
			
		End if 
		
	: (Form:C1466.dataClassName="Clients")
		Form:C1466.queryClient:=""
		If ($isNew)
			Form:C1466.editEntity.Country:=Form:C1466.settings.Clients.defaultCountry
			Form:C1466.editEntity.Discount_Rate:=Form:C1466.settings.Clients.defaultDiscount
		Else 
			Form:C1466.editEntity.Total_Sales:=Form:C1466.editEntity.Clients_to_Invoices.sum("Total")
		End if 
		
	: (Form:C1466.dataClassName="Products")
		If ($isNew)
			Form:C1466.editEntity.Tax_Rate:=Form:C1466.settings.Products.defaultTaxRate
		End if 
		
	: (Form:C1466.dataClassName="Invoice_Lines")
		If ($isNew)
			Form:C1466.editEntity.Discount_Rate:=Form:C1466.editEntity.Invoice_Lines_to_Invoices.Invoices_to_Clients.Discount_Rate
		End if 
		
End case 







