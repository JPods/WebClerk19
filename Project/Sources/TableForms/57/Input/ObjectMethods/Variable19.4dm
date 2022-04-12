C_LONGINT:C283(viPasswordView)
[QQQRemoteUser:57]userPassword:3:=iLoText1
If (viPasswordView=1)
	iLoText1:=[QQQRemoteUser:57]userPassword:3
Else 
	iLoText1:="#"*Length:C16([QQQRemoteUser:57]userPassword:3)
End if 