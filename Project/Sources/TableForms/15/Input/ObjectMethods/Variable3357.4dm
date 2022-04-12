CONFIRM:C162("Change the Nav Pallet Image")
If (OK=1)
	TRACE:C157
	SET PICTURE TO LIBRARY:C566(<>pNavPalletChange; 2127; "PalletNavigation")
	// 2127
	// 22111
	If (OK=1)
		ALERT:C41("Image Set")
		<>pNavPallet:=<>pNavPalletChange
	Else 
		ALERT:C41("Error is saving resource")
	End if 
End if 
