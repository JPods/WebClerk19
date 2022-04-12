CONFIRM:C162("Make a Customer Record.")
If (OK=1)
	TRACE:C157
	Vendor2Customer
	If (Records in selection:C76([Customer:2])=1)
		DB_ShowCurrentSelection(->[Customer:2]; ""; 1; "")
	End if 
End if 