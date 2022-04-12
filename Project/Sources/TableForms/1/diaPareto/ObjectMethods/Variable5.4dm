$myErr:=False:C215
MESSAGES OFF:C175
aCauses:=0
If (<>aProcesses>0)
	If (aAttributes>0)
		USE SET:C118("Pareto")
		QUERY SELECTION BY FORMULA:C207([Service:6]; [Service:6]attribute:5=aAttributes{aAttributes})
		viRecordsInTable:=Size of array:C274(aCauses)
		viRecordsInSelection:=Records in selection:C76([Service:6])
		MESSAGES ON:C181
		b1:=0
		b2:=0
		b3:=1
	Else 
		$myErr:=True:C214
	End if 
Else 
	$myErr:=True:C214
End if 
If ($myErr)
	jAlertMessage(10012)
	ARRAY TEXT:C222(aAttributes; 0)
	ARRAY TEXT:C222(aCauses; 0)
	b1:=1
	b2:=0
	b3:=0
End if 