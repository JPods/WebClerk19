
//Form.obHarvest:=subformDraft
ARRAY TEXT:C222($aObject; 0)
ARRAY POINTER:C280($aObjectPointer; 0)
ARRAY LONGINT:C221($aObjectPage; 0)
FORM GET OBJECTS:C898($aObject; $aObjectPointer; $aObjectPage)


Form:C1466.obHarvest:=LBX_HarvestTesting("LB_Selection")

If (False:C215)
	
	Form:C1466.obHarvest:=LB_Draft.pages
	
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
		
		
		
		
		
		$listboxHarvest_o:=New object:C1471("listboxName"; "LB_Draft"; "purpose"; purpose_t; "role"; role_t; "tableName"; tableName; "columns"; New object:C1471)
		$listboxHarvest_o:=LBX_ColumnHarvest($listboxHarvest_o)
		
		
		Form:C1466.obHarvest:=$listboxHarvest_o
	End if 
	
End if 