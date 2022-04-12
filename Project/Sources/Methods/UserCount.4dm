//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 09:11:04
// ----------------------------------------------------
// Method: UserCount
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("AdminControl"))
	
	READ WRITE:C146([DefaultAccount:32])
	GOTO RECORD:C242([DefaultAccount:32]; 0)
	If (Locked:C147([DefaultAccount:32]))
		ALERT:C41("Key records and files currently busy")
	Else 
		jCenterWindow(192; 78; 1)
		DIALOG:C40([Control:1]; "UserCount")
		CLOSE WINDOW:C154
		vDiaCom:=""
	End if 
	REDUCE SELECTION:C351([DefaultAccount:32]; 0)
	READ ONLY:C145([DefaultAccount:32])
End if 