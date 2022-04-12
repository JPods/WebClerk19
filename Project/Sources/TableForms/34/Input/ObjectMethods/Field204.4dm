// zzzqqq Cust_IndividFil
//
//
//
If (False:C215)
	vi2:=Records in selection:C76([QQQCustomer:2])
	FIRST RECORD:C50([QQQCustomer:2])
	For (vi1; 1; vi2)
		If ([QQQCustomer:2]company:2="")
			[QQQCustomer:2]individual:72:=True:C214
			// zzzqqq Cust_IndividFil
			SAVE RECORD:C53([QQQCustomer:2])
		End if 
		NEXT RECORD:C51([QQQCustomer:2])
	End for 
	
	vi2:=Records in selection:C76([QQQCustomer:2])
	FIRST RECORD:C50([QQQCustomer:2])
	For (vi1; 1; vi2)
		[QQQCustomer:2]profile5:30:=[QQQCustomer:2]need:21
		SAVE RECORD:C53([QQQCustomer:2])
		NEXT RECORD:C51([QQQCustomer:2])
	End for 
End if 