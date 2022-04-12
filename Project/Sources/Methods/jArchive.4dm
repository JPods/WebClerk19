//%attributes = {"publishedWeb":true}
If (UserInPassWordGroup("Apply2Selection"))
	vDiaCom:="Select the File and archive the current selection."
	jCenterWindow(196; 244; 1)
	DIALOG:C40([Control:1]; "diaArchive")
	CLOSE WINDOW:C154
	vDiaCom:=""
End if 