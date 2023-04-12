// set this up prior to opening the Dialog
// use this as the base so the identical methods work in the web api
// passing process_o to the Dialog call duplicates process_o. as Form.



// Fix_QQQ by: Bill James (2023-03-13T05:00:00Z)
// This is overlapping things that should be at the process level and things at the subform level
// try to clean this up
// this should be process level items only
Class constructor($dialog : Text; $dataClassName : Text; $data : Variant; $parentProcess : Text; $method : Text)
	This:C1470.dialog:=$dialog
	This:C1470.dataClassName:=$dataClassName
	This:C1470.dataClassPtr:=Table:C252(ds:C1482[This:C1470.dataClassName].getInfo().tableNumber)
	
	// get an FC record for the overall object
	This:C1470.fc:=New object:C1471
	// should this be just in This.fc?
	This:C1470.fc:=ds:C1482.FC.query("name = :1 && purpose = :2 && tableName = :3"; \
		This:C1470.dialog; "setup"; This:C1470.dataClassName).first()
	
	If (Count parameters:C259>3)  // callback should come from FC
		This:C1470.callback:=$method
		// implement this sometime
	End if 
	
	
	// from UI-with-classes
	This:C1470.toBeInitialized:=True:C214
	
	// web interface
	This:C1470.voState:=Null:C1517
	//related listforms
	This:C1470.relatedForms:=Null:C1517
	
	// window and process
	This:C1470.parentProcess:=$parentProcess
	This:C1470.window_i:=0
	This:C1470.window_o:=Null:C1517
	
	This:C1470.purpose:=Null:C1517
	// set on opening window
	This:C1470.menu:=Null:C1517
	This:C1470.title:=Null:C1517
	
	//Form.documents:=ds.Documents.all().orderBy("pageNumber")
	//Form.tabControl.values:=Form.documents.toCollection("title").extract("title")
	This:C1470.tabRelated:=New collection:C1472
	
	// data management
	This:C1470.source:=Null:C1517  //  collection/entity selection form.<>.data is drawn from
	// make sure these are set to the same reference to data in listboxK
	This:C1470.ents:=Null:C1517
	This:C1470.cnt:=0
	This:C1470.sel:=Null:C1517
	This:C1470.cntsel:=0
	This:C1470.edit:=Null:C1517
	This:C1470.old:=Null:C1517
	This:C1470.cur:=Null:C1517
	This:C1470.pos:=0
	// process_o.entry_o is the general reference, 
	// entry_o is the reference in the entry form
	This:C1470.entry_o:=Null:C1517
	This:C1470.related:=Null:C1517
	
	This:C1470.user:=New object:C1471("name"; ""; \
		"idLocal"; ""; \
		"idRemote"; ""; \
		"securityLevel"; 0; \
		"role"; "")
	This:C1470.user.role:=Storage:C1525.user.role
	This:C1470.user.securityLevel:=Storage:C1525.user.securityLevel
	// expand this to the employee/rep and end customer
	
	
	// additional subforms beyond list and entry may be added by name
	This:C1470.sf:=New object:C1471(\
		"list"; New object:C1471("tableForm_b"; False:C215; \
		"nameSF"; "SF_List"; \
		"nameLB"; "LB_DataBrowser"; \
		"fieldNames"; ""); \
		"entry"; New object:C1471("tableForm_b"; True:C214; \
		"nameSF"; "SF_Entry"; \
		"nameForm"; "InputDS"; \
		"fieldNames"; ""))
	
	// setup date range and other form level items
	This:C1470.dt:=New object:C1471(\
		"begin"; New object:C1471("date"; Current date:C33+Storage:C1525.dateSpan.begin.days; \
		"epoch"; 0; \
		"time"; This:C1470.time); \
		"end"; New object:C1471("date"; Current date:C33+Storage:C1525.dateSpan.end.days; \
		"epoch"; 0; \
		"time"; ?00:00:00?))
	
	
	
	//MARK:-  destructor
	
Function destructor
	This:C1470.entsOther:=New object:C1471
	This:C1470.ents:=New object:C1471
	This:C1470.cur:=New object:C1471
	This:C1470.old:=New object:C1471
	This:C1470.sel:=New object:C1471
	This:C1470.pos:=-1
	This:C1470.cnt:=0
	choices_o:=New object:C1471
	
	
	//MARK:-  setters and saves
	
Function _setDialog($dialogName : Text; $project_b : Boolean)
	
	
	
Function setSFList($sfName : Text; $lbName : Text)->$sfList : Object
	
	If ($sfName="")
		This:C1470.sf.list.nameSF:="SF_List"
	Else 
		This:C1470.sf.list.nameSF:=$sfName
	End if 
	If ($lbName="")
		This:C1470.sf.list.nameLB:="LB_DataBrowser"
	Else 
		This:C1470.sf.list.nameLB:=$lbName
	End if 
	
	OBJECT SET SUBFORM:C1138(*; This:C1470.sf.list.nameSF; This:C1470.sf.list.nameForm)
	
	LBX_SetFieldPopup(ds:C1482[This:C1470.dataClassName])
	
	
	
	//MARK:-  setters
	
Function _setInit()
	This:C1470.window:=Current form window:C827
	This:C1470.callback:=Null:C1517
	This:C1470.worker:=Null:C1517
	This:C1470.isSubform:=False:C215
	This:C1470.focused:=Null:C1517
	This:C1470.current:=Null:C1517
	This:C1470.widgets:=New object:C1471
	// deprecate at some point
	//changeRecord:=0
	//doSearch:=0
	//vHere:=2
	//ptCurTable:=This.dataClassPtr
	
	
Function _setSFList()
	// this allows multiple list subforms
	If (This:C1470.source=Null:C1517)  // define the source here
		This:C1470.setSource(ds:C1482[This:C1470.dataClassName].all())
	End if 
	
	
	var SF_cur; LB_DataBrowser : Object
	If (This:C1470.dataClassName=Null:C1517)
		This:C1470.dataClassName:="Customer"
	End if 
	
	LB_DataBrowser:=cs:C1710.listboxK.new("LB_DataBrowser"; This:C1470.dataClassName)
	
	LB_DataBrowser.setSource(This:C1470.source)
	
Function _setSFEntry($dateClassName : Text; $parentForm_t : Text; $sfName_t : Text; $entry_o : Object)
	// this allows multiple entry subforms
	If ($dateClassName="")
		$dateClassName:=This:C1470.dataClassName
	End if 
	If ($parentForm_t="")
		$parentForm_t:="DataBrowser"
	End if 
	If ($sfName_t="")
		$sfName_t:="SF_cur"
	End if 
	
	SF_cur:=cs:C1710.cEntry.new($dateClassName; $parentForm_t; $sfName_t)
	SF_cur._setSubForm($entry_o)  // space between fields
	//SF_cur._makeEntryChoices($entry_o)  // build the external popup
	SF_cur.cur:=LB_DataBrowser.cur
	
	
	
	
	
Function setSource($source : Variant)
/*   Set the source data and determine it's kind   */
	var $type : Integer
	$type:=Value type:C1509($source)
	
	Case of 
		: ($type=Is collection:K8:32)
			This:C1470.source:=$source
			This:C1470.kind:=$type
			This:C1470.setData()
			
		: ($type=Is object:K8:27)  //   entity selection
			This:C1470.source:=$source
			This:C1470.kind:=$type
			This:C1470.setData()
			
		Else 
			This:C1470.source:=Null:C1517
			This:C1470.ents:=Null:C1517
			This:C1470.kind:=Null:C1517
	End case 
	
Function setData
	ASSERT:C1129(Count parameters:C259=0)  //  set the data to the source
	This:C1470.ents:=This:C1470.source
	This:C1470.cnt:=This:C1470.ents.length
	If (This:C1470.ents.length#Null:C1517)
		If (This:C1470.ents.length>0)
			This:C1470.cur:=This:C1470.ents[0]
			// entity to be edited. Note cur will change when another list item is clicked
			This:C1470.edit:=This:C1470.cur
			// make a clone copy that does not change by reference 
			This:C1470.old:=This:C1470.cur.clone()
			This:C1470.pos:=1
			This:C1470.sel:=This:C1470.cur
			This:C1470.cntsel:=This:C1470.sel.length
			// make an object to edit
			This:C1470.entry_o:=This:C1470.cur.toObject()
			If (This:C1470.cur.seq#Null:C1517)
				This:C1470.setSeq()
			End if 
		End if 
	End if 
	
	
Function setSeq
	var $line : Object
	var $seq : Integer
	$seq:=0
	For each ($line; This:C1470.ents)
		$seq:=$seq+1
		$line.seq:=$seq
	End for each 
	
Function setMenu($menuNum : Integer)
	SET MENU BAR:C67($menuNum)
	
Function setTitle($title : Text)
	// data source must already be defined
	If ($title="")
		SET WINDOW TITLE:C213(This:C1470.dataClassName+" displayed/selected: "\
			+String:C10(This:C1470.cnt)+"/"+String:C10(This:C1470.cntsel)\
			+"; Entry: "+This:C1470.entry_o.id)
	Else 
		SET WINDOW TITLE:C213($title)
	End if 
	
Function setEntry
	If (This:C1470.entry_o#Null:C1517)
		If (This:C1470.entry_o.changed)
			If (This:C1470.edit#Null:C1517)
				If (This:C1470.edit.id=This:C1470.entry_o.id)
					var $archiveEntity; $result : Object
					var $o : Object
					$o:=ds:C1482.TallyChange.new()
					$o.tableName:=This:C1470.dataClassName
					$o.idKey:=This:C1470.entry_o.id
					$o.changedBy:=Current user:C182
					$o.dtCreated:=DateTime_DTTo
					//$o.obEntity=New object
					$o.obEntity:=This:C1470.old.toObject()
					$o.save()
					This:C1470.edit:=This:C1470.edit.fromObject(entry_o)
					$status:=This:C1470.edit.save()
					If ($status.autoMerged=Null:C1517)
						$status.autoMerged:=False:C215
					End if 
					
					var $flOK2Validate : Boolean
					Case of 
						: ($status.success & $status.autoMerged)  //Saved & automerged
							ConsoleLog("The Record has been saved, and merged with the previously saved one.")
							$flOK2Validate:=True:C214
						: ($status.success)
							$flOK2Validate:=True:C214
						: ($status.status=dk status locked:K85:21)  //
							ConsoleLog(Util_Get_LocalizedMessage("Recordhasbeenlock"; $status.lockInfo.user_name; $status.lockInfo.user4d_id))
						: ($status.status=dk status entity does not exist anymore:K85:23)
							CONFIRM:C162(Get localized string:C991("Recordnotexist")+" Would you like to save it anyway?"; "Save"; "Do not save")
							If (OK=1)
								var $entity : Object
								$entity:=This:C1470.entityDuplicate(entry_o)
								$status:=This:C1470.entitySave($entity)  //No need to check the status for it's a new entity
								$flOK2Validate:=$status.success
							End if 
						: ($status.status=dk status stamp has changed:K85:20)
							ConsoleLog("This Record cannot be saved for it has already be modified by some other User.")
						: ($status.status=dk status wrong permission:K85:19)  //Nothing to do :-( You don't have the right to save it, period!
							ConsoleLog("You are not allowed to save Records in this Table.")
						: ($status.status=dk status serious error:K85:22)
							ConsoleLog(Util_Get_LocalizedMessage("Something strangesave"; $status.lockInfo.errors.text.join(Char:C90(Carriage return:K15:38))))
					End case 
					
					// if clicking has changed .cur 
					If (This:C1470.cur.id=process_o.old.id)
						process_o.old:=This:C1470.cur
					End if 
					This:C1470.entry_o.changed:=False:C215
					// Class: TableShow
					// Function entitySave  
				Else 
					
				End if 
			End if 
			
		End if 
	End if 
	$0:=This:C1470.cur.toObject()
	
Function listClick()->$return : Object
	// save the current entry_o
	This:C1470.entitySave()
	If (This:C1470.cur#Null:C1517)
		// make a backup
		This:C1470.old:=This:C1470.cur.clone()
		This:C1470.edit:=This:C1470.cur
		
		
		// return new entry_o
		This:C1470.entry_o:=This:C1470.cur.toObject()
		//$return.pageNum:=1
		//This.entry_o:=$return
		entry_o:=This:C1470.entry_o
		// setup the structure. Fill as needed
		
		// belongs in the entry_o not the list box
		//This.initRelated()
		
	End if 
	//$0:=$return
	
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
	
	$list:=$list+$listMore
	
	//Function setRelated($data : Object)
	This:C1470.tabControl:=New object:C1471
	
	
	// MustFixQQQZZZ: Bill James (2022-08-26T05:00:00Z)
	
	If (False:C215)
		var $c : Collection
		var $tableName : Text
		$c:=Split string:C1554($list; ";")
		For each ($tableName; $c)
			This:C1470.related[$tableName]:=New object:C1471(\
				"source"; New object:C1471; \
				"ents"; New object:C1471; \
				"sel"; New object:C1471; \
				"edit"; New object:C1471; \
				"old"; New object:C1471; \
				"cur"; New object:C1471; \
				"pos"; "0"; \
				"entry_o"; New object:C1471)
		End for each 
	End if 
	
	
	
	//MARK:-  entityActions
Function entitySave
	// should this be a the process or cEntry class
	
	
	If (This:C1470.entry_o.changed)
		
		If (OB Instance of:C1731(entry_o; 4D:C1709.Entity))  // see if it is an object or entity
			entry_o.save()
		Else 
			This:C1470.edit.fromObject(entry_o)
		End if 
		//This.edit.fromObject(entry_o)
		
		$status:=This:C1470.edit.save()
		If ($status.success#True:C214)
			
			// azxLearning by: Bill James (2023-02-26T06:00:00Z)
			// resolve failures to save
			$status.autoMerged:=False:C215
		End if 
		If (process_o.dataClassNameLines#"")
			// need to use the LB_Lines class ob
			LB_Lines.saveAll()
			
		End if 
		
		var $flOK2Validate : Boolean
		Case of 
			: ($status.success || $status.autoMerged)  //Saved & automerged
				ConsoleLog("The Record has been saved, and merged with the previously saved one.")
				$flOK2Validate:=True:C214
			: ($status.success)
				$flOK2Validate:=True:C214
			: ($status.status=dk status locked:K85:21)  //
				ConsoleLog(Util_Get_LocalizedMessage("Recordhasbeenlock"; $status.lockInfo.user_name; $status.lockInfo.user4d_id))
			: ($status.status=dk status entity does not exist anymore:K85:23)
				CONFIRM:C162(Get localized string:C991("Recordnotexist")+" Would you like to save it anyway?"; "Save"; "Do not save")
				If (OK=1)
					var $entity : Object
					$entity:=This:C1470.entityDuplicate(entry_o)
					$status:=This:C1470.entitySave($entity)  //No need to check the status for it's a new entity
					$flOK2Validate:=$status.success
				End if 
			: ($status.status=dk status stamp has changed:K85:20)
				ConsoleLog("This Record cannot be saved for it has already be modified by some other User.")
			: ($status.status=dk status wrong permission:K85:19)  //Nothing to do :-( You don't have the right to save it, period!
				ConsoleLog("You are not allowed to save Records in this Table.")
			: ($status.status=dk status serious error:K85:22)
				ConsoleLog(Util_Get_LocalizedMessage("Something strangesave"; $status.lockInfo.errors.text.join(Char:C90(Carriage return:K15:38))))
		End case 
		
		// if clicking has changed .cur 
		If (This:C1470.cur=Null:C1517)
			entry_o.changed:=False:C215
			If (This:C1470.cur.id=process_o.old.id)
				process_o.old:=This:C1470.cur
			End if 
			entry_o.changed:=False:C215
		End if 
		// Class: TableShow
		// Function entitySave  
	Else 
		
	End if 
	
	//process_o.entitySave()
	
	
	//C_OBJECT($status; $entity2save)
	//C_BOOLEAN($fl_IsNewRecord)
	//C_TEXT($object)
	//$entity2save:=$1
	//$fl_IsNewRecord:=Bool(This.editEntity.isNew())
	//For each ($editor; This.objectEditors)  //We have to save the contents of the Object Editors into the corresponding object fields
	//$editor.save()
	//End for each 
	//If (Not(This.entityIsReadOnly))
	//$status:=This.editEntity.save(dk auto merge)
	//$flOK2Validate:=False
	//Case of 
	//: ($status.success & $status.autoMerged)  //Saved & automerged
	//ALERT("The Record has been saved, and merged with the previously saved one.")
	//$flOK2Validate:=True
	//: ($status.success)
	//$flOK2Validate:=True
	//: ($status.status=dk status locked)  //
	//ALERT(Util_Get_LocalizedMessage("Recordhasbeenlock"; $status.lockInfo.user_name; $status.lockInfo.user4d_id))
	//: ($status.status=dk status entity does not exist anymore)
	//CONFIRM(Get localized string("Recordnotexist")+" Would you like to save it anyway?"; "Save"; "Do not save")
	//If (OK=1)
	//$entity:=This.entityDuplicate(This.editEntity)
	//$status:=This.entitySave($entity)  //No need to check the status for it's a new entity
	//$flOK2Validate:=$status.success
	//End if 
	//: ($status.status=dk status stamp has changed)
	//ALERT("This Record cannot be saved for it has already be modified by some other User.")
	//: ($status.status=dk status wrong permission)  //Nothing to do :-( You don't have the right to save it, period!
	//ALERT("You are not allowed to save Records in this Table.")
	//: ($status.status=dk status serious error)
	//ALERT(Util_Get_LocalizedMessage("Something strangesave"; $status.lockInfo.errors.text.join(Char(Carriage return))))
	//End case 
	//If (In transaction)
	//If ($flOK2Validate)
	//VALIDATE TRANSACTION
	//Else 
	//CANCEL TRANSACTION
	//End if 
	//End if 
	//End if 
	//If ($fl_IsNewRecord)
	//If (Not(This.displayedSelection.isAlterable()))
	//This.displayedSelection:=This.displayedSelection.copy()
	//End if 
	//This.displayedSelection.add(This.editEntity)
	//Form.entitiesInDataClass:=Form.dataClass.all().length
	//End if 
	//This.displayedSelection:=This.displayedSelection
	//This.currentPage:=1
	//FORM GOTO PAGE(This.currentPage)
	//Util_UpdateSelection("_LB_1")
	//Util_UpdateOnContext
	
Function entityCancel
	C_OBJECT:C1216($status)
	$status:=This:C1470.editEntity.reload()
	If (In transaction:C397)
		CANCEL TRANSACTION:C241
	End if 
	This:C1470.currentPage:=1
	FORM GOTO PAGE:C247(This:C1470.currentPage)
	Util_UpdateSelection("_LB_1")
	Util_UpdateOnContext
	
Function entityDelete
	C_OBJECT:C1216($toDelete; $lockedSelection; $status; $subsel2Kill)
	C_LONGINT:C283($n)
	If (This:C1470.editEntity=Null:C1517)
		BEEP:C151
		ALERT:C41(Get localized string:C991("There is nothing to delete!"))
	Else 
		If (This:C1470.entityIsReadOnly)
			BEEP:C151
			ALERT:C41(Get localized string:C991("Read-Only mode"))
		Else 
			$text:=Util_Get_LocalizedMessage("delete this Entity")
			CONFIRM:C162($text; Get localized string:C991("Delete it"); Get localized string:C991("Cancel"))
			If (OK=1)
				START TRANSACTION:C239  //This is only necessary when deletion of Records imply deletion of record(s) from another Table (i.e. [INVOICES] and [INVOICES_LINES] for instance)
				$fl_Stop:=This:C1470.relatedDelete($toDelete)  //In case of related entities in other DataClasses, we have to delete it also
				If ($fl_Stop)
					CANCEL TRANSACTION:C241
					ALERT:C41(Get localized string:C991("unexpected problem"))
				Else 
					$status:=This:C1470.editEntity.drop()
					If ($status.success)
						This:C1470.displayedSelection:=This:C1470.displayedSelection.minus(This:C1470.editEntity)
						VALIDATE TRANSACTION:C240
						FORM GOTO PAGE:C247(1)
						Util_UpdateSelection("_LB_1")
					Else 
						Case of 
							: ($status.status=dk status locked:K85:21)
								ALERT:C41(Util_Get_LocalizedMessage("Recordinuse"; $status.lockInfo.user_name))
							: ($status.status=dk status entity does not exist anymore:K85:23)
								ALERT:C41(Get localized string:C991("Recorddeleted"))
							: ($status.status=dk status stamp has changed:K85:20)
							: ($status.status=dk status wrong permission:K85:19)  //Nothing to do :-( You don't have the right to delete it, period!
							: ($status.status=dk status serious error:K85:22)
								ALERT:C41(Util_Get_LocalizedMessage("Something strange"; $status.lockInfo.errors.text.join(Char:C90(Carriage return:K15:38))))
						End case 
						CANCEL TRANSACTION:C241
					End if 
				End if 
			End if 
		End if 
	End if 
	
	
	//MARK:-  getters and create
	
	
	// Fix_QQQ by: Bill James (2023-03-13T05:00:00Z)
	// commented because they caused an endless loop on instantiation of class
	// called in listboxK class
	
	
	//Function get isSelected->$isSelected : Boolean
	//$isSelected:=This.pos>0
	
	//Function get index->$index : Integer
	//$index:=This.pos-1
	
	
Function get_item()->$value : Variant
	//  gets the current item using the position index
	If (This:C1470.pos>0)
		$value:=This:C1470.ents[This:C1470.index]
	End if 
	
Function indexOf($what : Variant)->$index : Integer
/* attempts to find the index of $what in .data
if this is an entity selection $what must be an entity of that dataclass
if this is a collection $what must be the same type as the collection data
*/
	$index:=-1
	
	Case of 
		: ($what=Null:C1517)
		: (This:C1470.kind=Is object:K8:27)
			// this is a sequential search
			
			If (This:C1470.ents.contains($what))
				While ($index<This:C1470.ents.length)
					$index+=1
					If (This:C1470.ents[$index].getKey()=$what.getKey())
						return 
					End if 
				End while 
				
			End if 
			
		: (This:C1470.kind=Is collection:K8:32)
			$index:=This:C1470.ents.indexOf($what)
			
	End case 
	
	
	//MARK:-  calcs
	
	
	
	//MARK:-[WIDGETS]   
	//=== === === === === === === === === === === === === === === === === === === === === 
	
	
	//=== === === === === === === === === === === === === === === === === === === === === 
	// Associate a worker to the current form
	
	
	//MARK:-[CURSOR]
	//=== === === === === === === === === === === === === === === === === === === === === 