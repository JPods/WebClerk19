KeyModifierCurrent
If (OptKey=1)
	CONFIRM:C162("Build Remote User")
	If (OK=1)
		If ([Contact:13]idNum:28=0)
			
			SAVE RECORD:C53([Contact:13])
		End if 
		RemoteUser_Create(->[Contact:13]; String:C10([Contact:13]idNum:28); [Contact:13]zip:11+(Num:C11([Contact:13]zip:11="")*"admin"); 1)  //+String(Random%20+10)
	End if 
End if 
QUERY:C277([RemoteUser:57]; [RemoteUser:57]tableNum:9=Table:C252(->[Contact:13]); *)
QUERY:C277([RemoteUser:57];  & [RemoteUser:57]contactID:11=[Contact:13]idNum:28)
[Contact:13]remoteUser:41:=(Records in selection:C76([RemoteUser:57])>0)
If ([Contact:13]remoteUser:41)
	DB_ShowCurrentSelection(->[RemoteUser:57]; ""; 1; "")
Else 
	BEEP:C151
	BEEP:C151
End if 