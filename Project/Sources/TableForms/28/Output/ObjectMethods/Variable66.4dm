C_TEXT:C284($theBank; $theAcct)
C_DATE:C307($theDate)
C_LONGINT:C283($k; $i)
CONFIRM:C162("Set Bank and Statement date?")
If (OK=1)
	$theBank:=Request:C163("Enter Bank")
	$theAcct:=Request:C163("Enter Acct ID")
	If ((OK=1) & ($theBank#""))
		$theDate:=Date:C102(Request:C163("Enter date of statement."; String:C10(Current date:C33)))
		If ((OK=1) & ($theDate>!1990-01-01!))
			$k:=Records in selection:C76([Payment:28])
			FIRST RECORD:C50([Payment:28])
			For ($i; 1; $k)
				[Payment:28]BankDeposit:7:=$theBank
				[Payment:28]DateOfStatement:30:=$theDate
				[Payment:28]DepositAccount:29:=$theAcct
				SAVE RECORD:C53([Payment:28])
				NEXT RECORD:C51([Payment:28])
			End for 
		End if 
	End if 
End if 
