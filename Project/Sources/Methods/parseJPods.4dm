//%attributes = {}
vText:=Get text from pasteboard:C524
If (Length:C16(vText)>0)
	vText:=Replace string:C233(vText; "\""; "")
End if 
SET TEXT TO PASTEBOARD:C523(vText)