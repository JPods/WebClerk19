//%attributes = {"publishedWeb":true}
C_TEXT:C284($1)
//Procedure: jBetweenDates
vdDateEnd:=Current date:C33
vdDateBeg:=Current date:C33
If (Count parameters:C259>0)
	vDiaCom:=($1)
	If (Count parameters:C259>1)
		vdDateBeg:=$2
		If (Count parameters:C259>2)
			vdDateEnd:=$3
		End if 
	End if 
End if 
jCenterWindow(310; 150; 1)  //(258;146;1)
DIALOG:C40([Control:1]; "BetweenDates")
CLOSE WINDOW:C154
vDiaCom:=""