
// Modified by: Bill James (2022-03-30T05:00:00Z)
// Method: OutputDS
// Description 
// Parameters
// ----------------------------------------------------

var $event_o : Object
var Formeventcode : Integer
var ptCurTable; ptCurID : Pointer
var $tableNum_l; $fieldNum_l : Integer

$event_o:=FORM Event:C1606
Case of 
		
	: (Form event code:C388=-122)
		
	: (Form event code:C388=On Selection Change:K2:29)
		
		var $subForm_o : Object
		var $methodName_t : Text
		$subForm_o:=New object:C1471("tableName"; process_o.tableName; \
			"id"; process_o.cur.id)
		$methodName_t:="SF_InputLoad"
		// load a change in .cur into the input form
		EXECUTE METHOD IN SUBFORM:C1085("SF_Entry"; $methodName_t; *; $subForm_o)
		process_o.old:=process_o.cur.clone()
		process_o.entsOther[process_o.tableName]:=Form:C1466.cur
		
		// do this when process_o.cur changes
		// Storage_LastRecord(process_o.tableName; process_o.cur.id)
		
	: (Form event code:C388=On Clicked:K2:4)
		
		
		
		SET WINDOW TITLE:C213(process_o.tableName+" displayed/selected: "+String:C10(process_o.ents.length)+"/"+String:C10(process_o.displayedSelected.length))
		
		
		
		
		FormEventOnDisplayDetail
	: (Form event code:C388=On Load:K2:1)
		SET MENU BAR:C67(1)
		// this works with the data being populated in the form
		OBJECT SET SUBFORM:C1138(*; "SF_List"; "ListSelection")
		OBJECT SET SUBFORM:C1138(*; "SF_Input"; ptCurTable->; "InputDS")
		var $o : Object
		//33//$o:=New object("tableName"; aSalesTables{aSalesTables}; "tableParent"; "Customer"; "id"; entryEntity.id)
		//33//EXECUTE METHOD IN SUBFORM("SF_Sales"; "SF_Sales_Execute"; *; $o)
		// organize the tools
		Form_TaskActions
		Form_TaskNames
		Form_TaskScripts
		Form_TaskQueries
		Form_TaskDetails
		
		If (True:C214)
			process_o.cur:=process_o.ents.first()
			process_o.old:=process_o.cur.clone()
			SET WINDOW TITLE:C213(process_o.tableName+" displayed/selected: "+String:C10(process_o.ents.length)+" / "+String:C10(process_o.sel.length))
		Else 
			
			SET WINDOW TITLE:C213(process_o.tableName+" displayed/selected: "+String:C10(Form:C1466.ents.length)+" / "+String:C10(Form:C1466.sel.length))
			
			
		End if 
	: (Form event code:C388=On Activate:K2:9)
		FormEventOnActivate
	: (Form event code:C388=On Close Detail:K2:24)
		FormEventCloseDetail
	: (Form event code:C388=On Unload:K2:2)
		FormEventOnUnloadOLO
	: (Form event code:C388=On Double Clicked:K2:5)
		
		
	: (Form event code:C388=On Header:K2:17)
		FormEventOnHeader
	: (Form event code:C388=On Selection Change:K2:29)
		
		
		FormEventOnSelectionChange
	: (Form event code:C388=On Open Detail:K2:23)
		
		FormEventOnOpenDetail
	: (Form event code:C388=On Close Box:K2:21)
		FormEventOnCloseBox
		
	: (Form event code:C388=On Outside Call:K2:11)  // (Outside call)
		Prs_OutsideCall
		
	Else 
		
End case 
