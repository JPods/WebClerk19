KeyModifierCurrent
QUERY:C277([RemoteUser:57]; [RemoteUser:57]tableNum:9=Table:C252(->[Employee:19]); *)
QUERY:C277([RemoteUser:57];  & [RemoteUser:57]customerID:10=[Employee:19]nameID:1)
If (Records in selection:C76([RemoteUser:57])=0)
	RemoteUser_Create(->[Employee:19]; [Employee:19]nameID:1; [Employee:19]zip:21+(Num:C11([Employee:19]zip:21="")*"admin"); 1)
End if 
DB_ShowCurrentSelection(->[RemoteUser:57]; ""; 1; "")