
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 11/08/17, 12:51:55
// ----------------------------------------------------
// Method: [Control].diaDateTimeCalc
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_DATE:C307(vdStDate; vdEndDate)
C_TIME:C306(vtStTime; vtEndTime)
C_LONGINT:C283(vlDTStart; vlDTEnd)
Case of 
	: (Before:C29)
		vdStDate:=Current date:C33
		vtStTime:=?00:00:00?
		vdEndDate:=Current date:C33
		vtEndTime:=?23:59:59?
		vlDTStart:=DateTime_Enter(vdStDate; vtStTime)
		vlDTEnd:=DateTime_Enter(vdEndDate; vtEndTime)
		SET MENU BAR:C67(6)
	: (Outside call:C328)
		Prs_OutsideCall
End case 