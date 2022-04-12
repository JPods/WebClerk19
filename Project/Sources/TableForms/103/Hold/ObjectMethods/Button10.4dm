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



If ((vUniqueID#0) & (bAllTables=0))
	QUERY:C277([SyncRecord:109]; [SyncRecord:109]idNum:1=vUniqueID)
	$adderComment:="All records: "+HTTP_Host+", "+vScript
Else 
	ALL RECORDS:C47([SyncRecord:109])
	$adderComment:="All records"
End if 

DB_ShowCurrentSelection(->[SyncRecord:109]; ""; 1; $adderCommentt; 0)
// DB_ShowCurrentSelection (-[SyncRecord];no script;create a set "";$adderComment;  0 -- unload current process)
