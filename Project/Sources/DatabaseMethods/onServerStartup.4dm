// If (False)
C_BOOLEAN:C305($doStartup)
$doStartup:=True:C214

ServerStartup
// ======================
//  server only
// ======================

// clear completed Couter pending

QUERY:C277([CounterPending:135]; [CounterPending:135]status:7=2)
DELETE SELECTION:C66([CounterPending:135])

// reset control records if needed
QUERY:C277([Control:1]; [Control:1]idNum:7=0)
If (Records in selection:C76([Control:1])>0)
	ALL RECORDS:C47([Control:1])
	DELETE SELECTION:C66([Control:1])
	For ($i; 1; 100)
		CREATE RECORD:C68([Control:1])
		
		SAVE RECORD:C53([Control:1])
	End for 
	// ### bj ### 20180913_2345 already in the create record
	// UUIDResetValues (->[Control]id)
End if 
REDUCE SELECTION:C351([Control:1]; 0)




QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="Admin"; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8="ServerStartup"; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25=1)
If (Records in selection:C76([TallyMaster:60])>0)
	FIRST RECORD:C50([TallyMaster:60])
	Execute_TallyMaster([TallyMaster:60]purpose:3; [TallyMaster:60]name:8; 1)
End if 

//SET DATABASE PARAMETER(Idle Connections Timeout ;60)
SET DATABASE PARAMETER:C642(11; 60)
allowAlerts_boo:=False:C215

// ### jwm ### 20191018_1650 4D Info Reports to Capture Crash Data
ARRAY TEXT:C222($at_Components; 0)
COMPONENT LIST:C1001($at_Components)
If (Find in array:C230($at_Components; "4D_Info_Report@")>0)
	// to start the stored procedure creating report every 5 minutes
	EXECUTE METHOD:C1007("aa4D_NP_Schedule_Reports_Server"; *; 5; 0)
End if 