//TRACE
KeyModifierCurrent
If (OptKey=1)
	ALERT:C41("vHere = "+String:C10(vHere)+"; ptCurTable = "+Table name:C256(ptCurTable))
	vHere:=0
	ptCurTable:=->[QQQCustomer:2]
Else 
	vHere:=0
	ptCurTable:=->[QQQCustomer:2]
	
End if 

