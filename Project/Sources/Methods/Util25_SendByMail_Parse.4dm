//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_OBJECT:C1216($client;$invoice)
C_TEXT:C284($1)

$text2parse:=$1
$invoice:=$2
$client:=$3
$settings:=$4

$textResult:=$text2parse

$tagList:=New collection:C1472("<<InvoiceInvoice_Number>>";"<<ClientContact>>";"<<ClientName>>";"<<ClientCity>>";"<<ClientState>>";\
"<<ClientZIP>>";"<<ClientCountry>>";"<<ClientPhone>>";"<<ClientMobile>>";\
"<<InvoiceInvoice_Number>>";"<<InvoiceCreation_Date>>";"<<InvoiceTotal>>";"<<CompanyName>>")

For each ($tag;$tagList)
	If (Position:C15($tag;$textResult)>0)
		$replace:=""
		Case of 
			: ($tag="<<InvoiceInvoice_Number>>")
				$replace:=$invoice.Invoice_Number
				
			: ($tag="<<ClientContact>>")
				$replace:=$client.Contact
				
			: ($tag="<<ClientName>>")
				$replace:=$client.Name
				
			: ($tag="<<ClientCity>>")
				$replace:=$client.City
				
			: ($tag="<<ClientState>>")
				$replace:=$client.State
				
			: ($tag="<<ClientZIP>>")
				$replace:=$client.Zip_Code
				
			: ($tag="<<ClientCountry>>")
				$replace:=$client.Country
				
			: ($tag="<<ClientPhone>>")
				$replace:=$client.Numbers.Phone
				
			: ($tag="<<ClientMobile>>")
				$replace:=$client.Numbers.Mobile
				
			: ($tag="<<InvoiceCreation_Date>>")
				$replace:=String:C10($invoice.Creation_Date;Internal date short:K1:7)
				
			: ($tag="<<InvoiceTotal>>")
				$replace:=String:C10($invoice.Total;"### ### ##0.00")
				
			: ($tag="<<CompanyName>>")
				$replace:=$settings.Company.Name
				
				  //Here you can add as many tags as necessary
				
		End case 
		If ($replace#"")
			$textResult:=Replace string:C233($textResult;$tag;$replace)
		End if 
	End if 
End for each 

$0:=$textResult

