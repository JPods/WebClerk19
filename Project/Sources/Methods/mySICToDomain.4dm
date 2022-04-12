//%attributes = {"publishedWeb":true}
CONFIRM:C162("This procedure copies the SICCode field into Domain in Customers and Leads. OK?")
If (OK=1)
	CONFIRM:C162("Are you sure you want to  copy the SICCode field into Domain?")
	If (OK=1)
		ALL RECORDS:C47([QQQCustomer:2])
		FIRST RECORD:C50([QQQCustomer:2])
		For ($index; 1; Records in selection:C76([QQQCustomer:2]))
			[QQQCustomer:2]domain:90:=[QQQCustomer:2]sicCode:16
			SAVE RECORD:C53([QQQCustomer:2])
			NEXT RECORD:C51([QQQCustomer:2])
		End for 
		
		ALL RECORDS:C47([Lead:48])
		FIRST RECORD:C50([Lead:48])
		For ($index; 1; Records in selection:C76([Lead:48]))
			[Lead:48]Domain:46:=[Lead:48]SICCode:38
			SAVE RECORD:C53([Lead:48])
			NEXT RECORD:C51([Lead:48])
		End for 
	End if 
End if 