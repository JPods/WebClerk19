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
		ConsoleLog("Tallymaster did not build aName, purpose = olo_list, name = name")
	End if 
End if 
var $ptArray : Pointer
var $arrayName : Text
If (process_o.dataClassName=Null:C1517)
	$arrayName:="<>aActionsCustomers"
Else 
	$arrayName:="<>aActions"+process_o.dataClassName+"s"
End if 

var $obSel : Object
var $name : Text
C_COLLECTION:C1488(cActions)
cActions:=ds:C1482.PopupChoice.query("arrayName = :1"; $arrayName).orderBy("choice").distinct("choice")
If (cActions.length=0)
	cActions:=ds:C1482.PopupChoice.query("arrayName = :1"; "<>aActions").orderBy("choice").distinct("choice")
End if 
COLLECTION TO ARRAY:C1562(cActions; aActions)
If (Size of array:C274(aActions)>0)
	If (aActions{1}#"")
		INSERT IN ARRAY:C227(aActions; 1; 1)
	End if 
	aActions{1}:="Actions"
End if 
