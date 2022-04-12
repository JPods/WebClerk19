C_LONGINT:C283(bLead)
If (False:C215)
	KeyModifierCurrent
	If (OptKey=1)
		VendorFromCustomer
		If (Records in selection:C76([Vendor:38])=1)
			DB_ShowCurrentSelection(->[Vendor:38]; ""; 1; "")
		End if 
	Else 
		rptLead(100)
	End if 
End if 