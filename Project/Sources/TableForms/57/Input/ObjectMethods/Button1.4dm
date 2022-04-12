If ([QQQRemoteUser:57]key:21="")
	[QQQRemoteUser:57]key:21:=Txt_RandomString
Else 
	CONFIRM:C162("Reset Remote User Key?")
	If (OK=1)
		[QQQRemoteUser:57]key:21:=Txt_RandomString
	End if 
End if 