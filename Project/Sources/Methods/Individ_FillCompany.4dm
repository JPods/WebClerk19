//%attributes = {"publishedWeb":true}
//Method: Individ_FillCompany
KeyModifierCurrent
If (([QQQCustomer:2]individual:72) | (CmdKey=1))
	If (([QQQCustomer:2]company:2="") | (CmdKey=1))
		[QQQCustomer:2]company:2:=[QQQCustomer:2]nameLast:23+", "+[QQQCustomer:2]nameFirst:73
	Else 
		CONFIRM:C162("Set Company to Last, First Name.")
		If (OK=1)
			[QQQCustomer:2]company:2:=[QQQCustomer:2]nameLast:23+", "+[QQQCustomer:2]nameFirst:73
			srCustomer:=[QQQCustomer:2]company:2
		End if 
	End if 
End if 