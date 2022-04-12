//%attributes = {}

// Modified by: Bill James (2022-01-18T06:00:00Z)
// Method: Form_TaskNames
// Description 
// Parameters
// ----------------------------------------------------
ARRAY TEXT:C222(aName; 0)
var $tmo : Object
$tmo:=ds:C1482.TallyMaster.query("purpose = :1 & name = :2"; "olo_list"; "name").first()
If ($tmo#Null:C1517)
	ExecuteScript($tmo.script)
	
	If (Size of array:C274(aName)=0)
		COPY ARRAY:C226(<>aNameID; aName)
		ConsoleMessage("Tallymaster did not build aName, purpose = olo_list, name = name")
	End if 
Else 
	COPY ARRAY:C226(<>aNameID; aName)
End if 
