CONFIRM:C162("Force Folder and Data to match.")
If (OK=1)
	$curPass:=allowAlerts_boo
	allowAlerts_boo:=False:C215
	C_LONGINT:C283($err)
	TRACE:C157
	$err:=DocArray2Records(1)
	If ($err=1)
		DocLoadFromFolder(1)
		If ($err=1)
			DocSave2Folder
			If ($err=1)
				allowAlerts_boo:=True:C214
				jAlertMessage(17004)
			End if 
		End if 
	End if 
	allowAlerts_boo:=$curPass
End if 