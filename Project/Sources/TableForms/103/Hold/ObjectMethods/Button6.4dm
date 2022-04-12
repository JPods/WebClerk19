// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/21/11, 14:33:17
// ----------------------------------------------------
// Method: Object Method: B12
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($adderComment)

QUERY:C277([SyncRecord:109]; [SyncRecord:109]statusSend:17="Conflict")
If ((vUniqueID#0) & (bAllTables=0))
	QUERY:C277([SyncRecord:109];  & ; [SyncRecord:109]idNum:1=vUniqueID; *)
	$adderComment:="Local Conflicts: "+HTTP_Host+", "+vScript
Else 
	$adderComment:="Conflicts"
End if 
QUERY:C277([SyncRecord:109])

DB_ShowCurrentSelection(->[SyncRecord:109]; ""; 1; $adderCommentt; 0)
// DB_ShowCurrentSelection (-[SyncRecord];no script;create a set "";$adderComment;  0 -- unload current process)
