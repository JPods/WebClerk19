//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/26/06, 08:58:26
// ----------------------------------------------------
// Method: WOCalRefresh
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (eSerCal>0)
	$dtBegin:=DateTime_DTTo(Date_ThisMon(vCalendarBegin; 0))
	$dtEnd:=DateTime_DTTo(vCalendarend; ?23:59:59?)
	QUERY:C277([WorkOrder:66]; [WorkOrder:66]dtAction:5>=$dtBegin; *)
	QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtAction:5<=$dtEnd; *)
	If (aTmp25Str2>1)
		QUERY:C277([WorkOrder:66];  & [WorkOrder:66]actionBy:8=aTmp25Str2{aTmp25Str2}; *)
	End if 
	QUERY:C277([WorkOrder:66])
	WOCalendarFillList(vCalendarBegin; vCalendarend)
End if 


If (False:C215)
	
	ALL RECORDS:C47([Contact:13])
	vi2:=Records in selection:C76([Contact:13])
	FIRST RECORD:C50([Contact:13])
	For (vi1; 1; vi2)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
		If (Records in selection:C76([Customer:2])=0)
			[Contact:13]action:32:="Orphan"
			SAVE RECORD:C53([Contact:13])
		End if 
		NEXT RECORD:C51([UserReport:46])
	End for 
	QUERY:C277([Contact:13]; [Contact:13]action:32="Orphan")
	ProcessTableOpen(Table:C252(->[Contact:13]))
	
	ALL RECORDS:C47([TallyMaster:60])
	vi2:=Records in selection:C76([TallyMaster:60])
	ALERT:C41("TallyMasters: "+String:C10(vi2))
	FIRST RECORD:C50([TallyMaster:60])
	For (vi1; 1; vi2)
		[TallyMaster:60]after:7:=Replace string:C233([TallyMaster:60]after:7; "[Order]MfgAcctCode"; "[Order]mfrID")
		[TallyMaster:60]build:6:=Replace string:C233([TallyMaster:60]build:6; "[Order]MfgAcctCode"; "[Order]mfrID")
		[TallyMaster:60]script:9:=Replace string:C233([TallyMaster:60]script:9; "[Order]MfgAcctCode"; "[Order]mfrID")
		SAVE RECORD:C53([TallyMaster:60])
		NEXT RECORD:C51([TallyMaster:60])
	End for 
	ALL RECORDS:C47([UserReport:46])
	vi2:=Records in selection:C76([UserReport:46])
	ALERT:C41("UserReports: "+String:C10(vi2))
	FIRST RECORD:C50([UserReport:46])
	For (vi1; 1; vi2)
		[UserReport:46]scriptBegin:5:=Replace string:C233([UserReport:46]scriptBegin:5; "[Order]MfgAcctCode"; "[Order]mfrID")
		[UserReport:46]scriptEnd:38:=Replace string:C233([UserReport:46]scriptEnd:38; "[Order]MfgAcctCode"; "[Order]mfrID")
		[UserReport:46]scriptLoop:34:=Replace string:C233([UserReport:46]scriptLoop:34; "[Order]MfgAcctCode"; "[Order]mfrID")
		
		SAVE RECORD:C53([UserReport:46])
		NEXT RECORD:C51([UserReport:46])
	End for 
	
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=0)
	vi2:=Records in selection:C76([Contact:13])
	ALERT:C41("Contacts: "+String:C10(vi2))
	FIRST RECORD:C50([Contact:13])
	For (vi1; 1; vi2)
		
		SAVE RECORD:C53([Contact:13])
		NEXT RECORD:C51([Contact:13])
	End for 
	
End if 