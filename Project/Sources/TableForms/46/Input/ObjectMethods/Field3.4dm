
$doChange:=(UserInPassWordGroup("EditReportScript"))
If (Not:C34($doChange))
	ALERT:C41("You don't have Password Access. You can't change Authority Levels.")
	[UserReport:46]authorityLevel:24:=Old:C35([UserReport:46]authorityLevel:24)
End if 
