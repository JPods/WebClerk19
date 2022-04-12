If (Records in selection:C76([Vendor:38])>0)
	DB_ShowCurrentSelection(->[Vendor:38]; ""; 1; "")
	Srl_SaveChanges
	myOK:=0
	CANCEL:C270
End if 