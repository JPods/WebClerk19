C_LONGINT:C283($i; $ii; $k; $j)
If (v6="")
	ALERT:C41("Enter an Item P/N before searching.")
Else 
	MESSAGES OFF:C175
	QUERY:C277([Order:3]; [Order:3]dateInvoiceComp:6=!00-00-00!; *)
	QUERY:C277([Order:3];  | [Order:3]dateInvoiceComp:6=!1901-01-01!)
	$k:=Records in selection:C76([Order:3])
	If ($k>0)
		CREATE EMPTY SET:C140([Order:3]; "BackOrders")
		FIRST RECORD:C50([Order:3])
		For ($i; 1; $k)
			
			QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2; *)
			QUERY:C277([OrderLine:49];  & [OrderLine:49]itemNum:4=v6; *)
			QUERY:C277([OrderLine:49];  & [OrderLine:49]qtyBackLogged:8>0)
			If (Records in selection:C76([OrderLine:49])>0)
				ADD TO SET:C119([Order:3]; "BackOrders")
			End if 
			NEXT RECORD:C51([Order:3])
		End for 
		REDUCE SELECTION:C351([OrderLine:49]; 0)
		If (Records in set:C195("BackOrders")=0)
			ALERT:C41("There are no back-orders for Item P/N "+v6+".")
		Else 
			USE SET:C118("BackOrders")
			doSearch:=1
		End if 
		CLEAR SET:C117("BackOrders")
	Else 
		ALERT:C41("There are no back-orders.")
	End if 
	MESSAGES ON:C181
End if 