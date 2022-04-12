C_LONGINT:C283($days)
$days:=Num:C11(Request:C163("Set days to cert expire."; "90"))
If (OK=1)
	[WebClerk:78]DateCertExpire:48:=Current date:C33+$days
End if 