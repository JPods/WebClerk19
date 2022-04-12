jRayProcesses(0)
b1:=0
b2:=1
b3:=0
MESSAGES OFF:C175
USE SET:C118("Pareto")
QUERY SELECTION BY FORMULA:C207([Service:6]; [Service:6]process:4=<>aProcesses{<>aProcesses})
viRecordsInTable:=Size of array:C274(aAttributes)
viRecordsInSelection:=Records in selection:C76([Service:6])
MESSAGES ON:C181