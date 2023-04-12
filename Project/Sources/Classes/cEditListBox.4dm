Class constructor($name : Text; $datasource : Object)
	
	
	This:C1470.name:=$lbName  //      the name of the listbox
	This:C1470.dataClassName:=$dataClassName
	This:C1470.ref:=$ref
	
	This:C1470.source:=Null:C1517  //  collection/entity selection form.<>.data is drawn from
	This:C1470.ents:=Null:C1517
	This:C1470.sel:=Null:C1517
	This:C1470.kind:=Null:C1517
	This:C1470.edit:=Null:C1517
	This:C1470.old:=Null:C1517
	This:C1470.cur:=Null:C1517
	This:C1470.pos:=0
	This:C1470.entry_o:=Null:C1517
	This:C1470.related:=Null:C1517
	This:C1470.meta:=Null:C1517
	This:C1470.layout:=New object:C1471("DataBrowser"; New object:C1471("columns"; Null:C1517; "settings"; Null:C1517; "fieldEdits"; Null:C1517); \
		"DSOutput"; New object:C1471("columns"; Null:C1517; "settings"; Null:C1517; "fieldEdits"; Null:C1517))
	
	
	// could change to a case based on the $dataClassName
	If (process_o.dataClassNameLines#Null:C1517)
		This:C1470.dataClassNameLines:=process_o.dataClassNameLines
	End if 
	
	
	//MARK:-  setters and saves
	
Function setForm($formName : Text; $form : Object)
	OBJECT SET SUBFORM:C1138(*; $formName; $form)
	
	
	
	//MARK:-  getters and create
	
	
	//MARK:-  calcs
	
	
	//MARK:- admin
Function redraw()
	This:C1470.ents:=This:C1470.ents
	
Function reset()
	This:C1470.ents:=This:C1470.source