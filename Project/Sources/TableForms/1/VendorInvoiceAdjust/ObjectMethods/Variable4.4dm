C_BOOLEAN:C305($skipMod)
$skipMod:=True:C214
If (vMod)
	CONFIRM:C162("Ignor unsaved changes.")
	$skipMod:=(OK=1)
End if 
If ($skipMod)
	jCancelButton
End if 