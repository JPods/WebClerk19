//%attributes = {}
C_OBJECT:C1216($entity)

$entity:=$1

Case of 
	: (Form:C1466.currentPage=1)
		//We have to disable buttons which make sense only if some lines are selected
		OBJECT SET ENABLED:C1123(*; "@_SEL_@"; Num:C11($this.selectedSubset.length)>0)
		
	: (Form:C1466.currentPage=2)
		$entityIsModifiable:=Not:C34(Form:C1466.entityIsReadOnly)  //recordCanBeSaved)
		OBJECT SET ENTERABLE:C238(*; "@_FIELD_@"; $entityIsModifiable)
		OBJECT SET ENABLED:C1123(*; "@_FIELD_@"; $entityIsModifiable)
		//OBJECT SET ENTERABLE(*;"_FIELD_Value_";Form.settings.Display.enterInList & $entityIsModifiable)
		OBJECT SET VISIBLE:C603(*; "@_ADDPIC_@"; $entityIsModifiable)
		OBJECT SET ENABLED:C1123(*; "@_SAVE_@"; $entityIsModifiable)
		OBJECT SET ENABLED:C1123(*; "@_RW_DELETE_@"; ($entityIsModifiable & Not:C34($entity.isNew())))
		OBJECT SET ENABLED:C1123(*; "@_RW_CALL_@"; ($entityIsModifiable | $entity.isNew()))
		
		OBJECT SET DRAG AND DROP OPTIONS:C1183(*; "@_Picture_@"; True:C214; True:C214; $entityIsModifiable; $entityIsModifiable)  //draggable ; automaticDrag ; droppable ; automaticDrop )
		OBJECT SET ENABLED:C1123(*; "@_LIST_@"; $entityIsModifiable)  //
		OBJECT SET ENABLED:C1123(*; "@_FRST_@"; ($entity.indexOf(Form:C1466.displayedSelection)>0) & Not:C34($entity.isNew()))  //...if the Entity is the first one
		OBJECT SET ENABLED:C1123(*; "@_LAST_@"; ($entity.indexOf(Form:C1466.displayedSelection)<(Form:C1466.displayedSelection.length-1)) & Not:C34($entity.isNew()))  //...or the last one
		If (Form:C1466.pictureName#"")
			If ($entity[Form:C1466.pictureName]#Null:C1517)
				OBJECT SET VISIBLE:C603(*; "@_NOPIC_@"; (Picture size:C356($entity[Form:C1466.pictureName])=0))
				If (Picture size:C356($entity[Form:C1466.pictureName])=0)
					OBJECT SET VISIBLE:C603(*; "@_NOPIC_1@"; $entityIsModifiable)
				End if 
			End if 
		End if 
		
		//This part is specific for each DataClass
		Case of   //For Forms displaying related entities
			: (Form:C1466.dataClassName="Invoices")
				OBJECT SET VISIBLE:C603(*; "@_NEWINV_@"; $entity.isNew())
				OBJECT SET VISIBLE:C603(*; "@_LIST_DEL_INVOICE_LINES"; $entityIsModifiable & (Form:C1466.sel_Invoices_to_Invoice_Lines.length>0))  //If at least an Entity has been selected
		End case 
		
End case 