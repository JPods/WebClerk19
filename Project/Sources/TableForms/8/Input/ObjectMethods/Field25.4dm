QUERY:C277([RemoteUser:57]; [RemoteUser:57]tableNum:9=Table:C252(->[Rep:8]); *)
QUERY:C277([RemoteUser:57];  & [RemoteUser:57]customerID:10=[Rep:8]repID:1)
If (Records in selection:C76([RemoteUser:57])=0)
	RemoteUser_Create(->[Rep:8]; [Rep:8]repID:1; [Rep:8]zip:8; 5)
End if 
QUERY:C277([RemoteUser:57]; [RemoteUser:57]tableNum:9=Table:C252(->[Rep:8]); *)
QUERY:C277([RemoteUser:57];  & [RemoteUser:57]customerID:10=[Rep:8]repID:1)
[Rep:8]remoteUser:29:=(Records in selection:C76([RemoteUser:57])>0)
If ([Rep:8]remoteUser:29)
	DB_ShowCurrentSelection(->[RemoteUser:57]; ""; 1; "")
Else 
	BEEP:C151
	BEEP:C151
End if 