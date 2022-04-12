Case of 
	: (Before:C29)
		b1:=1
		b2:=0
		b3:=0
		b4:=0
		If (v4="Not Used")
			OBJECT SET ENABLED:C1123(b4; False:C215)
		End if 
	: (Outside call:C328)
		Prs_OutsideCall
	Else 
		Case of 
			: (b1=1)
				b2:=0
				b3:=0
				b4:=0
			: (b2=1)
				b1:=0
				b3:=0
				b4:=0
			: (b3=1)
				b1:=0
				b2:=0
				b4:=0
			: (b4=1)
				b1:=0
				b2:=0
				b3:=0
		End case 
End case 