//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/04/18, 15:27:22
// ----------------------------------------------------
// Method: TMQueryTask
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $tmPurpose)
$tmPurpose:=$1
If ($1#"")
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]Purpose:3=$tmPurpose)
	If (Records in selection:C76([TallyMaster:60])=0)
		CREATE RECORD:C68([TallyMaster:60])
		[TallyMaster:60]Name:8:="ReplaceWithYourName"
		[TallyMaster:60]Purpose:3:=$tmPurpose
		SAVE RECORD:C53([TallyMaster:60])
	End if 
	ProcessTableOpen(Table:C252(->[TallyMaster:60]); ""; $tmPurpose)
End if 