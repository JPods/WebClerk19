If (Records in selection:C76([Customer:2])>0)
	DB_ShowCurrentSelection(->[Customer:2]; ""; 1; "")
	Srl_SaveChanges
	myOK:=0
	CANCEL:C270
Else 
	BEEP:C151
End if 