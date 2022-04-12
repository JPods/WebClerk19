
CONFIRM:C162("Set Machine to "+Current machine:C483; " Set "; " Cancel ")

If (OK=1)
	[WebClerk:78]Machine:35:=Current machine:C483
End if 
