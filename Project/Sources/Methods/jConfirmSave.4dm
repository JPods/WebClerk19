//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($0; $1; $2)
$0:=$1
If (($2) & (<>booConfirm) & (Modified record:C314(ptCurTable->)))
	If ($1)
		vDiaCom:="Do you want to Save Changes."
	Else 
		vDiaCom:="Do you want to Cancel Changes."
	End if 
	jCenterWindow(244; 76; 1)
	DIALOG:C40([Control:1]; "diaConfirmCance")
	CLOSE WINDOW:C154
	vDiaCom:=""
	If (OK=1)
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
End if 