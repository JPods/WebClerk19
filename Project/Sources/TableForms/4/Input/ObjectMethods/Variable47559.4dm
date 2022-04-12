CONFIRM:C162("Create ItemNum from MfgItemNum?")
If (OK=1)
	ItemNumChange([Item:4]mfrItemNum:39+"-"+[Item:4]mfrid:53)
End if 