// ### bj ### 20191005_1801 TESTTHIS
If (doSearch>0)
	If ((doSearch=1) | (doSearch=100))
		vR7:=Round:C94(vR1*vRLo1; viExDisPrec)
	End if 
	If ((doSearch=2) | (doSearch=100))
		vR8:=Round:C94(vR2*vRLo1; viExDisPrec)
	End if 
	If ((doSearch=3) | (doSearch=100))
		vR9:=Round:C94(vR3*vRLo1; viExDisPrec)
	End if 
	If ((doSearch=4) | (doSearch=100))
		vR10:=Round:C94(vR4*vRLo1; viExDisPrec)
	End if 
	If ((doSearch=5) | (doSearch=100))
		vR11:=Round:C94(vR5*vRLo1; viExDisPrec)
	End if 
	If ((doSearch=6) | (doSearch=100))
		vR12:=Round:C94(vR6*vRLo1; viExDisPrec)
	End if 
	If ((doSearch=7) | (doSearch=200))
		vR1:=Round:C94(vR7/vRLo1; viExConPrec)
	End if 
	If ((doSearch=8) | (doSearch=200))
		vR2:=Round:C94(vR8/vRLo1; viExConPrec)
	End if 
	If ((doSearch=9) | (doSearch=200))
		vR3:=Round:C94(vR9/vRLo1; viExConPrec)
	End if 
	If ((doSearch=10) | (doSearch=200))
		vR4:=Round:C94(vR10/vRLo1; viExConPrec)
	End if 
	If ((doSearch=11) | (doSearch=200))
		vR5:=Round:C94(vR11/vRLo1; viExConPrec)
	End if 
	If ((doSearch=12) | (doSearch=200))
		vR6:=Round:C94(vR12/vRLo1; viExConPrec)
	End if 
	doSearch:=0
End if 
