//%attributes = {}

// Modified by: Bill James (2022-01-18T06:00:00Z)
// Method: Form_TaskActions
// Description 
// Parameters
// ----------------------------------------------------

var $doStd : Boolean
ARRAY TEXT:C222(aActions; 0)
var $tmo : Object
$doStd:=True:C214
$tmo:=ds:C1482.TallyMaster.query("purpose = :1 & name = :2"; "olo_list"; "actions").first()
If ($tmo#Null:C1517)
	ExecuteScript($tmo.script)
	If (Size of array:C274(aActions)>0)
		$doStd:=False:C215
	Else 
		ConsoleMessage("Tallymaster did not build aName, purpose = olo_list, name = name")
	End if 
End if 
If ($doStd)
	COPY ARRAY:C226(<>aNameID; aActions)
	Case of 
		: (process_o.tableName="Contact")
			COPY ARRAY:C226(<>aNameID; aActions)
		: (process_o.tableName="Customer")
			
			COPY ARRAY:C226(<>aNameID; aActions)
		: (process_o.tableName="Order")
			COPY ARRAY:C226(<>aNameID; aActions)
		: (process_o.tableName="PO")
			COPY ARRAY:C226(<>aNameID; aActions)
		: (process_o.tableName="Customer")
	End case 
End if 