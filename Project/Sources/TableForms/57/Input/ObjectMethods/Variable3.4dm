C_LONGINT:C283($dtBegin; $dtEnd; $TableNum)
KeyModifierCurrent
If (OptKey=1)
	vdDateBeg:=!00-00-00!
	vdDateEnd:=Current date:C33
	$dtBegin:=DateTime_Enter(vdDateBeg; ?00:00:00?)
	$dtEnd:=DateTime_Enter(vdDateEnd; ?23:59:59?)
Else 
	//jBetweenDates ("EventLogs in Period.";Current date-30;Current date)
	$dtBegin:=DateTime_Enter(vdDateBeg; ?00:00:00?)
	$dtEnd:=DateTime_Enter(vdDateEnd; ?23:59:59?)
End if 
// ### bj ### 20200915_2118
If ((([RemoteUser:57]tableNum:9=Table:C252(->[Employee:19])) | ([RemoteUser:57]tableNum:9=Table:C252(->[Rep:8]))))  //  & (<>vMakeSales>0))
	QUERY:C277([EventLog:75]; [EventLog:75]idPrimary:30=[RemoteUser:57]customerID:10; *)
	QUERY:C277([EventLog:75];  & [EventLog:75]tableNumWccPrime:24=[RemoteUser:57]tableNum:9; *)
	QUERY:C277([EventLog:75];  & [EventLog:75]dtEvent:1>=$dtBegin; *)
	QUERY:C277([EventLog:75];  & [EventLog:75]dtEvent:1<=$dtEnd)
Else 
	QUERY:C277([EventLog:75]; [EventLog:75]customerID:38=[RemoteUser:57]customerID:10; *)
	QUERY:C277([EventLog:75];  & [EventLog:75]tableNum:9=[RemoteUser:57]tableNum:9; *)
	QUERY:C277([EventLog:75];  & [EventLog:75]dtEvent:1>=$dtBegin; *)
	QUERY:C277([EventLog:75];  & [EventLog:75]dtEvent:1<=$dtEnd)
End if 
ProcessTableOpen(Table:C252(->[EventLog:75])*-1)
