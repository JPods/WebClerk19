C_TEXT:C284($theText)
$theText:=Get_FileName("Find Content Program"; "")
If ($theText#"")
	[EDISetID:76]TextIOContent:7:=$theText
End if 