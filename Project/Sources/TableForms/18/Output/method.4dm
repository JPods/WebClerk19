
If ((Form event code:C388=On Load:K2:1) & (vHere<<>outLayoutTrigger))
	If (False:C215)
		TCNavigationChange005
	End if 
	jsetInHeader(->[QQQCause:18])
	OLO_HereAndMenu
End if 
oLoProcedure

