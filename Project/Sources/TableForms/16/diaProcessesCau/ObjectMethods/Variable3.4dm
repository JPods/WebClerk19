jRayAtts(0)
If ((aAttributes>0) | (<>aProcesses>0))
	b1:=0
	b2:=1
	b3:=0
	If (aAttributes>0)
		v1s50:=aAttributes{aAttributes}
	End if 
Else 
	b1:=1
	b2:=0
	b3:=0
End if 