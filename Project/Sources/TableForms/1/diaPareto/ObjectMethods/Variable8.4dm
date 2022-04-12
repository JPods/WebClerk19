jRayAtts(0)
b2:=0
b1:=0
b3:=1
MESSAGES OFF:C175
USE SET:C118("Pareto")
QUERY SELECTION BY FORMULA:C207([Service:6]; [Service:6]attribute:5=aAttributes{aAttributes})
viRecordsInTable:=Size of array:C274(aCauses)
viRecordsInSelection:=Records in selection:C76([Service:6])
MESSAGES ON:C181