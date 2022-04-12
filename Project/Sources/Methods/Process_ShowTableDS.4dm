//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/26/21, 00:33:26
// ----------------------------------------------------
// Method: Process_ShowTableDS
// Description
// 
// Parameters
// ----------------------------------------------------
var process_o; $1 : Object

If (Count parameters:C259=0)
	process_o:=New object:C1471("ents"; New object:C1471; \
		"cur"; New object:C1471; \
		"sel"; New object:C1471; \
		"pos"; -1; \
		"entsOther"; New object:C1471("tableName"; New object:C1471); \
		"tableName"; "Customer"; \
		"tableForm"; ""; \
		"form"; "OutputDS"; \
		"image"; New object:C1471; \
		"path"; New object:C1471; \
		"process"; Current process:C322)
Else 
	process_o:=$1
End if 

//process_o.SF_List:=SF_List
//process_o.SF_Input:=SF_Input

//This.process_o:=process_o
//This.SF_List:=Null
//This.SF_Entity:=Null
//This.aSalesTables_o:=Null

var entryEntity : Object
Case of 
	: (process_o.cur#Null:C1517)
		entryEntity:=process_o.cur.toObject()
	: (process_o.ents#Null:C1517)
		process_o.cur:=process_o.ents.first()
		entryEntity:=process_o.cur.toObject()
		// create a new record
End case 


Prs_ListActive
Process_InitLocal
C_TEXT:C284($form_t)
C_LONGINT:C283($win_l)
C_LONGINT:C283($cascade_l)
If (process_o.tableName=Null:C1517)
	process_o.tableName:="Customer"
End if 
tableName:=process_o.tableName
ptCurTable:=STR_GetTablePointer(tableName)
If (process_o.form=Null:C1517)
	process_o.form:="Output"
End if 
$form_t:=process_o.form
C_OBJECT:C1216($obWindows)
$obWindows:=WindowCountToShow
If (process_o.tableForm="")
	$win_l:=Open form window:C675($form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
	process_o.window:=$win_l
	DIALOG:C40($form_t)
Else 
	$win_l:=Open form window:C675(ptCurTable->; $form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
	process_o.window:=$win_l
	DIALOG:C40($form_t)
End if 

CLOSE WINDOW:C154($win_l)