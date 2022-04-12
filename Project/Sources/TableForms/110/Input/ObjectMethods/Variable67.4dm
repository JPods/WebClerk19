// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/07/10, 00:27:25
// ----------------------------------------------------
// Method: Object Method: b2
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($strValue)
If ([MfrCustomerXRef:110]mfrID:3#"")
	C_LONGINT:C283($theType)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[MfrCustomerXRef:110]mfrID:3)
	If (Records in selection:C76([Customer:2])=0)
		ALERT:C41("No matching records")
	Else 
		DB_ShowCurrentSelection(->[Customer:2]; ""; 1; "")
		READ WRITE:C146([Customer:2])
	End if 
End if 