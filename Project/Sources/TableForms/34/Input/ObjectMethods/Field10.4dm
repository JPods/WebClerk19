// ----------------------------------------------------
// User name (OS): jmedlen
// Date and time: 10/22/09, 10:53:47
// ----------------------------------------------------
// Method: Object Method: Completed
// Description
// Form: iCallReports_9
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//Date: 07/07/02
	//Who: Bill
	//Description: Added field  
	//modified 10/22/2009 James W. Medlen added status update
	
	VERSION_960
End if 
If ([CallReport:34]complete:7=True:C214)
	vDateCRCompleted:=Current date:C33
	vTimeCRCompleted:=Current time:C178
	[CallReport:34]dtComplete:33:=DateTime_Enter(vDateCRCompleted; vTimeCRCompleted)
	[CallReport:34]status:34:="Completed"
Else 
	vDateCRCompleted:=!00-00-00!
	vTimeCRCompleted:=?00:00:00?
	[CallReport:34]dtComplete:33:=0
	[CallReport:34]status:34:="Open"
End if 