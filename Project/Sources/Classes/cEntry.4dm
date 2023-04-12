
// Modified by: Bill James (2022-04-21T05:00:00Z)
// Method: cEntry
// Description 
// Parameters
// ----------------------------------------------------
//Class constructor($dataClassName : Text; $formName : Text; $sfName : Text)
Class constructor($dataClassName : Text; $formName : Text; $sfName : Text; $ref : Object)
	// cEntry constructor
	// basics
	If (Count parameters:C259=0)
		$dataClassName:=process_o.dataClassName
		$formName:=process_o.dialog
		$sfName:=Current form name:C1298
	End if 
	This:C1470.dataClassName:=$dataClassName
	This:C1470.dataClass:=ds:C1482[This:C1470.dataClassName]
	This:C1470.dataClassPtr:=Table:C252(This:C1470.dataClass.getInfo().tableNumber)
	This:C1470.entry_o:=Null:C1517
	This:C1470.objectsNames:=New collection:C1472("")
	This:C1470.related:=New collection:C1472
	This:C1470.qryPropertyList:=New collection:C1472
	
	//form
	This:C1470.popups:=New collection:C1472
	This:C1470.formName:=Current form name:C1298
	
	// set view
	This:C1470.name:=$sfName
	If ($ref.view#Null:C1517)
		This:C1470.view:=$ref.view
	Else 
		This:C1470.view:="default"
	End if 
	This:C1470.role:=""
	This:C1470.securityLevel:=1
	
	var $input_o : Object
	$input_o:=New object:C1471(\
		"purpose"; "setup"; \
		"dataClassName"; This:C1470.dataClassName; \
		"name"; This:C1470.name; \
		"role"; Storage:C1525.user.role)
	
	This:C1470.fc:=STR_FCGet($input_o)
	
	
	
	var $o : Object
	//set data
	
	
	
	
	//MARK:-  display
	
	
	//MARK:-  save
	
Function saveEntity()->$failed : Boolean
	//$failed:=False
	//var $rec_e : Object
	//If (Value type(This.cur)=Is object)
	//$rec_e:=ds[This.dataClassName].query("id = :1"; This.cur.id).firs()
	//// add a check to see if anything has changed
	//$rec_e.fromObject(This.cur)
	//Else 
	//$rec_e:=This.cur
	//End if 
	If (This:C1470.cur.touched())
		// add logic to manage objects as well as entities
		$result:=$rec_e.save(dk auto merge:K85:24)
		
		var $tc_ent : Object
		$tc_ent:=ds:C1482.TallyChange.query("idParent = :1"; entry_o.id).first()
		If ($tc_ent#Null:C1517)
			$tc_ent.count:=$tc_ent.count+1
			If ($tc_ent.obHistory=Null:C1517)
				$tc_ent.obHistory:=New object:C1471()
				$tc_ent.obHistory[String:C10($tc_ent.count)]:=This:C1470
				$tc_ent.save()
			End if 
		End if 
		
		// HOWTO:Save  https://developer.4d.com/docs/API/EntityClass/#save
		If (Not:C34($result.success))
			$failed:=True:C214
			ALERT:C41("Record not saved modified by "+$result.lockInfo.user_name+\
				";\r Process: "+$result.lockInfo.task_name)
		End if 
	End if 
	
	
	//MARK:-  build
	
Function _setSpacing()
	// only do this when creating the entry form
	This:C1470._setSpacing()
	
	
Function _buildFromLayout()
	subform_o:=This:C1470.data.views[This:C1470.view].layout
	OBJECT SET SUBFORM:C1138(*; This:C1470.name; subform_o)
	
Function _buildFromString()
	$page:=New object:C1471
	var $c : Collection
	var $fields_c : Collection
	$c:=New collection:C1472
	$fields_c:=New collection:C1472
	If (Position:C15(","; This:C1470.fc.data.views[This:C1470.view].fields)>0)
		$fields_c:=Split string:C1554(This:C1470.fc.data.views[This:C1470.view].fields; ",")
	Else 
		$fields_c:=Split string:C1554(This:C1470.fc.data.views[This:C1470.view].fields; ";")
	End if 
	
	// should delete this. Set it elsewhere
	//If (This.cur=Null)
	//This.cur:=LB_DataBrowser.cur
	//End if 
	
	This:C1470.spacing.offSet:=0
	For each ($field; $fields_c)
		This:C1470.setLineEntry($field; $page)
	End for each 
	This:C1470.spacing.offSet:=0
	
	
	//$sf_o.windowTitle:="window title"
	//$sf_o.destination:="detailScreen"
	
	// azxLearning by: Bill James (2023-04-04T05:00:00Z)
	// creating a subform object
	var subform_o : Object
	subform_o:=New object:C1471("pages"; New collection:C1472(Null:C1517; New object:C1471("objects"; $page)))
	subform_o.windowSizingX:="variable"
	subform_o.windowSizingY:="variable"
	subform_o.windowMinWidth:=0
	subform_o.windowMinHeight:=0
	subform_o.windowMaxWidth:=32767
	subform_o.windowMaxHeight:=32767
	subform_o.rightMargin:=20
	subform_o.bottomMargin:=20
	
	subform_o.events:=New collection:C1472
	subform_o.events.push("onClick")
	subform_o.events.push("onDoubleClick")
	subform_o.events.push("onOutsideCall")
	subform_o.events.push("onBeginDragOver")
	subform_o.events.push("onDragOver")
	subform_o.events.push("onDrop")
	subform_o.events.push("onTimer")
	subform_o.events.push("onBoundVariableChange")
	
	subform_o.method:="Entry_FromMethod.4dm"
	
	If (This:C1470.fc=Null:C1517)
		SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217(subform_o))
	End if 
	If (This:C1470.fc.data.views[This:C1470.view].layout.pages=Null:C1517)
		This:C1470.fc.data.views[This:C1470.view].layout:=subform_o
		This:C1470.fc.save()
	End if 
	
	OBJECT SET SUBFORM:C1138(*; This:C1470.name; subform_o)
	
Function _buildListFromString()
	Form:C1466.LB_Fields.setFields()
	Form:C1466.LB_Show.setFields(New collection:C1472)
	var $line_o : Object
	var $index : Integer
	$c:=New collection:C1472
	This:C1470.fc.data.views[This:C1470.view].fields:=Replace string:C233(This:C1470.fc.data.views[This:C1470.view].fields; ","; ";")
	$c:=Split string:C1554(This:C1470.fc.data.views[This:C1470.view].fields; ";")
	For each ($field; $c)
		// HOWTO:index, HOWTO:findIndex
		$index:=Form:C1466.LB_Fields.ents.findIndex("findInCollection"; "fieldName"; $field)
		If ($index>=0)
			$line_o:=Form:C1466.LB_Fields.ents[$index]
			Form:C1466.LB_Show.ents:=Form:C1466.LB_Show.ents.insert(Form:C1466.LB_Show.pos; $line_o)
			Form:C1466.LB_Show.pos:=Form:C1466.LB_Show.pos+1
		End if 
	End for each 
	
Function _buildEntryFromList()
	If (Form:C1466.LB_Show.ents.length=0)
		ALERT:C41("There are no fields in the top list.")
	Else 
		This:C1470.fc.data.views[This:C1470.view].fields:=""
		var $line_o : Object
		var $c : Collection
		$c:=New collection:C1472
		For each ($line_o; Form:C1466.LB_Show.ents)
			$c.push($line_o.fieldName)
		End for each 
		This:C1470.fc.data.views[This:C1470.view].fields:=$c.join(";")
		
		This:C1470._buildFromString()  // space between fields
	End if 
	
	
	
	//MARK:-  setters
	
	
	
Function _setSource($cur_o : Object)  // setData
	//If ($cur_o=Null)
	//$cur_o:=process_o.cur
	//End if 
	If (process_o.cur#Null:C1517)
		This:C1470.saveEntity()
		This:C1470.cur:=process_o.cur
		//This.entry_e:=LB_DataBrowser.cur
		// use the object if it is required to separate clicking on a list that 
		// changes LB_DataBrowser.cur when actions are still required on the data
		//This.entry_o:=LB_DataBrowser.cur.toObject()
	End if 
	
	
Function _setOffset()
	This:C1470.spacing.offSet:=0
	
Function _setSpacing($spacing_o : Object)
	Case of 
		: ($spacing_o#Null:C1517)
			This:C1470.spacing:=$spacing_o
		: (Not:C34(Undefined:C82(This:C1470.data.views[This:C1470.view].spacing.dataStub)))
			This:C1470.spacing:=This:C1470.data.views[This:C1470.view].spacing
			// spacing can be defined with the view
	End case 
	If (Undefined:C82(This:C1470.spacing.offSet))
		This:C1470.spacing:=New object:C1471(\
			"dataStub"; "SF_cur.cur."; \
			"offSet"; 0; \
			"top"; 10; \
			"bottom"; 5; \
			"label"; New object:C1471(\
			"left"; 10; \
			"width"; 120; \
			"height"; 16); \
			"field"; New object:C1471(\
			"left"; 130; \
			"width"; 235; \
			"height"; New object:C1471(\
			"most"; 16; \
			"text"; 95; \
			"picture"; 95; \
			"object"; 95)); \
			"tools"; New object:C1471(\
			"left"; 130+235+10; \
			"height"; 16; \
			"width"; 90))
	End if 
	
Function setDefaults($options_o : Object)->$results : Object
	////This.fields:=This.fc.views[].fields
	
	//// Fix_QQQ by: Bill James (2022-12-15T06:00:00Z)
	//// need to have options. this does nothing or should be deleted
	//If (Count parameters=0)
	//$options_o:=New object
	//End if 
	//If (This.spacing.top=Null)
	//This.spacing.top:=10
	//End if 
	//If ($options_o.fields#Null)
	//This.fc.fields:=$options_o.entry.fields
	//End if 
	//If (This.fields="")
	//This.fields:=Form.entry.fields
	//End if 
	//If (This.fields="")
	//This.getFCFieldList()
	//End if 
	
/* add a similar option for a setting from an object 
so we can control individual fields 
	
or pass in the entire form
*/
	
Function _setSubForm($options_o : Object)
	
	If (This:C1470.data.views[This:C1470.view].layout#Null:C1517)
		// get rid of subform_o
		This:C1470._buildFromLayout()
	Else 
		This:C1470._buildFromString()
		
	End if 
	
Function setLineEntry($field : Text; $page : Object)
	$fieldobject:=This:C1470.dataClass[$field]
	If ($fieldobject#Null:C1517)
		If ($fieldobject.kind="storage")
			If ($fieldobject.fieldType#Is BLOB:K8:12)
				var $line_o : Object
				var $lineHeight; $lineTop; $lineBottom : Integer
				
/*look to find if this field has:
# is locked
## set style to italic
## lock the field
				
# a popup, if yes
## name the popup
## populate it
## build it over the top of the lable
## set the color the lable to  000099
## lock the field
## put behavior in the entry_o class
				
# a button, if yes
## name the button
## set text color to 009900
## put behavior in the entry_o class
*/
				$lineHeight:=This:C1470.spacing.label.height  // set a default
				// change for text, objects, and pictures
				This:C1470.spacing.offSet:=This:C1470.spacing.offSet+This:C1470.spacing.top
				$lineTop:=This:C1470.spacing.offSet
				// label on the left
				$formobject:=New object:C1471
				$formobject.text:=$field
				$formobject.type:="text"
				$formobject.left:=This:C1470.spacing.label.left
				$formobject.top:=$lineTop  // cumulative
				$formobject.width:=This:C1470.spacing.label.width  // 120
				$formobject.height:=This:C1470.spacing.label.height  // 16
				
				
				
				// label to page
				$page[$field]:=$formobject
				
				//$formobject.dataSource:="LB_DataBrowser.cur."+$field
				// different dataSource for images. Need to setByPath
				//$formobject.dataSource:="Form.cur."+$field
				// from eEntry: does not update the subform
				//     here:  $formobject.dataSource:="entry_e."+$field  //LB_DataBrowser.cur
				//     listbox: entity_e:=
				
				var $doSplitter : Boolean
				$doSplitter:=False:C215
				
				// entry in the middle
				$formobject:=New object:C1471
				$formobject.type:="input"
				$formobject.dataSource:=This:C1470.spacing.dataStub+$field  //LB_DataBrowser.cur
				$formobject.left:=This:C1470.spacing.field.left
				$formobject.top:=$lineTop  // cumulative
				$formobject.width:=This:C1470.spacing.field.width  // 235
				$formobject.sizingX:="grow"
				If (($fieldobject.fieldType#Is text:K8:3) & ($fieldobject.fieldType#Is picture:K8:10) & ($fieldobject.fieldType#Is object:K8:27))
					// set single line entry objects
					$formobject.height:=This:C1470.spacing.field.height.most  // 16
					$lineHeight:=$formobject.height
				Else 
					$doSplitter:=True:C214
					If ($fieldobject.fieldType=Is picture:K8:10)
						//$formobject.dataSource:="LB_DataBrowser.cur"+$field
						// convert path to image
						$formobject.dataSourceTypeHint:="picture"
					End if 
					$formobject.height:=This:C1470.spacing.field.height.picture
					$lineHeight:=$formobject.height
					$formobject.sizingY:="grow"
				End if 
				$page[$field+"_entry"]:=$formobject
				// add splitter
				
				If ($doSplitter)
					
					$page["_"]:=$formobject
					
					
					// build the entry field
					$formobject:=New object:C1471
					$formobject.type:="splitter"
					// add a mechanism to get pictures from paths. 
					// name all fields path that point to images, etc...
					//var $picture_p:picture
					$formobject.dataSource:="LB_DataBrowser.cur"+$field
					//$formobject.dataSource:="Form.entity."+$field  //LB_DataBrowser.cur
					$formobject.left:=1
					$formobject.top:=$lineTop+$lineHeight+6
					$formobject.width:=This:C1470.spacing.field.width\
						+This:C1470.spacing.label.width\
						+This:C1470.spacing.tools.width  //
					$formobject.sizingX:="grow"
					$formobject.height:=5
					$lineHeight:=$lineHeight+10
					$page[$field+"_splitter"]:=$formobject
				End if 
				If (($field="phone@") | ($field="email@") | ($field="address1"))
					$formobject:=New object:C1471
					$formobject.type:="dropdown"
					$formobject.dataSource:="a"+$field
					$formobject.left:=This:C1470.spacing.tools.left
					$formobject.top:=$lineTop  // cumulative
					$formobject.width:=This:C1470.spacing.tools.width  // 235
					$formobject.height:=This:C1470.spacing.tools.height  // 16
					$formobject.sizingX:="move"
					$formobject.method:="DataBrower_Actions"
					$formobject.events:=New collection:C1472("onClick")
					var $ptVar : Pointer
					$ptVar:=Get pointer:C304($formobject.dataSource)
					var $c : Collection
					var $list_t : Text
					Case of 
						: (This:C1470.fc.data.views[This:C1470.view].actions.list#Null:C1517)
							$list_t:="testing,trial,idea"
							$list_t:=This:C1470.fc.data.views[This:C1470.view].actions.list
							
						: ($field="phone@")
							$list_t:="dial,SMS,copy"
						: ($field="email@")
							$list_t:="launch,copy"
						: ($field="address1")
							$list_t:="map,copy"
					End case 
					ARRAY TEXT:C222($ptVar->; 0)
					COLLECTION TO ARRAY:C1562(Split string:C1554($list_t; ","); $ptVar->)
					INSERT IN ARRAY:C227($ptVar->; 1; 1)
					$ptVar->{1}:=$field+" choices"
					$ptVar->:=1
					$page[$field+"_tool"]:=$formobject
				End if 
				This:C1470.spacing.offSet:=This:C1470.spacing.offSet+$lineHeight
			End if 
		End if 
	End if 
	
	
Function _setData()
	entry_e:=entry_e
	entry_e:=LB_DataBrowser.cur
	This:C1470.cur:=LB_DataBrowser.cur
	This:C1470.entry_e:=LB_DataBrowser.cur
	
	
	
	//MARK:-  related
Function initRelated($listMore : Text)
	// setup the structure. Fill as needed
	Case of 
		: (This:C1470.dataClassName="Customer")
			$list:="Order;Invoice;Proposal;OrderLine;InvoiceLine;ProposalLine;Profile;Document;QA;Service;Contact;Object"
		: (This:C1470.dataClassName="Contact")
			$list:="Customer;Rep;Vendor;Object"
		: (This:C1470.dataClassName="Vendor")
		: (This:C1470.dataClassName="Order")
			$list:="OrderLine;POLine;PO;Profile;Document;QA;Service;Time;WODraw;WorkOrder;dInventory;Contact;Object"
		: (This:C1470.dataClassName="Invoice")
			$list:="InvoiceLine;Profile;Document;QA;Service;DInventory;DCash;Contact;Object"
		: (This:C1470.dataClassName="Payment")
			$list:="DCash;Object"
		: (This:C1470.dataClassName="DCash")
			$list:="Payment;Invoice;Object"
		: (This:C1470.dataClassName="Proposal")
			$list:="ProposalLine;Profile;Document;QA;Service;Contact;Object"
		: (This:C1470.dataClassName="PO")
			$list:="POLine;Profile;Document;QA;Service;Contact;Object"
		: (This:C1470.dataClassName="Project")
			$list:="PO;Order;Invoice;Proposal;Service;Contact;Customer;Vendor;Object"
		: (This:C1470.dataClassName="Rep")
			$list:="Order;Invoice;Proposal;Service;Contact;Customer;Object"
		: (This:C1470.dataClassName="Item")
			$list:="BOM;DBOM;DInventory;"+\
				"InventoryStack;InvoiceLine;ItemCarried;"+\
				"ItemDiscount;ItemModifier;ItemSerial;"+\
				"ItemSerialAction;ItemSiteBucket;ItemSpec;"+\
				"ItemWarehouse;ItemXRef;LoadItem;OrderLine;"+\
				"POLine;POReceipt;ProposalLine;Service;"+\
				"WorkOrder;WorkOrderTask;Object"
		: (This:C1470.dataClassName="DCash")
			$list:="Payment;Invoice"
	End case 
	
	This:C1470.tabRelated:=Split string:C1554($list; ";")
	
Function _getRelated()
	Case of 
		: (This:C1470.dataClassName="Order")
			var linesSODS_c; linesPODS_c; poDS_c; profileDS_c; documentDS_c; \
				qaDS_c; serviceDS_c; timeDS_c; woDrawDS_c; workorderDS_c; \
				dInventoryDS_c; contactDS_c; objectDS_c : Collection
			//$list:="OrderLine;POLine;PO;Profile;Document;QA;Service;Time;WODraw;WorkOrder;dInventory;Contact;Object"
			
			// add an FC to limit fields passed into the collection
			
			linesSODS_c:=ds:C1482.OrderLine.query("idNumOrder = :1"; entry_o.idNum).toCollection()
			linesPODS_c:=ds:C1482.POLine.query("idNumOrder = :1"; entry_o.idNum).toCollection()
			poDS_c:=ds:C1482.PO.query("idNumOrder = :1"; entry_o.idNum).toCollection()
			profileDS_c:=ds:C1482.Profile.query("idNumForeign = :1 && tableName = :2"; \
				entry_o.idNum; This:C1470.dataClassName).toCollection()
			documentDS_c:=ds:C1482.Document.query("idNumTask = :1"; entry_o.idNum).toCollection()
			qaDS_c:=ds:C1482.QA.query("idNumTask = :1"; entry_o.idNumTask).toCollection()
			serviceDS_c:=ds:C1482.Service.query("idNumOrder = :1"; entry_o.idNum).toCollection()
			timeDS_c:=ds:C1482.Time.query("idNumOrder = :1"; entry_o.idNum).toCollection()
			woDrawDS_c:=ds:C1482.WODraw.query("idNumTask = :1"; entry_o.idNumTask).toCollection()
			workorderDS_c:=ds:C1482.WorkOrder.query("idNumTask = :1"; entry_o.idNumTask).toCollection()
			dInventoryDS_c:=ds:C1482.InventoryD.query("idNumForeign = :1 && tableName = :2"; \
				entry_o.idNum; This:C1470.dataClassName).toCollection()
			contactDS_c:=ds:C1482.Contact.query("idNumCustomer = :1"; entry_o.idNumCustomer).toCollection()
			objectDS_c:=ds:C1482.Object.query("idNumForeign = :1 && tableName = :2"; \
				entry_o.idNum; This:C1470.dataClassName).toCollection()
			
	End case 
	
	
	//MARK:-  get
	
	
	
	
	
	
Function getFCFieldList($view : Text)
	// cEntry getFCFieldList
	
	
	//MARK:-  calc
	
	
	
	
	
	//MARK:-  FC
	
	
	
Function _getFC($input_o : Object)
	
	// separate the Form from the listbox from the data entry FC records
	// this is more records but allows for mixing behaviors for multiple listboxes and entry areas
	// purpose is the Form name, role sets field characteristics, name is the subform or listbox
	If ($input_o=Null:C1517)
		$input_o:=New object:C1471(\
			"purpose"; "setup"; \
			"dataClassName"; This:C1470.dataClassName; \
			"role"; Storage:C1525.user.role; \
			"name"; This:C1470.name)
	End if 
	This:C1470.fc:=STR_FCGet($input_o)
	
Function _fcBuildView()
	// use This.fc
	This:C1470._buildViewChoices()
	
	
Function _setFCByID($id : Text)
	This:C1470.fc:=Null:C1517
	If ($id#"")
		This:C1470.fc:=ds:C1482.FC.query("id = :1"; $id).first()
	End if 
	
	
	// need for listboxes, entry, and detail other uses of FC
Function _fixFCdata($fields : Text; $entryForm : Object)
	If ($fields="")
		$fields:="id,obGeneral"
	End if 
	
	If ($lbValues=Null:C1517)
		$lbValues:=New object:C1471()
	End if 
	var $o : Object
	$o:=New object:C1471
	$o.data:=New object:C1471("views"; New object:C1471("default"; \
		New object:C1471("name"; "default"; \
		"lbValues"; $lbValues; \
		"columns"; $columns; \
		"fields"; $fields; \
		"page"; New object:C1471)))
	If (False:C215)
		This:C1470.fc:=STR_FCNew($o)
	End if 
	This:C1470._getFC($o)
	
	
	
	$ptviewsList:=OBJECT Get pointer:C1124(Object named:K67:5; "pu_viewsList")
	
	COLLECTION TO ARRAY:C1562(This:C1470.list_c; aViewsList)
	var $w : Integer
	$w:=Find in array:C230(aViewsList; This:C1470.role)
	If ($w<1)
		aViewsList:=1
	Else 
		aViewsList:=$w
	End if 
	
	
	
	//MARK:- PopUps
	
Function _buildViewChoices()
	ARRAY TEXT:C222(aViewsEntry; 0)
	If (Undefined:C82(This:C1470.fc.data.views))  // should always be fixed in _fixFCdata called by getFC
		This:C1470._fixFCEntry()
	End if 
	
	
	var $viewEntry_c : Collection
	
	$viewEntry_c:=New collection:C1472
	$viewEntry_c.push("From list")  // push a value at the first position
	$viewEntry_c.push("List from string")  // push a value at the first position
	$viewEntry_c.push("From string")  // push a value at the first position
	$viewEntry_c.push("--")  // push a value at the first position
	$viewEntry_c.push("Delete")  // push a value at the first position
	$viewEntry_c.push("--")  // push a value at the first position
	$viewEntry_c.push("Save")  // push a value at the first position
	$viewEntry_c.push("Save New")  // push a value at the first position
	//$viewEntry_c.unshift("From Empty")  // push a value at the first position
	$viewEntry_c.push("--")  // push a value at the first position
	$viewEntry_c.push("Views")  // push a value at the first position
	
	
	ARRAY TEXT:C222(aViewsEntry; 0)
	ARRAY TEXT:C222($aTemp; 0)
	For each ($view; This:C1470.fc.data.views)
		APPEND TO ARRAY:C911($aTemp; $view)
	End for each 
	SORT ARRAY:C229($aTemp)
	$k:=Size of array:C274($aTemp)
	For ($i; 1; $k)
		$viewEntry_c.push($aTemp{$i})  // push a value at the first position
	End for 
	
	COLLECTION TO ARRAY:C1562($viewEntry_c; aViewsEntry)
	
	aViewsEntry:=Find in array:C230(aViewsEntry; This:C1470.view)
	
	