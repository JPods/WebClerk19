//%attributes = {}
// ----------------------------------------------------
// User name (OS): Rolf Bachmann
// Date and time: 23.05.13, 23:35:21
// ----------------------------------------------------
// Method: tinyMCE_editContent
// Description: 

C_POINTER:C301($1)  //Pointer to your Content Variable

C_TEXT:C284(tinyMCE_Content_t)
C_LONGINT:C283($WndID_l)
If (Count parameters:C259>=1)
	tinyMCE_Content_t:=$1->
Else 
	tinyMCE_Content_t:="No content set"
End if 

If (False:C215)
	$WndID_l:=Open form window:C675("tinymce_dialog")
	DIALOG:C40("tinymce_dialog")
	If (OK=1)
		$1->:=tinyMCE_Content_t
	End if 
End if 