//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/16/20, 14:50:16
// ----------------------------------------------------
// Method: ServMySaleServiceFieldList
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($1; $tableName; $0; $2)

$0:=$2
$tableName:=$1
READ ONLY:C145([TallyMaster:60])
// perhaps make this current user as an option
QUERY:C277([TallyMaster:60]; [TallyMaster:60]Purpose:3="MySalesService"; *)
QUERY:C277([TallyMaster:60];  & ; [TallyMaster:60]Name:8=$tableName)
If (Records in selection:C76([TallyMaster:60])>0)
	FIRST RECORD:C50([TallyMaster:60])
	If ([TallyMaster:60]Build:6#"")
		$0:=[TallyMaster:60]Build:6
	End if 
End if 
REDUCE SELECTION:C351([TallyMaster:60]; 0)
READ WRITE:C146([TallyMaster:60])
