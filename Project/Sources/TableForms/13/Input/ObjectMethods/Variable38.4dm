C_LONGINT:C283(bGoto Co)
If (vHere>2)
	jAcceptButton
Else 
	[Contact:13]obSync:17:=[Contact:13]obSync:17
	CANCEL:C270
	ProcessTableOpen(->[Customer:2])
	booDuringDo:=False:C215
End if 