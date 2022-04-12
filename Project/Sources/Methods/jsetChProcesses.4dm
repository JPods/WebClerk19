//%attributes = {"publishedWeb":true}
READ ONLY:C145([Process:16])
ALL RECORDS:C47([Process:16])
If (Records in selection:C76([Process:16])>0)
	ORDER BY:C49([Process:16]; [Process:16]seq:1)
End if 

SELECTION TO ARRAY:C260([Process:16]process:2; <>aProcesses; [Process:16]idNum:4; <>aProcessNums)
UNLOAD RECORD:C212([Process:16])
INSERT IN ARRAY:C227(<>aProcesses; 1; 1)
<>aProcesses{1}:="Process"
<>aProcesses:=1
INSERT IN ARRAY:C227(<>aProcessNums; 1; 1)
ARRAY TEXT:C222(aAttributes; 1)
aAttributes{1}:="Attribute"
ARRAY TEXT:C222(aCauses; 1)
aCauses{1}:="Cause"
READ WRITE:C146([Process:16])
REDUCE SELECTION:C351([Process:16]; 0)