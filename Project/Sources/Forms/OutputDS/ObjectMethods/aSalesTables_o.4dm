
// Modified by: Bill James (2022-04-01T05:00:00Z)
// Method: OutputDS.aSalesTables_o
// Description 
// Parameters
// ----------------------------------------------------

If (False:C215)
	Case of 
		: (Form event code:C388=On Load:K2:1)
			ARRAY TEXT:C222(aSalesTables; 0)
			APPEND TO ARRAY:C911(aSalesTables; process_o.tableName)
			APPEND TO ARRAY:C911(aSalesTables; "Item")
			APPEND TO ARRAY:C911(aSalesTables; "Contact")
			APPEND TO ARRAY:C911(aSalesTables; "QA")
			APPEND TO ARRAY:C911(aSalesTables; "Document")
			APPEND TO ARRAY:C911(aSalesTables; "Ledger")
			APPEND TO ARRAY:C911(aSalesTables; "CallReport")
			APPEND TO ARRAY:C911(aSalesTables; "ProposalLine")
			APPEND TO ARRAY:C911(aSalesTables; "OrderLine")
			APPEND TO ARRAY:C911(aSalesTables; "InvoiceLine")
			APPEND TO ARRAY:C911(aSalesTables; "Service")
			APPEND TO ARRAY:C911(aSalesTables; "Serial")
			aSalesTables:=1
			// bbb OBJECT SET SUBFORM(*; "SF_List"; "ListSelection")
			If (Storage:C1525.user.salesTable=Null:C1517)
				
				
			Else 
				var $numTable : Integer
				aSalesTables:=Find in array:C230(aSalesTables; Storage:C1525.user.salesTable)
				If (aSalesTables<1)
					aSalesTables:=1
				End if 
			End if 
			var $tableName : Text
			
			$numTable:=ds:C1482[process_o.tableName].getInfo().tableNumber
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
End if 

