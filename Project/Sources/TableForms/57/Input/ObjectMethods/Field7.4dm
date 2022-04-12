C_TEXT:C284($enteredData)
If (Length:C16([QQQRemoteUser:57]userName:2)<6)
	ALERT:C41("The UserName must be at least 6 characters long.")
	[QQQRemoteUser:57]userName:2:=[QQQRemoteUser:57]userName:2+("Z"*(Length:C16([QQQRemoteUser:57]userName:2)-6))
Else 
	$enteredData:=[QQQRemoteUser:57]userName:2
	PUSH RECORD:C176([QQQRemoteUser:57])
	QUERY:C277([QQQRemoteUser:57]; [QQQRemoteUser:57]userName:2=$enteredData)
	$doCurrentEntry:=False:C215
	If (Records in selection:C76([QQQRemoteUser:57])=0)
		$doCurrentEntry:=True:C214
	End if 
	POP RECORD:C177([QQQRemoteUser:57])
	If ($doCurrentEntry=False:C215)
		[QQQRemoteUser:57]userName:2:=[QQQRemoteUser:57]userName:2+"_ZZZZ"
		ALERT:C41($enteredData+" was not unique")
	End if 
End if 