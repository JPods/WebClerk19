
Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(aSalesTables; 0)
		
		APPEND TO ARRAY:C911(aSalesTables; "Proposal")
		APPEND TO ARRAY:C911(aSalesTables; "Order")
		APPEND TO ARRAY:C911(aSalesTables; "Invoice")
		APPEND TO ARRAY:C911(aSalesTables; "Payment")
		APPEND TO ARRAY:C911(aSalesTables; "Contact")
		APPEND TO ARRAY:C911(aSalesTables; "QA")
		APPEND TO ARRAY:C911(aSalesTables; "Document")
		APPEND TO ARRAY:C911(aSalesTables; "Ledger")
		APPEND TO ARRAY:C911(aSalesTables; "CallReport")
		APPEND TO ARRAY:C911(aSalesTables; "ProposalLine")
		APPEND TO ARRAY:C911(aSalesTables; "OrderLine")
		APPEND TO ARRAY:C911(aSalesTables; "InvoiceLine")
		APPEND TO ARRAY:C911(aSalesTables; "ItemSerial")
		If (Storage:C1525.user.salesTable=Null:C1517)
			aSalesTables:=2
			OBJECT SET SUBFORM:C1138(*; "SF_Details"; [Order:3]; "IncludedDS")
		Else 
			var $numTable : Integer
			aSalesTables:=Find in array:C230(aSalesTables; Storage:C1525.user.salesTable)
			If (aSalesTables<1)
				aSalesTables:=2
			End if 
		End if 
		$numTable:=ds:C1482[aSalesTables{aSalesTables}].getInfo().tableNumber
		OBJECT SET SUBFORM:C1138(*; "SF_Details"; Table:C252($numTable)->; "IncludedDS")
		
	: (aSalesTables=0)
		aSalesTables:=3
		
	: (aSalesTables{aSalesTables}="Proposal")
		OBJECT SET SUBFORM:C1138(*; "SF_Details"; [Proposal:42]; "IncludedDS")
	: (aSalesTables{aSalesTables}="ProposalLine")
		OBJECT SET SUBFORM:C1138(*; "SF_Details"; [ProposalLine:43]; "IncludedDS")
	: (aSalesTables{aSalesTables}="Order")
		OBJECT SET SUBFORM:C1138(*; "SF_Details"; [Order:3]; "IncludedDS")
	: (aSalesTables{aSalesTables}="OrderLine")
		OBJECT SET SUBFORM:C1138(*; "SF_Details"; [OrderLine:49]; "IncludedDS")
	: (aSalesTables{aSalesTables}="Invoice")
		OBJECT SET SUBFORM:C1138(*; "SF_Details"; [Invoice:26]; "IncludedDS")
	: (aSalesTables{aSalesTables}="InvoiceLine")
		OBJECT SET SUBFORM:C1138(*; "SF_Details"; [InvoiceLine:54]; "IncludedDS")
	: (aSalesTables{aSalesTables}="Payment")
		OBJECT SET SUBFORM:C1138(*; "SF_Details"; [Payment:28]; "IncludedDS")
	: (aSalesTables{aSalesTables}="Contact")
		OBJECT SET SUBFORM:C1138(*; "SF_Details"; [Contact:13]; "IncludedDS")
	: (aSalesTables{aSalesTables}="Ledger")
		OBJECT SET SUBFORM:C1138(*; "SF_Details"; [Ledger:30]; "IncludedDS")
	: (aSalesTables{aSalesTables}="CallReport")
		OBJECT SET SUBFORM:C1138(*; "SF_Details"; [CallReport:34]; "IncludedDS")
End case 

// load the sf for related sales tables
var $o : Object
$o:=New object:C1471("tableName"; aSalesTables{aSalesTables}; "tableParent"; "Customer"; "id"; entryEntity.id)
EXECUTE METHOD IN SUBFORM:C1085("SF_Details"; "SF_Details_Execute"; *; $o)


