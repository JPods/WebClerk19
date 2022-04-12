//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/08/12, 11:53:55
// ----------------------------------------------------
// Method: WindowComment
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $2; $diaComment; $displayText)
C_LONGINT:C283($3; $timeout)
$timeout:=0
If (Count parameters:C259>0)
	vDiaCom:=$1
	If (Count parameters:C259>1)
		vEntryText:=$2
		If (Count parameters:C259>2)
			$timeout:=$3
		End if 
	End if 
End if 
//jCenterWindow (650;420;1)
$winRef:=Open form window:C675([Control:1]; "TextConfirm"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40([Control:1]; "TextConfirm")
CLOSE WINDOW:C154
vDiaCom:=""