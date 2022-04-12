If ([Invoice:26]dateLinked:31=!00-00-00!)
	vMod:=calcInvoice(True:C214)
Else 
	[Invoice:26]amountForceValue:90:=Old:C35([Invoice:26]amountForceValue:90)
	jAlertMessage(10007)
End if 