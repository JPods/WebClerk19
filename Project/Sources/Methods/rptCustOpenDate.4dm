//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/20/19, 17:09:44
// ----------------------------------------------------
// Method: rptCustOpenDate
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301(ptCurTable)
C_LONGINT:C283(vHere)
If (Is nil pointer:C315(ptCurTable))
	ptCurTable:=(->[Customer:2])
End if 

If ((ptCurTable#(->[Customer:2])) & (vHere>0))
	jsplashCancel
End if 
vdDateBeg:=Current date:C33
vdDateEnd:=Current date:C33
jBetweenDates("Find Customers who started accounts between the report dates.")
If (OK=1)
	QUERY:C277([Customer:2]; [Customer:2]dateOpened:14>=vdDateBeg; *)
	QUERY:C277([Customer:2];  & [Customer:2]dateOpened:14<=vdDateEnd)
	ORDER BY:C49([Customer:2]; [Customer:2]dateOpened:14; >)
	ProcessTableOpen(->[Customer:2])
End if 