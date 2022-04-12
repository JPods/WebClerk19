If (Records in selection:C76([QQQCustomer:2])=2)
	C_LONGINT:C283($firstRec; $secondRec)
	CREATE SET:C116([QQQCustomer:2]; "current")
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
		CONFIRM:C162("Combine first into second.")
		If (OK=1)
			// move 
			Dup_CustDetail(-1; $firstRec; $secondRec)  // into second
		End if 
	End if 
	USE SET:C118("current")
	CLEAR SET:C117("current")
End if 