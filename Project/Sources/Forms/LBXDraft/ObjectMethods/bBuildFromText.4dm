var $listboxSetup_o : Object
var vtFieldList : Text
var $cFilter : Collection
If (vtFieldList="")
	ALERT:C41("There are not values in the FieldList")
Else 
	
	var $listboxSetup_o; $obSetup : Object
	$listboxSetup_o:=New object:C1471("events"; New object:C1471)
	
	$obSetup:=New object:C1471("listboxName"; "LB_Draft"; \
		"tableName"; $tableName; \
		"subForm"; "SF_Draft")
	
	
	// container to receive the listbox
	// get coordinates for the subform
	OBJECT GET COORDINATES:C663((OBJECT Get pointer:C1124(Object named:K67:5; "SF_Draft"))->; $left; $top; $right; $bottom)
	$width:=$right-$left
	$height:=$bottom-$top
	
	// setup the list box basics
	$tableName:=tableName
	
	// name the listbox
	$lbName_t:="LB_Draft"
	
	var $listbox_o : Object
	$listbox_o:=New object:C1471("type"; "listbox"; \
		"listboxType"; "collection"; \
		"method"; $lbName_t; \
		"metaSource"; $lbName_t; \
		"dataSource"; $lbName_t+"_data"; \
		"currentItemSource"; $lbName_t+"_cur"; \
		"currentItemPositionSource"; $lbName_t+"_pos"; \
		"selectedItemsSource"; $lbName_t+"_sel"; \
		"left"; 0; "top"; 0; \
		"width"; $width+15; "height"; $height; \
		"events"; New collection:C1472; \
		"columns"; New collection:C1472)
	
	// define standard events
	// look at options for this
	If ($listboxSetup_o.events=Null:C1517)
		$listboxSetup_o.events:=Split string:C1554("onLoad,onClick,onDataChange,onSelectionChange"; ",")
	End if 
	
	// set the events
	$listbox_o.events.push($listboxSetup_o.events)
	
	// package data to display
	$dataPtr:=Get pointer:C304($listbox_o.dataSource)
	$dataPtr->:=ds:C1482[$tableName].all()
	
	
	// parse the text fields
	var $o : Object
	$o:=LBX_DraftColumsFromArrays(vtFieldList; vtLabelList)
	
	
	$page:=New object:C1471("objects"; New object:C1471($lbName_t; $o))
	$form:=New object:C1471("pages"; New collection:C1472(Null:C1517; $page))
	
	Form:C1466.obHarvest:=$form
	// QQQ WHY is this a compiler error
	//OBJECT SET SUBFORM(*; "SF_Draft"; form_o.draft)
End if 