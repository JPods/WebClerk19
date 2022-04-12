C_LONGINT:C283(bFixbyDays)
C_DATE:C307(vDate1)
If (False:C215)
	// ### bj ### 20181119_2051
	// implement if needed
	Open window:C153(50; 50; 380; 170; 1)  //$4 is the Window title
	DIALOG:C40([Order:3]; "diaNeedDate2")
	CLOSE WINDOW:C154
	If (OK=1)
		[Proposal:42]dateNeeded:4:=vdDateEnd
		If ((<>tcbManyType) & ([Customer:2]customerID:1#""))
			DscntSetPrice([Proposal:42]typeSale:20; [Proposal:42]dateNeeded:4)
		Else 
			DscntSpecialClr([Proposal:42]typeSale:20)
		End if 
	End if 
	CLEAR VARIABLE:C89(vdDateBeg)
	CLEAR VARIABLE:C89(vdDateBeg)
	CLEAR VARIABLE:C89(vi4)
	CLEAR VARIABLE:C89(v1)
	CLEAR VARIABLE:C89(v2)
	CLEAR VARIABLE:C89(v3)
End if 