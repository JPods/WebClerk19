If (False:C215)
	TCMod_606_67_03_04_Trans
End if 
C_POINTER:C301($ptTable; $ptField)
C_TEXT:C284($strValue)
If ([MfrCustomerXRef:110]customerID:2#"")
	C_LONGINT:C283($theType)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[MfrCustomerXRef:110]customerID:2)
	If (Records in selection:C76([Customer:2])=0)
		ALERT:C41("No matching records")
	Else 
		DB_ShowCurrentSelection(->[Customer:2]; ""; 1; "Manufacturer")  //tablePt, script, flowBranch, Title
	End if 
End if 