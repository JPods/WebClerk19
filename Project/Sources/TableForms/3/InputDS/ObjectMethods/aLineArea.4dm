
// Modified by: Bill James (2022-04-02T05:00:00Z)
// Method: oLoButtonBar.aActions
// Description 
// Parameters
// ----------------------------------------------------
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (aLineArea>1)
			var $ptTable : Pointer
			Case of 
				: (process_o.dataClassName="Order")
					$ptTable:=(->[OrderLine:49])
				: (process_o.dataClassName="Invoice")
					$ptTable:=(->[InvoiceLine:54])
				: (process_o.dataClassName="Proposal")
					$ptTable:=(->[ProposalLine:43])
					//: (process_o.dataClassName="Requisition")
					//$ptTable:=(->[OrderLine])
			End case 
			OBJECT SET SUBFORM:C1138(*; "SF_Line"; $ptTable->; aLineArea{aLineArea})
		End if 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(aLineArea; 0)
		Case of 
			: (process_o.dataClassName="Order")
				APPEND TO ARRAY:C911(aLineArea; "Document")
				APPEND TO ARRAY:C911(aLineArea; "ItemSerial")
				APPEND TO ARRAY:C911(aLineArea; "Line")
				APPEND TO ARRAY:C911(aLineArea; "Margin")
				APPEND TO ARRAY:C911(aLineArea; "Payment")
				
			: (process_o.dataClassName="Invoice")
				APPEND TO ARRAY:C911(aLineArea; "Document")
				APPEND TO ARRAY:C911(aLineArea; "ItemSerial")
				APPEND TO ARRAY:C911(aLineArea; "Line")
				APPEND TO ARRAY:C911(aLineArea; "Margin")
				APPEND TO ARRAY:C911(aLineArea; "Payment")
				
			: (process_o.dataClassName="Proposal")
				APPEND TO ARRAY:C911(aLineArea; "Document")
				APPEND TO ARRAY:C911(aLineArea; "ItemSerial")
				APPEND TO ARRAY:C911(aLineArea; "Line")
				APPEND TO ARRAY:C911(aLineArea; "Margin")
				
				
			: (process_o.dataClassName="Requisition")
				APPEND TO ARRAY:C911(aLineArea; "Document")
				APPEND TO ARRAY:C911(aLineArea; "ItemSerial")
				APPEND TO ARRAY:C911(aLineArea; "Line")
				//APPEND TO ARRAY(aLineArea; "Margin")
				
		End case 
		If (aLineArea>0)
			SORT ARRAY:C229(aLineArea)
			INSERT IN ARRAY:C227(aLineArea; 1; 1)
			aLineArea{1}:="Layout"
		End if 
End case 