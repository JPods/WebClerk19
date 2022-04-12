//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-29T06:00:00Z)
// Method: GUI_TextEditDia
// Description 
// Parameters
// ----------------------------------------------------


C_TEXT:C284($2)
C_POINTER:C301($1)
vEntryText:=$1->
vDiaCom:=$2
jCenterWindow(500; 430; 5)
DIALOG:C40([Control:1]; "TextEntry_Dia")
CLOSE WINDOW:C154
vDiaCom:=""
If (OK=1)
	$1->:=vEntryText
End if 
vEntryText:=""