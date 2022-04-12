If (aPayInvs>0)
	pPayment:=[Payment:28]AmountAvailable:19
	pDiff:=Round:C94(pTotal-pPayment; <>tcDecimalTt)
Else 
	pPayment:=pTotal
	pDiff:=0
End if 