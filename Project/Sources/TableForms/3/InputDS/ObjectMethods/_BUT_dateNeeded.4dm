// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/11/11, 13:41:43
// ----------------------------------------------------
// Method: Object Method: bNeedDate
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283(bFixbyDays)
C_DATE:C307(vDate1)
If (False:C215)  // Modified by: williamjames (10/8/09)
	//zzzFixThis  Crashes
	//???
	Open window:C153(50; 50; 380; 170; 1)  //$4 is the Window title
	DIALOG:C40([Order:3]; "diaNeedDate2")
	CLOSE WINDOW:C154
	If (OK=1)
		[Order:3]dateShipOn:31:=vdDateBeg
		[Order:3]dateNeeded:5:=vdDateEnd
		If ((<>tcbManyType) & ([Customer:2]customerID:1#""))
			DscntSetPrice([Order:3]typeSale:22; [Order:3]dateOrdered:4)
		Else 
			DscntSpecialClr([Order:3]typeSale:22)
		End if 
	End if 
	CLEAR VARIABLE:C89(vdDateBeg)
	CLEAR VARIABLE:C89(vdDateBeg)
	CLEAR VARIABLE:C89(vi4)
	CLEAR VARIABLE:C89(v1)
	CLEAR VARIABLE:C89(v2)
	CLEAR VARIABLE:C89(v3)
End if 