C_BOOLEAN:C305($doChange)
$doChange:=UserInPassWordGroup("Inventory")
If ($doChange)
	Process_AddRecord("ItemWarehouse")
Else 
	jAlertMessage(-9991)
End if 