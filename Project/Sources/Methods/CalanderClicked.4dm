//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/22/19, 09:44:38
// ----------------------------------------------------
// Method: CalanderClicked
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($vContig; $vModifier)
C_LONGINT:C283($1)  //id of CalendarSet object
C_LONGINT:C283($2)  //Type of action

//  --  CHOPPED  CS_LastClick($1; clickDate; $vContig; $vModifier)
If (Shift down:C543)
	If (clickDate<vdDateEnd)
		vdDateBeg:=clickDate
	Else 
		vdDateEnd:=clickDate
	End if 
Else 
	vdDateBeg:=clickDate
	vdDateEnd:=clickDate
End if 

Cal_SearchMySales