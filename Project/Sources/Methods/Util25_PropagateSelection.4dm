//%attributes = {}



// 4D_25Invoice - 2022-01-15
//This method will be simpler when we will get Aliases

C_OBJECT:C1216($1)
C_TEXT:C284($2; $3)

$selection2Use:=$1
$sourceTableName:=$2
$targetDataClassName:=$3
Case of 
	: ($sourceTableName="Products")
		Case of 
			: ($targetDataClassName="Invoices")
				$targetSelection:=$selection2Use.Products_to_Invoice_Lines.Invoice_Lines_to_Invoices
				
			: ($targetDataClassName="Clients")
				$targetSelection:=$selection2Use.Products_to_Invoice_Lines.Invoice_Lines_to_Invoices.Invoices_to_Clients
				//The magic of ORDA!!
				
		End case 
		
	: ($sourceTableName="Invoices")
		Case of 
			: ($targetDataClassName="Products")
				$targetSelection:=$selection2Use.Invoices_to_Invoice_Lines.Invoice_Lines_to_Products
				
			: ($targetDataClassName="Clients")
				$targetSelection:=$selection2Use.Invoices_to_Clients
				
		End case 
		
	: ($sourceTableName="Clients")
		Case of 
			: ($targetDataClassName="Invoices")
				$targetSelection:=$selection2Use.Clients_to_Invoices
				
			: ($targetDataClassName="Products")
				$targetSelection:=$selection2Use.Clients_to_Invoices.Invoices_to_Invoice_Lines.Invoice_Lines_to_Products
				
		End case 
End case 

$0:=$targetSelection