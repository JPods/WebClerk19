//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/10/18, 19:51:12
// ----------------------------------------------------
// Method: TNLoadTemplate
// Description
// 
//
// Parameters
// ----------------------------------------------------

READ ONLY:C145([TallyMaster:60])
C_TEXT:C284(vtTNTemplate)
QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8="TechNoteWrapper"; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="Admin"; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25=1)
If (Records in selection:C76([TallyMaster:60])=1)
	vtTNTemplate:=[TallyMaster:60]template:29
Else 
	If (allowAlerts_boo)
		ALERT:C41("Error: There are "+String:C10(Records in selection:C76([TallyMaster:60]))+" [TallyMaster]Name = TechNoteWrapper")
	End if 
	vtTNTemplate:="<html><title>_jit_0_TechNoteTitlejj</title><body>_jit_0_TechNoteContentjj</body></html>"
End if 
REDUCE SELECTION:C351([TallyMaster:60]; 0)
READ WRITE:C146([TallyMaster:60])