C_LONGINT:C283(bPWCreate; bPWChange)
TRACE:C157
C_LONGINT:C283(bPWCreate; bPWChange)
If ([Employee:19]active:12)
	PassWordCreate(2)  //create if employee does not exist
	jpwCreate
Else 
	ALERT:C41("Employee must be active.")
End if 