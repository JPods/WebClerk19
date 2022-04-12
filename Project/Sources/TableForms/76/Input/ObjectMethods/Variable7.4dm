C_TEXT:C284($theText)
$theText:=Get_FileName("Find Filename Program"; "")
If ($theText#"")
	[EDISetID:76]TextIOFileName:6:=$theText
End if 