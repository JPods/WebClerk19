Class constructor($name : Text; $dataClassName : Text)
	This:C1470.name:=$name
	This:C1470.dataClassName:=$dataClassName
	//  one list box in subform
	// use $name so _LB_Selection_ can be use for many tables
	// clip the "SF_"
	This:C1470.lbName:="LB_"+Substring:C12($name; 4)
	This:C1470.window:=Current form window:C827
	
	This:C1470.toBeInitialized:=True:C214
	This:C1470.callback:=Null:C1517
	This:C1470.worker:=Null:C1517
	This:C1470.entry_o:=Null:C1517
	
	This:C1470.isSubform:=True:C214
	
	//This.focused:=Null
	This:C1470.current:=Null:C1517
	
	This:C1470.widgets:=New object:C1471("subform"; New object:C1471(This:C1470.name; Null:C1517; This:C1470.lbName; Null:C1517))
	
	This:C1470.setFieldList()
	
	//If (Count parameters>=4)
	
	//This.setCallBack($method)
	
	//End if 
	
	
	
	//MARK:-  setters and saves
	
Function setColumnsToSaved()
	
Function setLBFromColumns($columns : Collection)
	$listBox:=This:C1470.setListBox($columns)
	//build the form
	$form:=This:C1470.setBuildLBForm($listBox)
	// listbox is redundant as it is also in the subform
	// guess, using a listbox without a subform simplifies communications
	// using listbox with a subform is more dynamic as more can added to query etc....
	This:C1470.widgets.subform[This:C1470.lbName]:=$listBox
	This:C1470.widgets.subform[This:C1470.name]:=$form
	// set the form into the subform object
	This:C1470.setSubForm($form)
	
Function setLBFromCollection($columnFields : Variant)
	// call this for multiple subforms and listboxes on a form
	
	var $listBox; $form : Object
	var $columns : Collection
	// build the columns
	$columns:=This:C1470.setColumnFields($columnFields)
	// build the listbox
	$listBox:=This:C1470.setListBox($columns)
	//build the form
	$form:=This:C1470.setBuildLBForm($listBox)
	
	// listbox is redundant as it is also in the subform
	// guess, using a listbox without a subform simplifies communications
	// using listbox with a subform is more dynamic as more can added to query etc....
	This:C1470.widgets.subform[This:C1470.lbName]:=$listBox
	This:C1470.widgets.subform[This:C1470.name]:=$form
	// set the form into the subform object
	This:C1470.setSubForm($form)
	
Function setFieldList()
	var $class_o : Object
	var $fields_c : Collection
	$fields_c:=New collection:C1472
	var $property : Text
	$class_o:=ds:C1482[This:C1470.dataClassName]  //.getDataStore()
	For each ($property; $class_o)
		$fieldobject:=$class_o[$property]
		// storage to avoid relationships  
		//https://vimeo.com/724419680 at minute 50 to run query on server by adding an extention to the dataClass
		If (($fieldobject.kind="storage") | ($fieldobject.kind="calculated") | ($fieldobject.kind="alias"))
			If (($fieldobject.fieldType#Is BLOB:K8:12) & ($fieldobject.fieldType#Is object:K8:27) & ($fieldobject.fieldType#Is picture:K8:10))
				$fields_c.push($property)
			End if 
		End if 
	End for each 
	This:C1470.fieldList:=$fields_c.orderBy()
	
Function setListBox($columns : Collection)->$listBox : Object
	//var $c : Collection
	// $c:=form_o.setColumnFields($fields)
	
	//get dimensions of the subForm
	
	OBJECT GET COORDINATES:C663((OBJECT Get pointer:C1124(Object named:K67:5; This:C1470.name))->; $left; $top; $right; $bottom)
	$width:=$right-$left
	$height:=$bottom-$top
	$name:=This:C1470.dataClassName
	// this is the layout object. Create a cs.listboxK by the same name to populate the data 
	var $obj : Object
	//$obj:=New object("type"; "listbox"; \
												"listboxType"; "collection"; \
												"dataSource"; This.lbName+".ents"; \
												"currentItemSource"; This.lbName+".cur"; \
												"currentItemPositionSource"; This.lbName+".pos"; \
												"selectedItemsSource"; This.lbName+".sel"; \
												"left"; 0; "top"; 0; \
												"width"; $width+15; \
												"height"; $height; \
												"visibility"; "visible"; \
												"sizingX"; "fixed"; \
												"sizingY"; "fixed"; \
												"alternateFill"; "#FFFAEE"; \
												"singleClickEdit"; False; \
												"method"; "LBX_SelectionActions"; \
												"metaSource"; This.lbName+".meta"; \
												"events"; New collection("onLoad"; "onClick"; "onDoubleClick"; \
												"onDrop"; "onDataChange"; "onSelectionChange"; \"onBeginDragOver"))
	
	$obj:=New object:C1471("type"; "listbox"; \
		"listboxType"; "collection"; \
		"dataSource"; This:C1470.lbName+".ents"; \
		"currentItemSource"; This:C1470.lbName+".cur"; \
		"currentItemPositionSource"; This:C1470.lbName+".pos"; \
		"selectedItemsSource"; This:C1470.lbName+".sel"; \
		"left"; 0; "top"; 0; \
		"width"; $width+15; \
		"height"; $height; \
		"visibility"; "visible"; \
		"sizingX"; "fixed"; \
		"sizingY"; "fixed"; \
		"alternateFill"; "#FFFAEE"; \
		"singleClickEdit"; False:C215; \
		"method"; "LBX_SelectionActions"; \
		"metaSource"; This:C1470.lbName+".meta"; \
		"events"; New collection:C1472("onClick"; \
		"onSelectionChange"; \
		"On Header Click"))
	//"alternateFill": "#FFFAEE", \  pale yellow
	//"alternateFill"; "#FFFADC"; \   yellow
	
	$obj.columns:=$columns
	//SET TEXT TO PASTEBOARD(JSON Stringify($obj))
	$listBox:=New object:C1471(This:C1470.lbName; $obj)
	
	//Function setBuildLBForm($fields : Variant)->$form : Object
	//$listBox:=This.setListBox($fields)
	//$page:=New object("objects"; $listBox)
	
	//$form:=New object("pages"; New collection(Null; $page))
Function setBuildLBForm($listBox : Object)->$form : Object
	$page:=New object:C1471("objects"; $listBox)
	$form:=New object:C1471("pages"; New collection:C1472(Null:C1517; $page))
	
Function setSubForm($form : Object)
	OBJECT SET SUBFORM:C1138(*; This:C1470.name; $form)
	This:C1470.formText:=JSON Stringify:C1217($form; *)
	If (This:C1470.formText#"")
		This:C1470.formText:=Replace string:C233(This:C1470.formText; Char:C90(Tab:K15:37); "    ")
	End if 
	// if jsonText is declared
	If (jsonText#Null:C1517)
		jsonText:=This:C1470.formText
	End if 
	
	//Function setSubForm($form : Variant)
	//var $subFormName : Text
	//$subFormName:=This.name
	//Case of   // HOWTO:Variant
	//: (Value type($form)=Is object)
	//OBJECT SET SUBFORM(*; $subFormName; $form)
	//This.formText:=JSON Stringify($form; *)
	//: (Value type($form)=Is text)
	//OBJECT SET SUBFORM(*; $subFormName; JSON Parse($form))
	//This.formText:=$form
	//End case 
	//If (This.formText#"")
	//This.formText:=Replace string(This.formText; Char(Tab); "    ")
	//End if 
	
	//Function setSubForm($formName : Text; $form : Variant)
	//Case of   // HOWTO:Variant
	//: (Value type($form)=Is object)
	//OBJECT SET SUBFORM(*; $formName; $form)
	//This.formText:=JSON Stringify($form; *)
	//: (Value type($form)=Is text)
	//OBJECT SET SUBFORM(*; $formName; JSON Parse($form))
	//End case 
	//If (This.formText#"")
	//This.formText:=Replace string(This.formText; Char(Tab); "    ")
	//End if 
	
	
	
Function setFieldPopUp($fieldList : Text)
	//Databrowser_SetFieldPopup
	// TESTTHIS
	//$table:=This.dataClassName
	//ARRAY TEXT($fieldlist; 0)
	//APPEND TO ARRAY($fieldlist; "All index fields")
	//APPEND TO ARRAY($fieldlist; "-")
	//For each ($field; $table)
	//$fieldobject:=$table[$field]
	//// storage to avoid relationships  
	////https://vimeo.com/724419680 at minute 50 to run query on server by adding an extention to the dataClass
	//If (($fieldobject.kind="storage") | ($fieldobject.kind="calculated") | ($fieldobject.kind="alias"))
	//If (($fieldobject.fieldType#Is BLOB) & ($fieldobject.fieldType#Is object) & ($fieldobject.fieldType#Is picture))
	//APPEND TO ARRAY($fieldlist; $field)
	//End if 
	//End if 
	//End for each 
	//$ptr:=OBJECT Get pointer(Object named; $fieldList)
	//COPY ARRAY($fieldlist; $ptr->)
	//$ptr->:=1
	
Function set text() : Text
	return (This:C1470.formText)
	
Function setformType($kind : Text)
	If ($type#"")
		This:C1470.kind:=$type
	End if 
	
Function setComment($type : Text)->$demoSpanText : Text
	Case of 
		: ($type="selection")
			If (Folder separator:K24:12=":")
				$demoSpanText:="<span style=\"font-family:'Lucida Grande'\"><span style=\"font-size:16pt\">"+\
					"<span style=\"font-weight:bold\"> Selection Based 1</span><br/></span><br/>"+\
					"<span style=\"font-weight:bold\"> Description: </span><br/> "+\
					"Querying a table that display three fields.<br/><"+"br/><span style=\"font-weight:bold\"> "+\
					"Table:</span> <br/> Customer<br/><br/><span style=\"font-weight:bold\"> Fields: </span>"+\
					"<br/> id, nameFirst, &amp; nameLast<br/><br/><span style=\"font-weight:bold\"> "+\
					"Usage:</span><br/> Input:<br/> $1(LONGINT) - Listbox "+"ty"+"pe<br/> $2(POINTER) -"+\
					" Datasource<br/> $3(POINTER) - Number of columns<br/><br/><br/><br/><br/><br/><br/>"+\
					"<span style=\"font-weight:bold\"> Sample:<br/>  <span style=\"font-family:'Courier New';"+\
					"font-size:14pt;font-weight:normal\"><span style=\"color:#068C00;"+"font-weight:bold\">"+\
					"C_LONGINT</span>(<span style=\"color:#0031FF\">$nCol</span>)<br/> "+\
					"<span style=\"color:#0031FF\">$nCol</span>:=3 // 3 Columns</span><br/></span>"+\
					"<span style=\"font-family:'Courier New';font-size:11pt\"><span style=\"color:#000088;font-style:"+\
					"i"+"talic;font-weight:bold\"> <span style=\"font-size:14pt\">LBX_DemoDynamic_02</span></span>"+\
					"<span style=\"font-size:14pt\"> (1;-&gt;<span style=\"color:#532300\">[Customer]</span>;-&gt;"+\
					"<span style=\"color:#0031FF\">$nCol</span>)</span></span></span>"
			Else 
				$demoSpanText:="<span><span style=\"font-size:12pt;font-weight:bold\"><span style=\"font-size:9pt;font-weight:normal\"><span style=\"font-size:12pt;font-weight:bold\"> Selection Based 1</span><br/><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Querying a t"+"able that display three fields.<br/><br/><span style=\"font-weight:bold\"> Table:</span> <br/>  Customer<br/><br/><span style=\"font-weight:bold\"> Fields: </span><br/>  id, nameFirst, &amp; nameLast<br/><br/><span style=\"font-weight:bold\"> Usage:</span><"+"br"+"/"+">  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/></span><br/></span><br/><br/><br/><br/><br/><br/><span style=\"font-weight:bold\"> Sample:<br/><span style=\"font-family:'Courier New';fon"+"t-weight:normal\"><span style=\"color:#00B050;font-weight:bold\"> <span style=\"font-size:10.5pt;color:#000000;font-weight:normal\"><span style=\"color:#068C00;font-weight:bold\">C_LONGINT</span>(<span style=\"color:#0031FF\">$nCol</span>)</span></span><span s"+"tyle=\"font-size:10.5pt\"><br/> <span style=\"color:#0031FF\">$nCol</span>:=3 // 3 Columns<br/></span></span></span><span style=\"font-family:'Courier New';font-size:10.5pt\"><span style=\"color:#000088;font-style:italic;font-weight:bold\"> generateListboxFor"+"mJSONDef</span> (1;-&gt;<span style=\"color:#532300\">[Customer]</span>;-&gt;<span style=\"color:#0031FF\">$nCol</span>)</span></span>"
			End if 
		: ($type="array")
			If (Folder separator:K24:12=":")
				$demoSpanText:="<span style=\"font-family:'Lucida Grande'\"><span style=\"font-size:16pt;font-weight:bold\"> Array Based</span><br/><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Display two arrays.<br/><br/><span style=\"font-weight:bold\"> Array:</span> "+"<br/>  PDDL &amp; PDDL1<br/><br/><br/><span style=\"font-weight:bold\"> Usage:</span><br/>  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/><br/><br/><br/><br/><br/><br/><br/><span style=\""+"font-weight:bold\"> Sample:<br/><span style=\"font-family:'Courier New';font-size:14pt;font-weight:normal\"><span style=\"color:#068C00;font-weight:bold\"> ARRAY TEXT</span>(<span style=\"color:#0000FF\">arrNames</span>;0)<br/><span style=\"color:#068C00;font"+"-weight:bold\"><span style=\"color:#000000;font-weight:normal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">arrNames</span>;\"PDDL\")<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"color:#000000;font-weight:normal\"> </span>APP"+"END TO ARRAY</span>(<span style=\"color:#0000FF\">arrNames</span>;\"PDDL1\")<br/><span style=\"color:#000088;font-style:italic;font-weight:bold\"> LBX_DemoDynamic_02</span> (2;-&gt;<span style=\"color:#0000FF\">arrNames</span>)</span></span></span>"
			Else 
				$demoSpanText:="<span><span style=\"font-size:12pt;font-weight:bold\">Array Based</span><br/><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Display two arrays.<br/><br/><span style=\"font-weight:bold\"> Array:</span> <br/>  PDDL &amp; PDDL1<br/><br/><br/"+"><span style=\"font-weight:bold\"> Usage:</span><br/>  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/><br/><br/><br/><br/><br/><br/><br/><br/><span style=\"font-weight:bold\"> Sample:</span"+"><br/><span style=\"font-family:'Courier New';font-size:11pt;color:#000088;font-style:italic;font-weight:bold\"> <span style=\"font-size:10.5pt;color:#000000;font-style:normal;font-weight:normal\"><span style=\"color:#068C00;font-weight:bold\">ARRAY TEXT</s"+"pan>(<span style=\"color:#0000FF\">arrNames</span>;0)<br/> <span style=\"color:#068C00;font-weight:bold\">APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">arrNames</span>;\"PDDL\")<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"color:#00000"+"0;font-weight:normal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">arrNames</span>;\"PDDL1\")<br/><span style=\"color:#000088;font-style:italic;font-weight:bold\"> LBX_DemoDynamic_02</span> (2;-&gt;<span style=\"color:#0000FF\">arrName"+"s</span>)</span></span></span>"
			End if 
		: ($type="collection")
			If (Folder separator:K24:12=":")
				$demoSpanText:="<span style=\"font-family:'Lucida Grande'\"><span style=\"font-size:16pt\"><span style=\"font-weight:bold\"> Collection Based</span><br/></span><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Display a collection.<br/><br/><span style=\"font-"+"weight:bold\"> Collection:</span> <br/>  colLB1<br/><br/><span style=\"font-weight:bold\"> Usage:</span><br/>  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/><br/><span style=\"font-weight:"+"bold\"> Sample:<br/><span style=\"font-family:'Courier New';font-size:11pt;font-weight:normal\"><span style=\"font-size:9pt\"><span style=\"font-size:14pt;color:#068C00;font-weight:bold\"> <span style=\"font-size:12pt\">C_COLLECTION</span></span><span style=\"f"+"ont-size:12pt\">(<span style=\"color:#0000FF\">colLB1</span>)<br/><span style=\"color:#068C00;font-weight:bold\"> ARRAY TEXT</span>(<span style=\"color:#0000FF\">colNames0</span>;0)<br/><span style=\"color:#068C00;font-weight:bold\"> CLEAR VARIABLE</span>(<spa"+"n style=\"color:#0000FF\">colNames0</span>)<br/><span style=\"color:#068C00;font-weight:bold\"> APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames0</span>;\"This.fname\")<br/><span style=\"color:#068C00;font-weight:bold\"> APPEND TO ARRAY</span>(<spa"+"n style=\"color:#0000FF\">colNames0</span>;\"This.lname\")<br/><span style=\"color:#068C00;font-weight:bold\"> APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames0</span>;\"This.age\") </span></span><span style=\"font-size:12pt\"><br/></span></span></sp"+"an><span style=\"font-family:'Courier New';font-size:12pt\"> <br/><span style=\"color:#0000FF\"> colLB1</span>:=<span style=\"color:#068C00;font-weight:bold\">New collection</span>(<span style=\"color:#068C00;font-weight:bold\">New object</span>(\"fname\";\"Bob\""+"; \\<br/> \"lname\";\"James\";\"age\";39);<span style=\"color:#068C00;font-weight:bold\">New object</span>(\"fname\";\"Vinn\";\\<br/> \"lname\";\"Michaels\";\"age\";38))<br/><br/><span style=\"color:#000088;font-style:italic;font-weight:bold\"> LBX_DemoDynamic_02</"+"span> (3;-&gt;<span style=\"color:#0000FF\">colLB1;-&gt;colNames0</span>)</span></span>"
			Else 
				$demoSpanText:="<span><span style=\"font-size:12pt;font-weight:bold\"> Collection Based</span><br/><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Display a collection.<br/><br/><span style=\"font-weight:bold\"> Collection:</span> <br/>  colLB1<br/><br/><"+"span style=\"font-weight:bold\"> Usage:</span><br/>  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/><br/><span style=\"font-weight:bold\"> Sample:<br/><span style=\"font-family:'Courier New'"+";font-size:11pt;font-weight:normal\"><span style=\"font-size:9pt\"><span style=\"color:#068C00;font-weight:bold\"> C_COLLECTION</span>(<span style=\"color:#0000FF\">colLB1</span>)<br/><span style=\"color:#068C00;font-weight:bold\"> ARRAY TEXT</span>(<span styl"+"e=\"color:#0000FF\">colNames0</span>;0)<br/><span style=\"color:#068C00;font-weight:bold\"> CLEAR VARIABLE</span>(<span style=\"color:#0000FF\">colNames0</span>)<br/><span style=\"color:#068C00;font-weight:bold\"> APPEND TO ARRAY</span>(<span style=\"color:#00"+"00FF\">colNames0</span>;\"This.fname\")<br/><span style=\"color:#068C00;font-weight:bold\"> APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames0</span>;\"This.lname\")<br/><span style=\"color:#068C00;font-weight:bold\"> APPEND TO ARRAY</span>(<span sty"+"le=\"color:#0000FF\">colNames0</span>;\"This.age\") </span><br/></span></span><span style=\"font-family:'Courier New';font-size:11pt\"> <br/><span style=\"font-size:9pt\"><span style=\"color:#0000FF\"> colLB1</span>:=<span style=\"color:#068C00;font-weight:bold\""+">New collection</span>(<span style=\"color:#068C00;font-weight:bold\">New object</span>(\"fname\";\"Bob\"; \\<br/> \"lname\";\"James\";\"age\";39);<span style=\"color:#068C00;font-weight:bold\">New object</span>(\"fname\";\"Vinn\";\\<br/> \"lname\";\"Michaels\";\"age\";38))</s"+"pan><br/><br/><span style=\"color:#000088;font-style:italic;font-weight:bold\"> <span style=\"font-size:9pt\">LBX_DemoDynamic_02</span></span><span style=\"font-size:9pt\"> (3;-&gt;<span style=\"color:#0000FF\">colLB1;-&gt;colNames0</span>)</span></sp"+"an></span>"
			End if 
		: ($type="entity")
			If (Folder separator:K24:12=":")
				$demoSpanText:="<span style=\"font-family:'Lucida Grande'\"><span style=\"font-size:16pt;font-weight:bold\"> Entity Selection Based 2</span><br/><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Using ORDA to display records with Entity Selection.<br/><br/>"+"<span style=\"font-weight:bold\"> Object:</span> <br/>  eSel1<br/><br/><span style=\"font-weight:bold\"> Usage:</span><br/>  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/><br/><br/><br/><s"+"pan style=\"font-weight:bold\"> Sample:<br/><span style=\"font-family:'Courier New';font-weight:normal\"><span style=\"color:#068C00;font-weight:bold\"> <span style=\"font-size:14pt\">C_OBJECT</span></span><span style=\"font-size:14pt\">(<span style=\"color:#000"+"0FF\">eSel1</span>)<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:normal\"> </span>ARRAY TEXT</span>(<span style=\"color:#0000FF\">colNames2</span>;0)<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:no"+"rmal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames2</span>;\"This.ID\")<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:normal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames2</span>;"+"\"This.nameFirst\")<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:normal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames2</span>;\"This.nameLast\")<br/><br/><span style=\"color:#0000FF\"> eSel1</span>:=<span "+"style=\"color:#068C00;font-weight:bold\">ds</span><span style=\"color:#532300\">.Customer</span>.<span style=\"color:#5F8E5E;font-style:italic\">all</span>()<br/><span style=\"color:#000088;font-style:italic;font-weight:bold\"><span style=\"font-weight:normal\""+"> "+"</span>LBX_DemoDynamic_02</span> (4;-&gt;<span style=\"color:#0000FF\">eSel1</span>;-&gt;<span style=\"color:#0000FF\">colNames2</span>)</span></span></span></span>"
			Else 
				$demoSpanText:="<span><span style=\"font-size:12pt;font-weight:bold\"> Entity Selection Based 2</span><br/><br/><span style=\"font-weight:bold\"> Description: </span><br/>  Using ORDA to display records with Entity Selection.<br/><br/><span style=\"font-weight:bold\"> Obje"+"ct:</span> <br/>  eSel1<br/><br/><span style=\"font-weight:bold\"> Usage:</span><br/>  Input:<br/>  $1(LONGINT) - Listbox type<br/>  $2(POINTER) - Datasource<br/>  $3(POINTER) - Number of columns<br/><br/><br/><br/><br/><br/><span style=\"font-weight:bol"+"d\"> Sample:<br/><span style=\"font-family:'Courier New';font-weight:normal\"><span style=\"color:#068C00;font-weight:bold\"> <span style=\"font-size:10.5pt\">C_OBJECT</span></span><span style=\"font-size:10.5pt\">(<span style=\"color:#0000FF\">eSel1</span>)<br/"+"><span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:normal\"> </span>ARRAY TEXT</span>(<span style=\"color:#0000FF\">colNames2</span>;0)<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:normal\"> </span>APPEND T"+"O ARRAY</span>(<span style=\"color:#0000FF\">colNames2</span>;\"This.ID\")<br/><span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:normal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames2</span>;\"This.nameFirst\")<br/>"+"<span style=\"color:#068C00;font-weight:bold\"><span style=\"font-weight:normal\"> </span>APPEND TO ARRAY</span>(<span style=\"color:#0000FF\">colNames2</span>;\"This.nameLast\")<br/><br/><span style=\"color:#0000FF\"> eSel1</span>:=<span style=\"color:#068C00;f"+"ont-weight:bold\">ds</span><span style=\"color:#532300\">.Customer</span>.<span style=\"color:#5F8E5E;font-style:italic\">all</span>()<br/><span style=\"color:#000088;font-style:italic;font-weight:bold\"><span style=\"font-weight:normal\"> </span>generateListb"+"ox"+"FormJSONDef</span> (4;-&gt;<span style=\"color:#0000FF\">eSel1</span>;-&gt;<span style=\"color:#0000FF\">colNames2</span>)</span></span></span></span>"
			End if 
	End case 
	$demoSpanText:=Replace string:C233($demoSpanText; "\\\""; "\"")
	var $oneColumn : Object
	
	
Function setColumnFields($columnFields : Collection)->$columns_c : Collection
	var $c; $columns_c; $fieldNames_c : Collection
	var $property : Text
	$columns_c:=New collection:C1472
	
	For each ($property; $columnFields)
		$oneColumn:=LBX_ColumnFromName(This:C1470.dataClassName; $property)
		If ($oneColumn#Null:C1517)
			$columns_c.push($oneColumn)
		End if 
	End for each 
	
	
	
	
Function getTMFieldList($user : Text; $role : Text)->$fieldList : Collection
	// make a list of available field Add to task list
	// MustFixQQQZZZ: Bill James (2022-07-08T05:00:00Z)
	If ($user="")
		$user:="defaultUser"
	End if 
	If ($role="")
		$role:="defaultRole"
	End if 
	var $rec : Object
	$rec:=ds:C1482.TallyMaster.query("name = :1 and purpose = :2"; $user; "FieldsAllowed")
	If ($rec.length=0)
		$rec:=ds:C1482.TallyMaster.query("role = :1 and purpose = :2"; $user; "FieldsAllowed")
	End if 
	If ($rec.length>0)
		
	End if 
	var $table : Object
	$table:=ds:C1482[This:C1470.dataClassName].getDataClass()
	For each ($field; $table)
		$fieldobject:=$table[$field]
		// storage to avoid relationships  
		//https://vimeo.com/724419680 at minute 50 to run query on server by adding an extention to the dataClass
		If (($fieldobject.kind="storage") | ($fieldobject.kind="calculated") | ($fieldobject.kind="alias"))
			If (($fieldobject.fieldType#Is BLOB:K8:12) & ($fieldobject.fieldType#Is object:K8:27) & ($fieldobject.fieldType#Is picture:K8:10))
				APPEND TO ARRAY:C911($fieldlist; $field)
			End if 
		End if 
	End for each 
	//$ptr:=OBJECT Get pointer(Object named; "fieldlist")
	//COPY ARRAY($fieldlist; $ptr->)
	//$ptr->:=1
	
	
	// Function setWidth
	
	
	//MARK:-  getters and create
Function get formType->$type : Text
	$type:=This:C1470.formType
	
	
Function getPosition
	var $left; $top; $right; $bottom; $width; $height : Integer
	OBJECT GET COORDINATES:C663((OBJECT Get pointer:C1124(Object named:K67:5; $name))->; $left; $top; $right; $bottom)
	$width:=$right-$left
	$height:=$bottom-$top
	This:C1470.position:=New object:C1471("left"; $left; "top"; $top; "right"; $right; "bottom"; $bottom; "width"; $width; "height"; $height)
	
	
	//MARK:-  calcs
	
	
	
	//MARK:-[WIDGETS]   
	//=== === === === === === === === === === === === === === === === === === === === === 
	// look at class "form" for more on this
	// Set window title
Function setTitle($title : Text)
	
	SET WINDOW TITLE:C213($title; This:C1470.window)
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Defines the name of the callback method
Function setCallBack($method : Text)
	
	This:C1470.callback:=$method
	
Function setSource($source : Object)
	
	This:C1470.source:=$source
	If (This:C1470.source.length>0)
		This:C1470.ents:=This:C1470.source
		This:C1470.cur:=This:C1470.source[0]
		This:C1470.sel:=This:C1470.source[0]
		This:C1470.pos:=1
		This:C1470.length:=This:C1470.source.length
		This:C1470.entry_o:=This:C1470.source[0].toObject()
	End if 
	
Function setTimer($delay : Integer)
	
	If (Count parameters:C259>=1)
		
		SET TIMER:C645($delay)
		
	Else 
		
		SET TIMER:C645(-1)
		
	End if 
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Gives the focus to a widget in the current form
Function goTo($widget : Text)
	
	// TODO: allow a cs.widget
	
	GOTO OBJECT:C206(*; $widget)
	
	
	
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Associate a worker to the current form
Function setWorker($worker)
	
	var $type : Integer
	$type:=Value type:C1509($worker)
	
	If (Asserted:C1132(($type=Is text:K8:3) | ($type=Is real:K8:4) | ($type=Is longint:K8:6); "Wrong parameter type"))
		
		This:C1470.worker:=$worker
		
	End if 
	
	
	
	
	//MARK:-[CURSOR]
	//=== === === === === === === === === === === === === === === === === === === === === 
Function setCursor($cursor : Integer)
	
	If (Count parameters:C259>=1)
		
		SET CURSOR:C469($cursor)
		
	Else 
		
		SET CURSOR:C469
		
	End if 
	
	
	
	//MARK:- admin
Function redraw()
	This:C1470.ents:=This:C1470.ents
	
Function reset()
	This:C1470.ents:=This:C1470.source
	