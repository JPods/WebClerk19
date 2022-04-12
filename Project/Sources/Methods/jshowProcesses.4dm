//%attributes = {"publishedWeb":true}
READ WRITE:C146([Process:16])
READ WRITE:C146([Attribute:17])
READ WRITE:C146([Cause:18])
C_BOOLEAN:C305(doService)
ARRAY TEXT:C222(aAttributes; 0)
ARRAY TEXT:C222(aCauses; 0)
DELETE FROM ARRAY:C228(<>aProcesses; 1; 1)
DELETE FROM ARRAY:C228(<>aProcessNums; 1; 1)
jCenterWindow(434; 300; 1)
DIALOG:C40([Process:16]; "diaProcessesCau")
CLOSE WINDOW:C154
If (doService)
	[Service:6]process:4:=<>aProcesses{<>aProcesses}
	[Service:6]attribute:5:=aAttributes{aAttributes}
	[Service:6]cause:7:=aCauses{aCauses}
End if 
INSERT IN ARRAY:C227(<>aProcesses; 1; 1)
INSERT IN ARRAY:C227(<>aProcessNums; 1; 1)
<>aProcesses{1}:="Process"
ARRAY TEXT:C222(aAttributes; 1)
ARRAY LONGINT:C221(aAttNums; 1)
aAttributes{1}:="Attribute"
ARRAY TEXT:C222(aCauses; 1)
ARRAY LONGINT:C221(aCauseNums; 1)
aCauses{1}:="Causes"
UNLOAD RECORD:C212([Process:16])
UNLOAD RECORD:C212([Attribute:17])
UNLOAD RECORD:C212([Cause:18])
READ ONLY:C145([Process:16])
READ ONLY:C145([Attribute:17])
READ ONLY:C145([Cause:18])