//%attributes = {"publishedWeb":true}
//test for user privelege
$doChange:=UserInPassWordGroup("OnlyTally")
If (Not:C34($doChange))
	ALERT:C41("Error: Authority \"OnlyTally\" Required")
	CANCEL:C270
Else   //valid user
	jCenterWindow(190; 95; 1)
	DIALOG:C40([Control:1]; "TallyChooseMonth")
	CLOSE WINDOW:C154
End if 