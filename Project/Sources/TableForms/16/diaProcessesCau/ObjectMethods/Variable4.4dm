Case of 
	: ((aCauses>0) | ((aAttributes>0) & (<>aProcesses>0)))
		b1:=0
		b2:=0
		b3:=1
		If (aCauses>0)
			v1s50:=aCauses{aCauses}
		End if 
	: (aAttributes>0)
		b1:=0
		b2:=1
		b3:=0
	Else 
		b1:=1
		b2:=0
		b3:=0
End case 