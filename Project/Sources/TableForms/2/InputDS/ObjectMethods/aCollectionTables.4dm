
Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(aSalesTables; 0)
		APPEND TO ARRAY:C911(aSalesTables; "Invoice")
		APPEND TO ARRAY:C911(aSalesTables; "Payment")
		APPEND TO ARRAY:C911(aSalesTables; "Ledger")
		APPEND TO ARRAY:C911(aSalesTables; "dCash")
		APPEND TO ARRAY:C911(aSalesTables; "Reference")
		If (Storage:C1525.user.salesTable=Null:C1517)
			aSalesTables:=2
			Form_SetSubForm("SF_Sales"; "Order"; "IncludedDS")
			
			OBJECT SET SUBFORM:C1138(*; "SF_Sales"; [Order:3]; "IncludedDS")
		Else 
			var $numTable : Integer
			aSalesTables:=Find in array:C230(aSalesTables; Storage:C1525.user.salesTable)
			If (aSalesTables<1)
				aSalesTables:=2
			End if 
		End if 
		$numTable:=ds:C1482[aSalesTables{aSalesTables}].getInfo().tableNumber
		OBJECT SET SUBFORM:C1138(*; "SF_Sales"; Table:C252($numTable)->; "IncludedDS")
		
	: (aSalesTables=0)
		aSalesTables:=3
		
	: (aSalesTables{aSalesTables}="Proposal")
		OBJECT SET SUBFORM:C1138(*; "SF_Sales"; [Proposal:42]; "IncludedDS")
	: (aSalesTables{aSalesTables}="ProposalLine")
		OBJECT SET SUBFORM:C1138(*; "SF_Sales"; [ProposalLine:43]; "IncludedDS")
	: (aSalesTables{aSalesTables}="Order")
		OBJECT SET SUBFORM:C1138(*; "SF_Sales"; [Order:3]; "IncludedDS")
	: (aSalesTables{aSalesTables}="OrderLine")
		OBJECT SET SUBFORM:C1138(*; "SF_Sales"; [OrderLine:49]; "IncludedDS")
	: (aSalesTables{aSalesTables}="Invoice")
		OBJECT SET SUBFORM:C1138(*; "SF_Sales"; [Invoice:26]; "IncludedDS")
	: (aSalesTables{aSalesTables}="InvoiceLine")
		OBJECT SET SUBFORM:C1138(*; "SF_Sales"; [InvoiceLine:54]; "IncludedDS")
	: (aSalesTables{aSalesTables}="Payment")
		OBJECT SET SUBFORM:C1138(*; "SF_Sales"; [Payment:28]; "IncludedDS")
	: (aSalesTables{aSalesTables}="Contact")
		OBJECT SET SUBFORM:C1138(*; "SF_Sales"; [Contact:13]; "IncludedDS")
	: (aSalesTables{aSalesTables}="Ledger")
		OBJECT SET SUBFORM:C1138(*; "SF_Sales"; [Ledger:30]; "IncludedDS")
	: (aSalesTables{aSalesTables}="CallReport")
		OBJECT SET SUBFORM:C1138(*; "SF_Sales"; [CallReport:34]; "IncludedDS")
End case 
var $o : Object
$o:=New object:C1471("tableName"; aSalesTables{aSalesTables}; "tableParent"; "Customer"; "id"; entryEntity.id)
EXECUTE METHOD IN SUBFORM:C1085("SF_Sales"; "SF_Sales_Execute"; *; $o)


