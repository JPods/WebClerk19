
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/01/18, 05:38:15
// ----------------------------------------------------
// Method: [Default].Input.Field45
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($vlLength)

$vlLength:=Length:C16([Default:15]shareName:178)

// gngngn  chech to see if pre and post \\ are removed
[Default:15]shareName:178:=Txt_TrimSpaces([Default:15]shareName:178)
[Default:15]shareName:178:=Txt_TrimSpaces([Default:15]shareName:178; ";")
[Default:15]shareName:178:=Txt_TrimSpaces([Default:15]shareName:178; "\\")
[Default:15]shareName:178:=Txt_TrimSpaces([Default:15]shareName:178; "/")
[Default:15]shareName:178:=Txt_TrimSpaces([Default:15]shareName:178; ":")



If ($vlLength#Length:C16([Default:15]shareName:178))
	ALERT:C41("[Default]ShareName cannot begin or end with ; \\ / :")
End if 

PathSetServer