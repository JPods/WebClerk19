KeyModifierCurrent
If ((OptKey=1) & (cmdKey=1))
	If (ShftKey=1)
		CONFIRM:C162("Insert bad card"; "Authorize.net"; "Paypal")
		If (OK=1)
			pCreditCard:="4222222222222"
			//pCVV:=""
		Else 
			pCreditCard:="4111111111111112"
			//pCVV:=""
		End if 
	Else 
		CONFIRM:C162("Insert good card"; "Authorize.net"; "Paypal")
		If (OK=1)
			pCreditCard:="4007000000027"
		Else 
			pCreditCard:="4111111111111111"
		End if 
		//pCVV:=""
	End if 
	C_TEXT:C284($monOf; $yrOf)
	$monOf:=String:C10(Month of:C24(Current date:C33); "00")
	$yrOf:=String:C10(Year of:C25(Current date:C33)+1; "0000")
	$yrOf:=Substring:C12($yrOf; 3)
	pCCDateStr:=$monOf+$yrOf
Else 
	<>viPayBatch:=CounterNew(->[Term:37])
End if 