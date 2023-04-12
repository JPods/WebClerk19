
// Modified by: Bill James (2022-04-23T05:00:00Z)
// Method: TableShow
// Description 
// Parameters
// ----------------------------------------------------


// Ref : 25-InvoicesDemo
//Users/williamjames/Documents/CommerceExpert/4D_Summit_2020-AdvancedTraining_by_JPR/Example applications

Class constructor
	C_TEXT:C284($1)
	This:C1470.dataClassName:=$1
	This:C1470.dataClassNameLines:=""
	Case of 
		: (This:C1470.dataClassName="Proposal")
			This:C1470.dataClassNameLines:="OrderLine"
		: (This:C1470.dataClassName="Order")
			This:C1470.dataClassNameLines:="OrderLine"
		: (This:C1470.dataClassName="Invoice")
			This:C1470.dataClassNameLines:="InvoiceLine"
		: (This:C1470.dataClassName="PO")
			This:C1470.dataClassNameLines:="POLine"
			
		: (This:C1470.dataClassName="Requisition")
			// later
	End case 
	This:C1470.dialogName:=$1
	This:C1470.windowMain:=0
	This:C1470.dataClass:=ds:C1482[This:C1470.dataClassName]
	// This.tableName:=This.dataClassName  // added but should be avoided going forward ot make the code portable
	This:C1470.dataClassPtr:=Table:C252(This:C1470.dataClass.getInfo().tableNumber)
	//This.displayedSelection:=This.dataClass.all()
	//$b:=This.displayedSelection.isAlterable()
	
	This:C1470.related:=New object:C1471
	This:C1470.alerts:=New object:C1471("dialog"; Storage:C1525.alerts.dialog; "console"; Storage:C1525.alerts.console)
	// make SF and LB the same as names
	
	choices_o:=cs:C1710.cChoices.new(This:C1470.dataClassName)
	
	
	This:C1470.currentPage:=1
	This:C1470.entityIsReadOnly:=False:C215
	This:C1470.entry_o:=New object:C1471("changed"; False:C215)
	
	This:C1470.entsOther:=New object:C1471
	This:C1470.ents:=New object:C1471
	This:C1470.cur:=New object:C1471
	This:C1470.old:=New object:C1471
	This:C1470.sel:=New object:C1471
	This:C1470.pos:=-1
	This:C1470.cnt:=0
	
	This:C1470.doLines:=False:C215
	
	// do subform definition, do this as a default but add flexibility later
	This:C1470.SF_Entry:="SF_Entry"
	This:C1470.SF_List:="SF_List"
	This:C1470.LB_Selection:="LB_Selection"
	
	
	
	
	
	
	// look at not calling this unless needed
	This:C1470.queryTable:=cs:C1710.TableQuery.new(This:C1470.dataClass; This:C1470.entitiesInDataClass)  //;This.displayedSelection;This.selectedSubset
	
	This:C1470.pictureName:=""
	This:C1470.objectEditors:=New collection:C1472
	Use (Storage:C1525)
		If (Storage:C1525.windowList=Null:C1517)
			Storage:C1525.windowList:=New shared object:C1526
		End if 
		Use (Storage:C1525.windowList)
			If (Storage:C1525.windowList[This:C1470.dataClassName]=Null:C1517)
				Storage:C1525.windowList[This:C1470.dataClassName]:=0
			End if 
		End use 
	End use 
	This:C1470.ediPass:=Storage:C1525.ediPass
	This:C1470.alertDialog:=Storage:C1525.alertDialog
	This:C1470.console:=Storage:C1525.console
	
Function destructor
	Use (Storage:C1525)
		Use (Storage:C1525.windowList)
			Storage:C1525.windowList[This:C1470.dataClassName]:=0
		End use 
	End use 
	This:C1470.entsOther:=New object:C1471
	This:C1470.ents:=New object:C1471
	This:C1470.cur:=New object:C1471
	This:C1470.old:=New object:C1471
	This:C1470.sel:=New object:C1471
	This:C1470.pos:=-1
	This:C1470.cnt:=0
	choices_o:=New object:C1471
	
	
Function selectZero
	var $0 : Object
	This:C1470.ents:=New object:C1471
	This:C1470.cur:=New object:C1471
	This:C1470.old:=New object:C1471
	This:C1470.sel:=New object:C1471
	This:C1470.pos:=-1
	This:C1470.cnt:=0
	$0:=New object:C1471
	
Function setRelatedEmpty($dateClassName : Text)
	This:C1470.related[$dateClassName]:=New object:C1471(\
		"ents"; New object:C1471; \
		"cur"; New object:C1471; \
		"old"; New object:C1471; \
		"pos"; -1; \
		"cnt"; 0)
	
Function setRelated($data : Object)
	var $dataClassName : Text
	$dataClassName:=$data.getDataClass().tableName
	If ($data.length=0)
		This:C1470.related[$dataClassName].setRelatedEmpty($dataClassName)
	Else 
		This:C1470.related[$dataClassName].ents:=$data
		This:C1470.related[$dataClassName].cur:=$data[0]
		This:C1470.related[$dataClassName].old:=$data[0]
		This:C1470.related[$dataClassName].pos:=1
		This:C1470.related[$dataClassName].cnt:=$data.length
	End if 
	
	
Function selectInit
	var $return : Object
	$return:=New object:C1471
	If (This:C1470.cnt=0)
		If (ds:C1482[This:C1470.dataClassName].actionDate#Null:C1517)
			This:C1470.ents:=ds:C1482[This:C1470.dataClassName].query("actionDate >= :1 AND actionDate <= :2"; Current date:C33-14; Current date:C33+15)
			This:C1470.cnt:=This:C1470.ents.length
		End if 
	End if 
	If (This:C1470.cnt=0)
		This:C1470.ents:=ds:C1482[This:C1470.dataClassName].all()
		This:C1470.cnt:=This:C1470.ents.length
	End if 
	If (This:C1470.cnt=0)
		// must have ()
		$return:=This:C1470.selectZero()
	Else 
		$return:=This:C1470.selectChanged()
	End if 
	$0:=$return
	
Function selectChanged
	process_o.entitySave()
	var $0; $return : Object
	Case of 
		: (This:C1470.ents=Null:C1517)
		: (This:C1470.ents.length=Null:C1517)
		: (This:C1470.ents.length=0)
			
		Else 
			This:C1470.sel:=This:C1470.ents[0]
			This:C1470.cur:=This:C1470.ents[0]
			This:C1470.edit:=This:C1470.cur
			This:C1470.old:=This:C1470.cur.clone()
			This:C1470.cnt:=This:C1470.ents.length
			This:C1470.cntsel:=This:C1470.sel.length
			This:C1470.pos:=1
			This:C1470.posOld:=1
			This:C1470.lines:=Null:C1517
			
			
			$return:=This:C1470.cur.toObject()
			If (This:C1470.dataClassNameLines#"")
				This:C1470.lines:=New object:C1471(\
					"ents"; New object:C1471; \
					"cur"; New object:C1471; \
					"sel"; New object:C1471; \
					"pos"; 0; \
					"count"; 0)
			End if 
			$return.pageNum:=1
			$return.changed:=False:C215
			$0:=$return
	End case 
	
	
Function queryActionChoices($dateBegin : Date; $dateEnd : Date)
	process_o.entitySave()
	var $query_o; $oBuild; $0 : Object
	var $inc : Integer
	var $string : Text
	var $build_c : Collection
	$query_o:=New object:C1471("queryString"; ""; \
		"queryParams"; New object:C1471(\
		"queryPlan"; False:C215; \
		"queryPath"; False:C215; \
		"parameters"; New collection:C1472))
	$build_c:=New collection:C1472
	If (aActions=1)
		//$build_c.push(New object("str"; "action"; "value"; ""; "operator"; " >= "))
	Else 
		$build_c.push(New object:C1471("str"; "action"; "value"; aActions{aActions}; "operator"; " = "))
	End if 
	If (aNameID=1)
		//$build_c.push(New object("str"; "actionBy"; "value"; ""; "operator"; " >= "))
	Else 
		$build_c.push(New object:C1471("str"; "actionBy"; "value"; aNameID{aNameID}; "operator"; " = "))
	End if 
	$build_c.push(New object:C1471("str"; "actionDate"; "value"; $dateBegin; "operator"; " >= "))
	$build_c.push(New object:C1471("str"; "actionDate"; "value"; $dateEnd; "operator"; " <= "))
	For each ($oBuild; $build_c)
		If ($query_o.queryString#"")
			$query_o.queryString:=$query_o.queryString+" and "
		End if 
		$query_o.queryParams.parameters.push($oBuild.value)
		$query_o.queryString:=$query_o.queryString+$oBuild.str+$oBuild.operator+":"+String:C10($query_o.queryParams.parameters.length)+" "
	End for each 
	process_o.ents:=ds:C1482[process_o.dataClassName].query($query_o.queryString; $query_o.queryParams)
	entry_o:=process_o.selectChanged()
	
	
Function titleSet
	SET WINDOW TITLE:C213(This:C1470.dataClassName+" displayed/selected: "+String:C10(This:C1470.cnt)+"/"+String:C10(This:C1470.cntsel))
	
	
Function showIt
	var $0 : Integer
	$0:=New process:C317("Process_ShowTableDS"; 0; String:C10(Count user processes:C343)+"-"+This:C1470.dataClassName; This:C1470)
	
Function listClick
	// save the current entry_o
	This:C1470.entitySave()
	If (This:C1470.cur#Null:C1517)
		// make a backup
		This:C1470.old:=This:C1470.cur.clone()
		This:C1470.edit:=This:C1470.cur
		// return new entry_o
		$return:=This:C1470.cur.toObject()
		$return.pageNum:=1
		
		// setup the structure. Fill as needed
		This:C1470.initRelated()
		
	End if 
	$0:=$return
	
Function initRelated($listMore : Text)
	// setup the structure. Fill as needed
	Case of 
		: (This:C1470.dataClassName="Customer")
			$list:="Order,Invoice,Proposal,OrderLine,InvoiceLine,ProposalLine,Profile,Document,QA,Service,Contact,Object"
		: (This:C1470.dataClassName="Contact")
			$list:="Customer,Rep,Vendor,Object"
		: (This:C1470.dataClassName="Vendor")
		: (This:C1470.dataClassName="Order")
			$list:="OrderLine,POLine,PO,Profile,Document,QA,Service,Time,WODraw,WorkOrder,dInventory,Contact,Object"
		: (This:C1470.dataClassName="Invoice")
			$list:="InvoiceLine,Profile,Document,QA,Service,DInventory,DCash,Contact,Object"
		: (This:C1470.dataClassName="Payment")
			$list:="DCash,Object"
		: (This:C1470.dataClassName="DCash")
			$list:="Payment,Invoice,Object"
		: (This:C1470.dataClassName="Proposal")
			$list:="ProposalLine,Profile,Document,QA,Service,Contact,Object"
		: (This:C1470.dataClassName="PO")
			$list:="POLine,Profile,Document,QA,Service,Contact,Object"
		: (This:C1470.dataClassName="Project")
			$list:="PO,Order,Invoice,Proposal,Service,Contact,Customer,Vendor,Object"
		: (This:C1470.dataClassName="Rep")
			$list:="Order,Invoice,Proposal,Service,Contact,Customer,Object"
		: (This:C1470.dataClassName="Item")
			$list:="BOM,DBOM,DInventory,"+\
				"InventoryStack,InvoiceLine,ItemCarried,"+\
				"ItemDiscount,ItemModifier,ItemSerial,"+\
				"ItemSerialAction,ItemSiteBucket,ItemSpec,"+\
				"ItemWarehouse,ItemXRef,LoadItem,OrderLine,"+\
				"POLine,POReceipt,ProposalLine,Service,"+\
				"WorkOrder,WorkOrderTask,Object"
		: (This:C1470.dataClassName="DCash")
			$list:="Payment,Invoice"
	End case 
	$list:=$list+$listMore
	
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
	
	
	//Function setRelated($data : Object)
	
	
	
Function updateData
	//Settings_ApplyToListBox (Form.settings;"_LB_INVOICE_LINES";True)
	
Function entityAdd()->$entry_o : Object
	//This.clickedEntity:=This.dataClass.new()
	//This.entityOpen()
	//$entry_o:=cs.centry_oInit(This.dataClassName)
	
	// UpdateWithResources by: Bill James (2023-01-03T06:00:00Z)
	
	// Copied, look to original to implement: Bill James (2023-01-03T06:00:00Z)
	
	
	
	
Function entityMove
	$action:=$1
	$flOK:=True:C214
	Case of 
		: ($action="FIRST")
			This:C1470.clickedEntity:=This:C1470.clickedEntity.first()
		: ($action="PREVIOUS")
			If (Not:C34(This:C1470.clickedEntity.previous()=Null:C1517))
				This:C1470.clickedEntity:=This:C1470.clickedEntity.previous()
			End if 
		: ($action="NEXT")
			If (Not:C34(This:C1470.clickedEntity.next()=Null:C1517))
				This:C1470.clickedEntity:=This:C1470.clickedEntity.next()
			End if 
		: ($action="LAST")
			This:C1470.clickedEntity:=This:C1470.clickedEntity.last()
		Else 
			$flOK:=False:C215
	End case 
	If ($flOK)
		//This.entityOpen()
		// Copied, look to original to implement: Bill James (2023-01-03T06:00:00Z)
		
	End if 
	
Function entityDuplicate
	C_TEXT:C284($property)
	C_OBJECT:C1216($1; $0; $target)
	$source:=$1
	$target:=This:C1470.dataClass.new()
	For each ($property; $source)
		If ($property#"ID")
			If ($target[$property]=Null:C1517)
				// build a contingency for what we want to do with this if it is valuable
				
			Else 
				$target[$property]:=$source[$property]
			End if 
		End if 
	End for each 
	$0:=$target
	
Function entitySave
	If (This:C1470.entry_o.changed)
		If (tallyChange_o=Null:C1517)
			var tallyChange_o : Object
			tallyChange_o:=DB_SaveTallyChange(process_o; entry_o; tallyChange_o)
			// tallyChange_o
		Else 
			tallyChange_o:=DB_SaveTallyChange(process_o; entry_o; tallyChange_o)
		End if 
		
		This:C1470.edit.fromObject(entry_o)
		This:C1470.edit:=This:C1470.edit.fromObject(entry_o)
		$status:=This:C1470.edit.save()
		If ($status.autoMerged=Null:C1517)
			$status.autoMerged:=False:C215
		End if 
		If (process_o.dataClassNameLines#"")
			// need to use the LB_Lines class ob
			LB_Lines.saveAll()
			
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
	
Function entityAddPicture
	C_PICTURE:C286($pict)
	C_TEXT:C284($pictureName)
	$pictureName:=This:C1470.pictureName
	If ($pictureName#"")
		READ PICTURE FILE:C678(""; $pict)
		If (OK=1)
			Form:C1466.editEntity[$pictureName]:=$pict
		End if 
	End if 
	
Function selectionPrintLabels
	USE ENTITY SELECTION:C1513(This:C1470.displayedSelection)
	$dataClassPtr:=Table:C252(This:C1470.dataClass.getInfo().tableNumber)
	PRINT LABEL:C39($dataClassPtr->; Char:C90(1))
	
Function selectionPrintReports
	USE ENTITY SELECTION:C1513(This:C1470.displayedSelection)
	$dataClassPtr:=Table:C252(This:C1470.dataClass.getInfo().tableNumber)
	QR REPORT:C197($dataClassPtr->; Char:C90(1))
	
Function selectionExport
	USE ENTITY SELECTION:C1513(This:C1470.displayedSelection)
	If (This:C1470.exportParams=Null:C1517)
		This:C1470.exportParams:=""
	End if 
	EXPORT DATA:C666(""; This:C1470.exportParams; *)  //The export Param can be saved and reused later
	
Function selectionPrint
	USE ENTITY SELECTION:C1513(This:C1470.displayedSelection)
	action_PrintSelection
	
Function selectionAll
	This:C1470.displayedSelection:=This:C1470.dataClass.all()
	This:C1470.selectedSubset:=New object:C1471
	This:C1470.clickedEntity:=New object:C1471
	This:C1470.updatesubForm("_QuickQuery_"; "UpdateQuerySubform")
	Util_UpdateOnContext
	
Function selectionSubset
	If (Num:C11(This:C1470.selectedSubset.length)>0)
		This:C1470.displayedSelection:=This:C1470.selectedSubset
		This:C1470.clickedEntity:=New object:C1471
		This:C1470.queryTable.queryString:=""
	End if 
	Util_UpdateOnContext
	
Function selectionDelete
	C_OBJECT:C1216($toDelete; $lockedSelection; $status; $subsel2Kill)
	C_LONGINT:C283($n)
	If (This:C1470.selectedSubset=Null:C1517)
		BEEP:C151
		ALERT:C41(Get localized string:C991("There is nothing to delete!"))
	Else 
		$toDelete:=This:C1470.selectedSubset
		$n:=Num:C11($toDelete.length)
		If ($n=0)
			BEEP:C151
			ALERT:C41(Get localized string:C991("There is nothing to delete!"))
		Else 
			$text:=Util_Get_LocalizedMessage("deleteSelection"; String:C10($n))
			CONFIRM:C162($text; Get localized string:C991("Delete it"); Get localized string:C991("Cancel"))
			If (OK=1)
				START TRANSACTION:C239  //This is only necessary when deletion of Records imply deletion of records from another Table (i.e. [INVOICES] and [INVOICES_LINES] for instance)
				$fl_Stop:=This:C1470.relatedDelete($toDelete)  //In case of related entities in other DataClasses, we have to delete it also
				If ($fl_Stop)
					CANCEL TRANSACTION:C241
					BEEP:C151
					ALERT:C41(Get localized string:C991("unexpected problem"))
				Else 
					$lockedSelection:=$toDelete.drop(dk stop dropping on first error:K85:26)  //$lockedSelection is an entity selection containing the first not dropped entity
					$fl_Stop:=($lockedSelection.length>0)
					If ($fl_Stop)  //The delete action is unsuccessful, at least one entity cannot be deleted
						CANCEL TRANSACTION:C241
						ALERT:C41(Get localized string:C991("At least one"))
					Else 
						VALIDATE TRANSACTION:C240
						ALERT:C41(Util_Get_LocalizedMessage("You have dropped"; String:C10($n); Form:C1466.dataClassName))  //The dropped entity selection remains in memory
						This:C1470.displayedSelection:=This:C1470.displayedSelection.minus($toDelete)
						Util_UpdateSelection("_LB_1")
					End if 
				End if 
			End if 
		End if 
	End if 
	
Function relatedDelete  //In case of related entities in other DataClasses, we have to delete it also
	C_OBJECT:C1216($toDelete; $lockedSelection; $status; $subsel2Kill)
	$toDelete:=$1
	$dataClassName:=$toDelete.getDataClass().getInfo().name  //In fact, $1 can be an entity or an entity selection, we don't care, this is ORDA's magic!
	Case of   //Handling of special cases
		: ($dataClassName="Invoices")  //To delete an invoice, it's necessary to delete invoice lines first
			$subsel2Kill:=$toDelete.Invoices_to_Invoice_Lines  //We select the invoices lines for all the selected invoices
			$lockedSelection:=$subsel2Kill.drop(dk stop dropping on first error:K85:26)
			$fl_Stop:=($lockedSelection.length>0)
		Else 
			$fl_Stop:=False:C215
	End case 
	$0:=$fl_Stop
	
Function updatesubForm
	C_TEXT:C284($1; $2)
	EXECUTE METHOD IN SUBFORM:C1085($1; "CF_CallDownstairs"; *; $2; New object:C1471("value"; ""))
	
Function propagateSelection
	$targetDataClassName:=$1
	If (FORM Get current page:C276=1)  //It's a List
		$fl_Subset:=(This:C1470.selectedSubset#Null:C1517)
		If ($fl_Subset)
			$fl_Subset:=Not:C34(OB Is empty:C1297(This:C1470.selectedSubset))
		End if 
		If ($fl_Subset)
			$fl_Subset:=(This:C1470.selectedSubset.length>0)
		End if 
		If ($fl_Subset)
			$selection2Use:=This:C1470.selectedSubset
		Else 
			$selection2Use:=This:C1470.displayedSelection
		End if 
	Else   //It's an Entity (therefore a Record)
		$selection2Use:=This:C1470.clickedEntity
	End if 
	$params:=New object:C1471
	//The following 'Case of' will be much simpler when the aliases will be included in the data model...
	//We will be able to define Products_to_Clients as Products_to_Invoice_Lines.Invoice_Lines_to_Invoices.Invoices_to_Clients
	
	$params.selection2Use:=Util_PropagateSelection($selection2Use; This:C1470.dataClassName; $targetDataClassName)
	
	$params.useSelection:=True:C214
	W_ShowTable($targetDataClassName; $params)
	
Function objectFieldList
	C_OBJECT:C1216($zeProperty; $dataClass)
	C_TEXT:C284($property)
	C_COLLECTION:C1488($0)
	$dataClass:=This:C1470.dataClass
	$objectFieldsList:=New collection:C1472
	For each ($property; $dataClass)  //For each property in the DataClass ($property is the property name)
		If ($property#"_@")  //My rule is: When a field names begins with "_", it's supposed to be invisible...
			$zeProperty:=$dataClass[$property]  //Access the property from it's name
			If ($zeProperty.kind="storage")
				$x:=Type:C295($zeProperty)
				If ($zeProperty.type="object")
					$objectFieldsList.push($zeProperty.name)
				End if 
			End if 
		End if 
	End for each 
	$0:=$objectFieldsList