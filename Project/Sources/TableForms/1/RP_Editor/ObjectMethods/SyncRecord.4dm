
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/14/20, 22:27:30
// ----------------------------------------------------
// Method: [Control].RP_Editor.SyncRecord
// Description
// 
//
// Parameters
// ----------------------------------------------------


QUERY:C277([SyncRelation:103]; [SyncRelation:103]idNum:1=vUniqueID)
RP_JSONSend

QUERY:C277([SyncRelation:103]; [SyncRelation:103]active:17=True:C214)
//  CHOPPED  AL_UpdateFields(eSyncSelection; 2)
