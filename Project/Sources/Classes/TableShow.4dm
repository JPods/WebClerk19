
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/05/21, 17:14:23
// ----------------------------------------------------
// Method: TableShow
// Description
// 
//
// Parameters
// ----------------------------------------------------

// I do not have time for this at this point
// Ref: 25-InvoicesDemo
// /Users/williamjames/Documents/CommerceExpert/4D_Summit_2020-AdvancedTraining_by_JPR/Example applications

// Class constructor
// C_TEXT($1)
// This.dataClassName:=$1
// This.dialogName:=$1
// This.mainWindow:=0
// This.dataClass:=ds[This.dataClassName]
// This.dataClassPtr:=Table(This.dataClass.getInfo().tableNumber)
// This.displayedSelection:=This.dataClass.all()
// $b:=This.displayedSelection.isAlterable()
// 
// This.selectedSubset:=New object
// This.entitiesInDataClass:=This.displayedSelection.length
// This.currentPage:=1
// This.entityIsReadOnly:=False
// This.queryTable:=cs.TableQuery.new(This.dataClass; This.entitiesInDataClass)  //;This.displayedSelection;This.selectedSubset
// This.settings:=Settings_GetCurrent
// //This.objectFieldsList:=This.objectFieldList()
// This.pictureName:=""
// This.objectEditors:=New collection
// Use (Storage)
// If (Storage.windowList=Null)
// Storage.windowList:=New shared object
// End if 
// Use (Storage.windowList)
// If (Storage.windowList[This.dataClassName]=Null)
// Storage.windowList[This.dataClassName]:=0
// End if 
// End use 
// End use 
// 
// Function destructor
// Use (Storage)
// Use (Storage.windowList)
// Storage.windowList[This.dataClassName]:=0
// End use 
// End use 
// 
// Function showIt
// C_OBJECT($1)
// C_TEXT($DCName)
// $params:=$1
// $fl_Select:=$params.useSelection
// If ($params.pictureName#Null)
// This.pictureName:=$params.pictureName
// End if 
// This.recordCanBeSaved:=True
// This.currentPage:=1
// If (Storage.windowList[This.dataClassName]=0)  //Can be replaced by This.mainWindow=0) if you want to open more than 1 window per table
// $DCName:=This.dataClassName
// If ($fl_Select)  //If there is a calling window
// GET WINDOW RECT($left; $top; $right; $bottom; Frontmost window)
// This.mainWindow:=Open form window($DCName; Plain form window; $left+20; $top+20; *)  //then we shift the new window a little bit
// Else 
// This.mainWindow:=Open form window($DCName; Plain form window; *)
// End if 
// Use (Storage.windowList)
// Storage.windowList[This.dataClassName]:=This.mainWindow
// End use 
// DIALOG(This.dialogName; This; *)
// Else 
// SHOW WINDOW(This.mainWindow)
// End if 
// If (This.displayedSelection=Null)
// This.displayedSelection:=This.dataClass.all()
// End if 
// If ($fl_Select)
// CALL FORM(This.mainWindow; "UpdateForm"; This; $params)
// Else 
// CALL FORM(This.mainWindow; "UpdateForm"; This; New object)
// End if 
// 
// Function updateData
// //Settings_ApplyToListBox (Form.settings;"_LB_INVOICE_LINES";True)
// 
// Function entityAdd
// This.clickedEntity:=This.dataClass.new()
// This.entityOpen()
// 
// Function entityOpen
// C_OBJECT($status)
// $isNew:=Bool(This.clickedEntity.isNew())
// If ($isNew)
// $flOK:=True
// Else 
// $status:=This.clickedEntity.reload()
// If ($status.success)
// $flOK:=True
// Else 
// $flOK:=False
// Case of 
// : ($status.status=dk status entity does not exist anymore)
// ALERT(Get localized string("Recordnotexist"))  //$status.statusText)
// Else 
// ALERT(Get localized string("unexpected problem"))
// End case 
// End if 
// End if 
// If ($flOK)
// This.editEntity:=This.clickedEntity
// For each ($editor; Form.objectEditors)
// If ($isNew)
// Form.data_:=New collection  //The data source of the listbox is always "data_"
// End if 
// $editor.show()
// End for each 
// Util_EntityLoad_Specific($isNew)
// This.currentPage:=2
// FORM GOTO PAGE(This.currentPage)
// End if 
// 
// Function entityMove
// $action:=$1
// $flOK:=True
// Case of 
// : ($action="FIRST")
// This.clickedEntity:=This.clickedEntity.first()
// : ($action="PREVIOUS")
// If (Not(This.clickedEntity.previous()=Null))
// This.clickedEntity:=This.clickedEntity.previous()
// End if 
// : ($action="NEXT")
// If (Not(This.clickedEntity.next()=Null))
// This.clickedEntity:=This.clickedEntity.next()
// End if 
// : ($action="LAST")
// This.clickedEntity:=This.clickedEntity.last()
// Else 
// $flOK:=False
// End case 
// If ($flOK)
// This.entityOpen()
// End if 
// 
// Function entityDuplicate
// C_TEXT($property)
// C_OBJECT($1; $0; $target)
// $source:=$1
// $target:=This.dataClass.new()
// For each ($property; $source)
// If ($property#"ID")
// $target[$property]:=$source[$property]
// End if 
// End for each 
// $0:=$target
// 
// Function entitySave
// C_OBJECT($status; $entity2save)
// C_BOOLEAN($fl_IsNewRecord)
// C_TEXT($object)
// $entity2save:=$1
// $fl_IsNewRecord:=Bool(This.editEntity.isNew())
// For each ($editor; This.objectEditors)  //We have to save the contents of the Object Editors into the corresponding object fields
// $editor.save()
// End for each 
// If (Not(This.entityIsReadOnly))
// $status:=This.editEntity.save(dk auto merge)
// $flOK2Validate:=False
// Case of 
// : ($status.success & $status.autoMerged)  //Saved & automerged
// ALERT("The Record has been saved, and merged with the previously saved one.")
// $flOK2Validate:=True
// : ($status.success)
// $flOK2Validate:=True
// : ($status.status=dk status locked)  //
// ALERT(Util_Get_LocalizedMessage("Recordhasbeenlock"; $status.lockInfo.user_name; $status.lockInfo.user4d_id))
// : ($status.status=dk status entity does not exist anymore)
// CONFIRM(Get localized string("Recordnotexist")+" Would you like to save it anyway?"; "Save"; "Do not save")
// If (OK=1)
// $entity:=This.entityDuplicate(This.editEntity)
// $status:=This.entitySave($entity)  //No need to check the status for it's a new entity
// $flOK2Validate:=$status.success
// End if 
// : ($status.status=dk status stamp has changed)
// ALERT("This Record cannot be saved for it has already be modified by some other User.")
// : ($status.status=dk status wrong permission)  //Nothing to do :-( You don't have the right to save it, period!
// ALERT("You are not allowed to save Records in this Table.")
// : ($status.status=dk status serious error)
// ALERT(Util_Get_LocalizedMessage("Something strangesave"; $status.lockInfo.errors.text.join(Char(Carriage return))))
// End case 
// If (In transaction)
// If ($flOK2Validate)
// VALIDATE TRANSACTION
// Else 
// CANCEL TRANSACTION
// End if 
// End if 
// End if 
// If ($fl_IsNewRecord)
// If (Not(This.displayedSelection.isAlterable()))
// This.displayedSelection:=This.displayedSelection.copy()
// End if 
// This.displayedSelection.add(This.editEntity)
// Form.entitiesInDataClass:=Form.dataClass.all().length
// End if 
// This.displayedSelection:=This.displayedSelection
// This.currentPage:=1
// FORM GOTO PAGE(This.currentPage)
// Util_UpdateSelection("_LB_1")
// Util_UpdateOnContext
// 
// Function entityCancel
// C_OBJECT($status)
// $status:=This.editEntity.reload()
// If (In transaction)
// CANCEL TRANSACTION
// End if 
// This.currentPage:=1
// FORM GOTO PAGE(This.currentPage)
// Util_UpdateSelection("_LB_1")
// Util_UpdateOnContext
// 
// Function entityDelete
// C_OBJECT($toDelete; $lockedSelection; $status; $subsel2Kill)
// C_LONGINT($n)
// If (This.editEntity=Null)
// BEEP
// ALERT(Get localized string("There is nothing to delete!"))
// Else 
// If (This.entityIsReadOnly)
// BEEP
// ALERT(Get localized string("Read-Only mode"))
// Else 
// $text:=Util_Get_LocalizedMessage("delete this Entity")
// CONFIRM($text; Get localized string("Delete it"); Get localized string("Cancel"))
// If (OK=1)
// START TRANSACTION  //This is only necessary when deletion of Records imply deletion of record(s) from another Table (i.e. [INVOICES] and [INVOICES_LINES] for instance)
// $fl_Stop:=This.relatedDelete($toDelete)  //In case of related entities in other DataClasses, we have to delete it also
// If ($fl_Stop)
// CANCEL TRANSACTION
// ALERT(Get localized string("unexpected problem"))
// Else 
// $status:=This.editEntity.drop()
// If ($status.success)
// This.displayedSelection:=This.displayedSelection.minus(This.editEntity)
// VALIDATE TRANSACTION
// FORM GOTO PAGE(1)
// Util_UpdateSelection("_LB_1")
// Else 
// Case of 
// : ($status.status=dk status locked)
// ALERT(Util_Get_LocalizedMessage("Recordinuse"; $status.lockInfo.user_name))
// : ($status.status=dk status entity does not exist anymore)
// ALERT(Get localized string("Recorddeleted"))
// : ($status.status=dk status stamp has changed)
// : ($status.status=dk status wrong permission)  //Nothing to do :-( You don't have the right to delete it, period!
// : ($status.status=dk status serious error)
// ALERT(Util_Get_LocalizedMessage("Something strange"; $status.lockInfo.errors.text.join(Char(Carriage return))))
// End case 
// CANCEL TRANSACTION
// End if 
// End if 
// End if 
// End if 
// End if 
// 
// Function entityAddPicture
// C_PICTURE($pict)
// C_TEXT($pictureName)
// $pictureName:=This.pictureName
// If ($pictureName#"")
// READ PICTURE FILE(""; $pict)
// If (OK=1)
// Form.editEntity[$pictureName]:=$pict
// End if 
// End if 
// 
// Function selectionPrintLabels
// USE ENTITY SELECTION(This.displayedSelection)
// $dataClassPtr:=Table(This.dataClass.getInfo().tableNumber)
// PRINT LABEL($dataClassPtr->; Char(1))
// 
// Function selectionPrintReports
// USE ENTITY SELECTION(This.displayedSelection)
// $dataClassPtr:=Table(This.dataClass.getInfo().tableNumber)
// QR REPORT($dataClassPtr->; Char(1))
// 
// Function selectionExport
// USE ENTITY SELECTION(This.displayedSelection)
// If (This.exportParams=Null)
// This.exportParams:=""
// End if 
// EXPORT DATA(""; This.exportParams; *)  //The export Param can be saved and reused later
// 
// Function selectionPrint
// USE ENTITY SELECTION(This.displayedSelection)
// action_PrintSelection
// 
// Function selectionAll
// This.displayedSelection:=This.dataClass.all()
// This.selectedSubset:=New object
// This.clickedEntity:=New object
// This.updatesubForm("_QuickQuery_"; "UpdateQuerySubform")
// Util_UpdateOnContext
// 
// Function selectionSubset
// If (Num(This.selectedSubset.length)>0)
// This.displayedSelection:=This.selectedSubset
// This.clickedEntity:=New object
// This.queryTable.queryString:=""
// End if 
// Util_UpdateOnContext
// 
// Function selectionDelete
// C_OBJECT($toDelete; $lockedSelection; $status; $subsel2Kill)
// C_LONGINT($n)
// If (This.selectedSubset=Null)
// BEEP
// ALERT(Get localized string("There is nothing to delete!"))
// Else 
// $toDelete:=This.selectedSubset
// $n:=Num($toDelete.length)
// If ($n=0)
// BEEP
// ALERT(Get localized string("There is nothing to delete!"))
// Else 
// $text:=Util_Get_LocalizedMessage("deleteSelection"; String($n))
// CONFIRM($text; Get localized string("Delete it"); Get localized string("Cancel"))
// If (OK=1)
// START TRANSACTION  //This is only necessary when deletion of Records imply deletion of records from another Table (i.e. [INVOICES] and [INVOICES_LINES] for instance)
// $fl_Stop:=This.relatedDelete($toDelete)  //In case of related entities in other DataClasses, we have to delete it also
// If ($fl_Stop)
// CANCEL TRANSACTION
// BEEP
// ALERT(Get localized string("unexpected problem"))
// Else 
// $lockedSelection:=$toDelete.drop(dk stop dropping on first error)  //$lockedSelection is an entity selection containing the first not dropped entity
// $fl_Stop:=($lockedSelection.length>0)
// If ($fl_Stop)  //The delete action is unsuccessful, at least one entity cannot be deleted
// CANCEL TRANSACTION
// ALERT(Get localized string("At least one"))
// Else 
// VALIDATE TRANSACTION
// ALERT(Util_Get_LocalizedMessage("You have dropped"; String($n); Form.dataClassName))  //The dropped entity selection remains in memory
// This.displayedSelection:=This.displayedSelection.minus($toDelete)
// Util_UpdateSelection("_LB_1")
// End if 
// End if 
// End if 
// End if 
// End if 
// 
// Function relatedDelete  //In case of related entities in other DataClasses, we have to delete it also
// C_OBJECT($toDelete; $lockedSelection; $status; $subsel2Kill)
// $toDelete:=$1
// $dataClassName:=$toDelete.getDataClass().getInfo().name  //In fact, $1 can be an entity or an entity selection, we don't care, this is ORDA's magic!
// Case of   //Handling of special cases
// : ($dataClassName="Invoices")  //To delete an invoice, it's necessary to delete invoice lines first
// $subsel2Kill:=$toDelete.Invoices_to_Invoice_Lines  //We select the invoices lines for all the selected invoices
// $lockedSelection:=$subsel2Kill.drop(dk stop dropping on first error)
// $fl_Stop:=($lockedSelection.length>0)
// Else 
// $fl_Stop:=False
// End case 
// $0:=$fl_Stop
// 
// Function updatesubForm
// C_TEXT($1; $2)
// EXECUTE METHOD IN SUBFORM($1; "CF_CallDownstairs"; *; $2; New object("value"; ""))
// 
// Function propagateSelection
// $targetDataClassName:=$1
// If (FORM Get current page=1)  //It's a List
// $fl_Subset:=(This.selectedSubset#Null)
// If ($fl_Subset)
// $fl_Subset:=Not(OB Is empty(This.selectedSubset))
// End if 
// If ($fl_Subset)
// $fl_Subset:=(This.selectedSubset.length>0)
// End if 
// If ($fl_Subset)
// $selection2Use:=This.selectedSubset
// Else 
// $selection2Use:=This.displayedSelection
// End if 
// Else   //It's an Entity (therefore a Record)
// $selection2Use:=This.clickedEntity
// End if 
// $params:=New object
// //The following 'Case of' will be much simpler when the aliases will be included in the data model...
// //We will be able to define Products_to_Clients as Products_to_Invoice_Lines.Invoice_Lines_to_Invoices.Invoices_to_Clients
// 
// $params.selection2Use:=Util_PropagateSelection($selection2Use; This.dataClassName; $targetDataClassName)
// 
// $params.useSelection:=True
// W_ShowTable($targetDataClassName; $params)
// 
// Function objectFieldList
// C_OBJECT($zeProperty; $dataClass)
// C_TEXT($property)
// C_COLLECTION($0)
// $dataClass:=This.dataClass
// $objectFieldsList:=New collection
// For each ($property; $dataClass)  //For each property in the DataClass ($property is the property name)
// If ($property#"_@")  //My rule is: When a field names begins with "_", it's supposed to be invisible...
// $zeProperty:=$dataClass[$property]  //Access the property from it's name
// If ($zeProperty.kind="storage")
// $x:=Type($zeProperty)
// If ($zeProperty.type="object")
// $objectFieldsList.push($zeProperty.name)
// End if 
// End if 
// End if 
// End for each 
// $0:=$objectFieldsList