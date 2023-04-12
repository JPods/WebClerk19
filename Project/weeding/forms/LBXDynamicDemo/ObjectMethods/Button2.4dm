

var form_o : cs:C1710.cEditSubForm
form_o:=cs:C1710.cEditSubForm.new("SF_Draft"; "Customer")
form_o.setLBFromCollection(Form:C1466.LB_Fields.sel.extract("fieldName"))

LBX_SelectionIfEmpty(form_o.lbName; form_o.dataClassName)

If (False:C215)  //works
	// initialize the SubForm
	var form_o : cs:C1710.cEditSubForm
	form_o:=cs:C1710.cEditSubForm.new("SF_Draft"; "Customer")
	var $listBox; $form : Object
	var $columns : Collection
	
	// build the columns
	$columns:=form_o.setColumnFields(Form:C1466.LB_Fields.sel.extract("fieldName"))
	
	// build the listbox
	$listBox:=form_o.setListBox($columns)
	//build the form
	$form:=form_o.setBuildLBForm($listBox)
	
	// set the form into the subform object
	form_o.setSubForm($form)
	
	// return a text variable with the form
	jsonText:=form_o.formText
End if 


//var $doSelection : Boolean
//$doSelection:=False
//If (_LB_Customer_=Null)
//$doSelection:=True
//Else 
//If (_LB_Customer_.ents.length=Null)
//$doSelection:=True
//Else 
//If (_LB_Customer_.ents.length=0)
//$doSelection:=True
//End if 
//End if 
//End if 

//If ($doSelection)
//var _LB_Customer_ : Object
//var $ptLB : Pointer
//// get data
//$ptLB:=Get pointer(form_o.lbName)
//$ptLB->:=cs.listboxK.new(form_o.lbName)
//$ptLB->setSource(ds[form_o.dataClassName].all())
//End if 

//$listBox:=form_o.setListBox(Form.LB_Fields.sel.extract("fieldName"))
//$form:=form_o.setBuildLBForm(Form.LB_Fields.sel.extract("fieldName"))
//form_o.setSubForm($form)
//ptLB:=Get pointer(form_o.lbName)
//ptLB->:=cs.listboxK.new()
//ptLB->source:=ds[form_o.dataClassName].all()



If (False:C215)
	var form_o : cs:C1710.cEditSubForm
	form_o:=cs:C1710.cEditSubForm.new("SF_Draft"; "Customer")
	var $c : Collection
	$c:=form_o.setColumnFields(Form:C1466.LB_Fields.sel.extract("fieldName"))
	
	OBJECT GET COORDINATES:C663((OBJECT Get pointer:C1124(Object named:K67:5; "SF_Draft"))->; $left; $top; $right; $bottom)
	$width:=$right-$left
	$height:=$bottom-$top
	
	//"currentItemSource"; ".cur"; \
						"currentItemPositionSource"; "LB_Lines.pos"; \
						"selectedItemsSource"; "LB_Lines.sel"; \
						
	var $obj : Object
	$obj:=New object:C1471("type"; "listbox"; \
		"listboxType"; "collection"; \
		"dataSource"; "eSel1"; \
		"left"; 0; "top"; 0; \
		"width"; $width+15; \
		"height"; $height; \
		"alternateFill"; "#FFFADC"; \
		"singleClickEdit"; True:C214; \
		"metaSource"; "LB_OrderLine.meta"; \
		"events"; New collection:C1472("onLoad"; "onClick"; "onDoubleClick"; "onDrop"; "onDataChange"; "onSelectionChange"; "onBeginDragOver"))
	$obj.columns:=$c
	SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($obj))
	
	
	
	$page:=New object:C1471("objects"; New object:C1471("_LB_"+form_o.dataClassName+"_"; $obj))
	
	$form:=New object:C1471("pages"; New collection:C1472(Null:C1517; $page))
	
	
	form_o.setSubForm(form_o.name; $form)
	jsonText:=form_o.formText
	SET TEXT TO PASTEBOARD:C523(jsonText)
	
End if 