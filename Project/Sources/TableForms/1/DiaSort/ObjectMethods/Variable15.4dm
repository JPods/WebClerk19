If (False:C215)
	C_LONGINT:C283($theHere)
	doQuickQuote:=1
	If (vHere=0)
		$theHere:=0
		vHere:=2
	Else 
		$theHere:=vHere
	End if 
	File_dSelection
	vHere:=$theHere
	doQuickQuote:=0
End if 
QueryEditorModal