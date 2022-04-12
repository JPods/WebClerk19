//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/08/11, 22:23:25
// ----------------------------------------------------
// Method: ExportTablesFields
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($textTemplate)
C_TEXT:C284($1; $tallyName; $2; $tallyPurpose)
$tallyName:=$1
$tallyPurpose:=$2
QUERY:C277([TallyMaster:60]; [TallyMaster:60]Purpose:3=$tallyPurpose; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]Name:8=$tallyName)
If (Records in selection:C76([TallyMaster:60])=1)
	iLoText14:=[TallyMaster:60]Script:9
	iLoText15:=[TallyMaster:60]Build:6
	iLoText16:=[TallyMaster:60]After:7
End if 

If (iLoText14#"")
	ExecuteText(0; iLoText14)
	//read in template and 
End if 