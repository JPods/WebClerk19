//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 07/15/21, 19:11:45
// ----------------------------------------------------
// Method: ProcessOutput
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $tableName)
C_TEXT:C284($2; $script_t)
C_TEXT:C284($3; $menuAdder_t)
C_OBJECT:C1216($process_o)
Process_InitLocal
oProcess:=New object:C1471("tableName"; "Customer"; "tableNum"; 2; "script"; ""; "menu"; "")
If (Count parameters:C259>0)
	oProcess.tableName:=$1
	oProcess.tableNum:=STR_GetTableNumber(oProcess.tableName)
	If (Count parameters:C259>1)
		oProcess.script:=$2
		If (Count parameters:C259>2)
			oProcess.menu:=$3
		End if 
	End if 
End if 
oProcess.processNum:=Current process:C322
oProcess.processParent:=-1
oProcess.form:=$form_t

C_TEXT:C284($form_t)
C_LONGINT:C283($win_l)
C_LONGINT:C283($cascade_l)
ARRAY LONGINT:C221($windowList_al; 0)
vtTableName:="Customer"
$form_t:="Dual"
WINDOW LIST:C442($windowList_al)
$cascade_l:=Size of array:C274($windowList_al)
If ($cascade_l>8)
	$cascade_l:=1
End if 
$win_l:=Open form window:C675([Customer:2]; $form_t; Plain form window:K39:10; ($cascade_l*20); 40+($cascade_l*20))
oProcess.window:=$win_l
DIALOG:C40([Customer:2]; $form_t)
CLOSE WINDOW:C154($win_l)
