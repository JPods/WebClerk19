doSearch:=16
C_TEXT:C284($tempStr)
If (Length:C16(v6)>10)
	//v6:=Substring(v6;1;10)
	BEEP:C151
End if 
vMod:=True:C214
$tempStr:="Site changed to "+v6+"."
// zzzqqq jDateTimeStamp(->vText; $tempStr)