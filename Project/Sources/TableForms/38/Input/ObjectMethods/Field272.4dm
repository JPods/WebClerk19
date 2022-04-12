KeyModifierCurrent
QUERY:C277([RemoteUser:57]; [RemoteUser:57]tableNum:9=Table:C252(->[Vendor:38]); *)
QUERY:C277([RemoteUser:57];  & [RemoteUser:57]customerID:10=[Vendor:38]vendorID:1)
If (Records in selection:C76([RemoteUser:57])=0)
	RemoteUser_Create(->[Vendor:38]; [Vendor:38]vendorID:1; [Vendor:38]zip:8+(Num:C11([Vendor:38]zip:8="")*"admin"); 1)
End if 
//
DB_ShowCurrentSelection(->[RemoteUser:57]; ""; 1; "")