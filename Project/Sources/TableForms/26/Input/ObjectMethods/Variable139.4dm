entryEntity.taxJuris:=DE_PopUpArray(Self:C308)
If ([Invoice:26]jrnlComplete:48)
	[Invoice:26]taxJuris:33:=Old:C35([Invoice:26]taxJuris:33)
	BEEP:C151
	BEEP:C151
Else 
	
	vMod:=True:C214
	calcInvoice
	vMod:=True:C214
End if 