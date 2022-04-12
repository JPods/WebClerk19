
CONFIRM:C162("Set User to "+Current user:C182; " Set "; " Cancel ")

If (OK=1)
	[WebClerk:78]User:34:=Current user:C182
End if 
