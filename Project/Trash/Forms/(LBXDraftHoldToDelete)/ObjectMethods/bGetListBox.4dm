
// Modified by: Bill James (2022-04-02T05:00:00Z)
// Method: LBXDraftForm.bGetListBox
// Description 
// Parameters
// ----------------------------------------------------


Form:C1466.obHarvest:=subformDraft

If (False:C215)
	
	var purpose_t; role_t : Text
	If (purpose_t="")
		purpose_t:="test"
	End if 
	If (role_t="")
		role_t:="test"
	End if 
	var $listboxHarvest_o : Object
	
	var $lbBasics_o : Object
	
	$namebase:="Order"
	
	var $formWhole_o : Object
	var $formWhole_t; $formPath_t; $structurePath_t; $applicationPath : Text
	$structurePath_t:=Structure file:C489
	$applicationPath:=System folder:C487(Applications or program files:K41:17)
	$formPath_t:=Replace string:C233("Sources/Forms/ListBoxDraft/form.4DForm"; "/"; Folder separator:K24:12)
	$formPath_t:=HFS_GetParent(Structure file:C489)+$formPath_t
	$formWhole_t:=Document to text:C1236($formPath_t)
	
	//$lbBasics_o:=New object("type"; "listbox"; "left"; 23; "top"; 65; \
										"height"; 811; "width"; 574; \
										"events"; New collection("onLoad"; "onClick"; "onDataChange"; "onHeaderClick")\
										"listboxType"; "collection""+""+"\
										"dataSource"; "Form:Form."+$namebase+"_LB"; \
										"currentItemSource"; ; "This:"+$namebase+"Current"; \
										"currentItemPositionSource"; "This:"+$namebase+"Position"; \
										"selectedItemsSource"; "This:"+$namebase+"Selected"; \
										"method"; "ObjectMethods/"+$namebase+".4dm"; \
										"fill"; "automatic""+"\
										"alternateFill"; "#fffacd""+"\
										"columns"; New collection)
	
	
	
	
	
	$listboxHarvest_o:=New object:C1471("listboxName"; "LBDraftTable"; "purpose"; purpose_t; "role"; role_t; "tableName"; tableName; "columns"; New object:C1471)
	$listboxHarvest_o:=LBX_ColumnHarvest($listboxHarvest_o)
	
	
	Form:C1466.obHarvest:=$listboxHarvest_o
End if 