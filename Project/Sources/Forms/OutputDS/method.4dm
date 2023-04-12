
// Modified by: Bill James (2022-03-30T05:00:00Z)
// Method: OutputDS
// Description 
// Parameters
// ----------------------------------------------------

var $event_o; $related_o : Object
var Formeventcode : Integer
var ptCurTable; ptCurID : Pointer
var $tableNum_l; $fieldNum_l : Integer

$event_o:=FORM Event:C1606
Case of 
	: (FORM Event:C1606.objectName#Null:C1517)  // avoid action 
		
	: (Form event code:C388=On Load:K2:1)
		// https://discuss.4d.com/t/cant-see-form-object-bound-variable-in-subforms/20446/5
		// Form cannot be seen in subform without:
		
		// keep things in the their own subforms and add to process_o
		
		process_o._setInit()
		If (process_o.menu=Null:C1517)
			process_o.menu:=1
		End if 
		process_o.setMenu(process_o.menu)
		// subform name, table, form name
		
		
		If (process_o.source=Null:C1517)
			process_o.setSource(ds:C1482[process_o.dataClassName].all())  //
			// data source must be set
			process_o.setTitle()
		End if 
		
		
		
		//  set list subForm
		// Fix_QQQ by: Bill James (2023-04-06T05:00:00Z)
		// shift to FC record pulling in the form
		OBJECT SET SUBFORM:C1138(*; process_o.sf.list.nameSF; "ListSelection")
		
		
		// Fix_QQQ by: Bill James (2023-04-06T05:00:00Z)
		// change this to load the subform or build the columns depending of fc
		
		
		//  set entry subForm
		// Fix_QQQ by: Bill James (2023-04-06T05:00:00Z)
		// shift to FC record pulling in the form
		OBJECT SET SUBFORM:C1138(*; process_o.sf.entry.nameSF; (process_o.dataClassPtr)->; process_o.sf.entry.nameForm)
		
		
		
		ARRAY TEXT:C222(aLayouts; 0)
		If (This:C1470.relatedForms#Null:C1517)
			COLLECTION TO ARRAY:C1562(process_o.layouts.list; aLayouts)
			aLayouts:=Find in array:C230(aLayouts; "Selection")
		End if 
		
		// why entry_o is lost is unclear
		// must be here to populate the variable onLoad, do the same onClick
		// this should be a class behavior
		var entrySF : cs:C1710.cEntry
		entrySF:=cs:C1710.cEntry.new()
		entrySF.entry_o:=process_o.entry_o
		
		entry_o:=process_o.entry_o
		entrySF._getRelated()
		
		// process_o.dataClassName+"; Selection: "+String(process_o.ents)+"; Entry: "+entry_o.humanKey
		//setup to drag between listboxes
		dragFrom:=""
		
	: (Form event code:C388=-100)
		// OBJECT SET SUBFORM(*; "SF_List"; process_o.layoutList)
		
		
	: (Form event code:C388=On Selection Change:K2:29)
		// in listbox
		
	: (Form event code:C388=On Clicked:K2:4)
		
		entry_o:=process_o.listClick()
		process_o.titleSet()
		
		
		FormEventOnDisplayDetail
		
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
