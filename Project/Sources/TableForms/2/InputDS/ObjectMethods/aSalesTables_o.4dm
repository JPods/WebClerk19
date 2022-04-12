
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
	: (aSalesTables>0)
		var $ptTable : Pointer
		$ptTable:=STR_GetTablePointer(aSalesTables{aSalesTables})
		OBJECT SET SUBFORM:C1138(*; "SF_Sales"; $ptTable->; "IncludedDS")
End case 
If (aSalesTables>0)
	//$tableName:=aSalesTables{aSalesTables}
	//LB_Included.ents:=ds
	process_o.tableNameIncluded:=aSalesTables{aSalesTables}
	// load the sf for related sales tables
	var $o : Object
	$o:=New object:C1471("tableName"; process_o.tableNameIncluded; "tableParent"; "Customer"; "id"; entryEntity.id)
	EXECUTE METHOD IN SUBFORM:C1085("SF_Sales"; "SF_Sales_Execute"; *; $o)
End if 



