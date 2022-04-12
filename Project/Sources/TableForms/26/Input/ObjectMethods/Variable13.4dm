C_BOOLEAN:C305($doTax)
If ([Invoice:26]jrnlComplete:48=False:C215)
	$doTax:=Contact_ShipTo(Self:C308; ->[Invoice:26])
	vMod:=True:C214
	calcInvoice
End if 