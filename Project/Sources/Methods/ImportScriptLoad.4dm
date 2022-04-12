//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-12-16T00:00:00, 22:35:57
// ----------------------------------------------------
// Method: ImportScriptLoad
// Description
// Modified: 12/16/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284(vtallyMastersName)
C_TEXT:C284($1; $purpose; $1; $name; $2)
$purpose:="ImportScript"
$name:=vtallyMastersName
If (Count parameters:C259>0)
	$purpose:=$1
	If (Count parameters:C259>1)
		$name:=$2
	End if 
End if 
C_LONGINT:C283(vSetPublish; vMakeKeyWords; vMakeItemNum; $error)
vSetPublish:=0
vMakeKeyWords:=0
vSetPublish:=0
$error:=DefaultSetupReturn("vSetPublish")
$error:=DefaultSetupReturn("vMakeKeyWords")
$error:=DefaultSetupReturn("vMakeItemNum")
If (curTableNum=Table:C252(->[Item:4]))
	Key_BadWords("Item")
End if 
scriptBegin:=""
scriptRecord:=""
scriptEnd:=""
If (vtallyMastersName#"")
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3=$purpose; *)
	QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=$name)
	If (Records in selection:C76([TallyMaster:60])=1)
		scriptBegin:=[TallyMaster:60]script:9
		scriptRecord:=[TallyMaster:60]build:6
		scriptEnd:=[TallyMaster:60]after:7
	End if 
	REDUCE SELECTION:C351([TallyMaster:60]; 0)
End if 