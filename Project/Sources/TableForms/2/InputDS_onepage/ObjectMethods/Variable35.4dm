C_BOOLEAN:C305($doChange)
If (Is new record:C668([Customer:2]))
	$doChange:=True:C214
Else 
	$doChange:=UserInPassWordGroup("ChangesalesNameID")
End if 
//vi1:=2
//GET USER PROPERTIES(vi1;vText3;vText1;vText2;vi2;vDate1;aLongInt1)
If ($doChange)
	entry_o.salesNameID:=DE_PopUpArray(Self:C308)
	// zzzqqq U_DTStampFldMod(->[Customer:2]comment:15; ->[Customer:2]salesNameID:59)
Else 
	BEEP:C151
	BEEP:C151
	jAlertMessage(-9991)
End if 