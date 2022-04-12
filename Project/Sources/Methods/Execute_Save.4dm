//%attributes = {"publishedWeb":true}
C_LONGINT:C283($err)
CONFIRM:C162("Is there a valid 4D procedure on the Clipboard?")
If (OK=1)
	//$err:=FRSave 
	If ($err#0)
		BEEP:C151
		BEEP:C151
		ALERT:C41("There was no text in the Clipboard.")
	End if 
End if 