// zzzqqq jCapitalize1st(Self:C308)
If ([Service:6]Attention:30="")
	[Service:6]Attention:30:=Self:C308->
Else 
	CONFIRM:C162("Replace Service Attention with this entery.")
	If (OK=1)
		[Service:6]Attention:30:=Self:C308->
	End if 
End if 