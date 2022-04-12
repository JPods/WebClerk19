If (Records in selection:C76([QQQCustomer:2])=2)
	CREATE SET:C116([QQQCustomer:2]; "current")
	C_LONGINT:C283($firstRec; $secondRec)
	$firstRec:=-1
	$secondRec:=-1
	FIRST RECORD:C50([QQQCustomer:2])
	If (Not:C34(Locked:C147([QQQCustomer:2])))
		$firstRec:=Record number:C243([QQQCustomer:2])
	End if 
	NEXT RECORD:C51([QQQCustomer:2])
	If (Not:C34(Locked:C147([QQQCustomer:2])))
		$secondRec:=Record number:C243([QQQCustomer:2])
	End if 
	If (($secondRec=-1) | ($firstRec=-1))
		ALERT:C41("Record is locked")
	Else 
		CONFIRM:C162("Combine second into first.")
		If (OK=1)
			// move 
			
			Dup_CustDetail(-1; $secondRec; $firstRec)  // into first
			
		End if 
	End if 
	USE SET:C118("current")
	CLEAR SET:C117("current")
End if 