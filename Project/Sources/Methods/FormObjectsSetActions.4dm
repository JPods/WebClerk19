//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-18T00:00:00, 16:45:58
// ----------------------------------------------------
// Method: FormObjectsSetActions
// Description
// Modified: 08/18/17
// 
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($incTables; $cntTables)
C_LONGINT:C283($incForms; $cntForms)
C_LONGINT:C283($incObjects; $cntObjects)
// List all the project forms of the database
ARRAY TEXT:C222($arr_Names; 0)
$cntTables:=Get last table number:C254
For ($incTables; 1; $cntTables)
	
	FORM GET NAMES:C1167(Table:C252($incTables)->; $arr_Names)
	$cntForms:=Size of array:C274($arr_Names)
	// get the objects for the form
	
	//
	For ($incForms; 1; $cntForms)
		FormSetObjectActions(Table:C252($incTables); $arr_Names{$incForms})
	End for 
End for 
// GET LIST ITEM PROPERTIES({*;}list;itemRef | *;enterable{;styles{;icon{;color}}})