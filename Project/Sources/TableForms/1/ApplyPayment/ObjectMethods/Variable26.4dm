If (aInvoices>0)
	pPayment:=[Invoice:26]balanceDue:44
	pTotal:=pPayment
	pDiff:=0
Else 
	pPayment:=[Payment:28]AmountAvailable:19
	pDiff:=Round:C94(pTotal-pPayment; <>tcDecimalTt)
End if 