C_BOOLEAN:C305($doChange)
If (Is new record:C668([Customer:2]))
	$doChange:=True:C214
Else 
	$doChange:=UserInPassWordGroup("ChangesalesNameID")
End if 
If ($doChange)
	entryEntity.salesNameID:=DE_PopUpArray(Self:C308)
	// zzzqqq U_DTStampFldMod(->[Customer:2]comment:15; ->[Customer:2]salesNameID:59)
Else 
	BEEP:C151
	BEEP:C151
	jAlertMessage(-9991)
End if 