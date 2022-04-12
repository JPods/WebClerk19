//%attributes = {"publishedWeb":true}
// https://kb.4d.com/assetid=78252


C_LONGINT:C283($pid)
C_OBJECT:C1216($employeeSelection)
$employeeSelection:=ds:C1482.Employee.all()
// cannot pass an entity selection to a new process. Convert to a collection
$pid:=New process:C317("testMethod"; 0; "Process A"; $employeeSelection.toCollection())

// in the new process dataClass.fromCollection() to recreate the entity.
C_OBJECT:C1216($employees)
C_COLLECTION:C1488($1)
$employees:=ds:C1482.Employee.fromCollection($1)

