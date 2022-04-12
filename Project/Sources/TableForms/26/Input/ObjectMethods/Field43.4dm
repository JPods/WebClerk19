If ([Invoice:26]consignment:63#"")
	CONFIRM:C162("Are you sure you wish to consign this Invoice. It will not Journal.")
	If (OK=1)
		// zzzqqq PopUpWildCard(->[Invoice:26]consignment:63; -><>aConsign; ->[PopUp:23])
	End if 
End if 