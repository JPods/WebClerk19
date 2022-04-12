// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/21/11, 14:36:01
// ----------------------------------------------------
// Method: Object Method: B18
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (vUniqueID#0)
	QUERY:C277([SyncRecord:109]; [SyncRecord:109]idNum:1=vUniqueID; *)
	QUERY:C277([SyncRecord:109];  & [SyncRecord:109]dtComplete:8#0; *)
	QUERY:C277([SyncRecord:109];  & [SyncRecord:109]statusSend:17="Ignored")
	DB_ShowCurrentSelection(->[SyncRecord:109])
Else 
	ALERT:C41("Choose a SyncRelationship.")
End if 


C_TEXT:C284($adderComment)

QUERY:C277([SyncRecord:109]; [SyncRecord:109]statusSend:17="Ignored")
If ((vUniqueID#0) & (bAllTables=0))
	QUERY:C277([SyncRecord:109];  & ; [SyncRecord:109]idNum:1=vUniqueID; *)
	$adderComment:="Local Ignored: "+HTTP_Host+", "+vScript
Else 
	$adderComment:="Ignored"
End if 
QUERY:C277([SyncRecord:109])

DB_ShowCurrentSelection(->[SyncRecord:109]; ""; 1; $adderCommentt; 0)
// DB_ShowCurrentSelection (-[SyncRecord];no script;create a set "";$adderComment;  0 -- unload current process)
