
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/01/18, 05:34:44
// ----------------------------------------------------
// Method: [Default].Input.Field97
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($vlLength)
$vlLength:=Length:C16([Default:15]shareServer:170)

[Default:15]shareServer:170:=Txt_TrimSpaces([Default:15]shareServer:170)
[Default:15]shareServer:170:=Txt_TrimSpaces([Default:15]shareServer:170; ";")
[Default:15]shareServer:170:=Txt_TrimSpaces([Default:15]shareServer:170; "\\")
[Default:15]shareServer:170:=Txt_TrimSpaces([Default:15]shareServer:170; "/")
[Default:15]shareServer:170:=Txt_TrimSpaces([Default:15]shareServer:170; ":")
If ($vlLength#Length:C16([Default:15]shareServer:170))
	ALERT:C41("[Default]ShareServer cannot begin or end with ; \\ / :")
End if 

PathSetServer