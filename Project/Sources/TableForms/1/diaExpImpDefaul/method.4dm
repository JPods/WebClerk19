Case of 
	: (Before:C29)
		vi1:=Character code:C91("\t")
		If (Length:C16("\r")>1)
			vi2:=-1
		Else 
			vi2:=Character code:C91("\r")
		End if 
		Case of 
			: (vDocType="TEXT")
				b20:=1
				b21:=0
				b22:=0
				b23:=0
			: (vDocType="DIF")
				b20:=0
				b21:=1
				b22:=0
				b23:=0
			: (vDocType="SYLK")
				b20:=0
				b21:=0
				b22:=1
				b23:=0
			: (vDocType="")
				b20:=0
				b21:=0
				b22:=0
				b23:=1
		End case 
	: (Outside call:C328)
		Prs_OutsideCall
	Else 
		Case of 
			: (b20=1)
				b21:=0
				b22:=0
				b23:=0
				vDocType:="TEXT"
			: (b21=1)
				b20:=0
				b22:=0
				b23:=0
				vDocType:="DIF"
			: (b22=1)
				b21:=0
				b20:=0
				b23:=0
				vDocType:="SYLK"
			: (b23=1)
				b21:=0
				b20:=0
				b22:=0
				vDocType:=""
		End case 
		
End case 
