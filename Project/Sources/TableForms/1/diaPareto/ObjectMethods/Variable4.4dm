$myErr:=False:C215
MESSAGES OFF:C175
aAttributes:=0
aAttCodes:=0
ARRAY TEXT:C222(aCauses; 0)
If (<>aProcesses>0)
	b1:=0
	b2:=1
	b3:=0
	USE SET:C118("Pareto")
	QUERY SELECTION BY FORMULA:C207([Service:6]; [Service:6]process:4=<>aProcesses{<>aProcesses})
	viRecordsInTable:=Size of array:C274(aAttributes)
	viRecordsInSelection:=Records in selection:C76([Service:6])
	MESSAGES ON:C181
Else 
	jAlertMessage(10012)
	b1:=1
	b2:=0
	b3:=0
	ARRAY TEXT:C222(aAttributes; 0)
End if 