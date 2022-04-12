//%attributes = {"publishedWeb":true}
//Procedure: URpt_CheckAuthL
//Noah Dykoski  July 14, 1998 / 12:22 AM
READ ONLY:C145([Employee:19])
C_BOOLEAN:C305($0)
$0:=False:C215
If ([UserReport:46]securityLevel:24#0)
	C_LONGINT:C283($AuthLevel)
	QUERY:C277([Employee:19]; [Employee:19]nameID:1=Current user:C182)
	If (Records in selection:C76([Employee:19])=1)
		If ([Employee:19]securityLevel:23>=[UserReport:46]securityLevel:24)
			$0:=True:C214
		Else 
			If (allowAlerts_boo)
				ALERT:C41("You are not authorized to print this User Report.")
			End if 
		End if 
	Else 
		If (allowAlerts_boo)
			ALERT:C41("You are not authorized to print this User Report. (No User/Current User)")
		End if 
	End if 
Else 
	$0:=True:C214
End if 
READ WRITE:C146([Employee:19])