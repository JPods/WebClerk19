/*  listbox ()
 Created by: Kirk as Designer, Created: 10/7/21,
 ------------------
Default Names
eg. display data, current item, etc. These are stored in the Form and accessed with

TO USE
/*
add the listbox to the form and set the names
initialize
    Form["listbox name"]:=cs.listbox.new("listbox name")
*/
*/

Class constructor($name : Text; $dataClassName : Text; $refs : Object)
	var $key : Text
	// (name{;object})
	ASSERT:C1129(Count parameters:C259>=1; "The name of the listbox object is required.")
	
	This:C1470.name:=$name  //      the name of the listbox
	This:C1470.dataClassName:=$dataClassName
	If ($refs=Null:C1517)
		$refs:=New object:C1471("prebuilt"; True:C214)
	End if 
	If (This:C1470.name="LB_DataBrowser")
		$refs.prebuilt:=False:C215
	End if 
	This:C1470.dataClass:=ds:C1482[This:C1470.dataClassName]
	This:C1470.role:=""
	This:C1470.view:="default"
	This:C1470.source:=Null:C1517  //  collection/entity selection form.<>.data is drawn from
	This:C1470.ents:=Null:C1517
	This:C1470.sel:=Null:C1517
	This:C1470.kind:=Null:C1517
	This:C1470.edit:=Null:C1517
	This:C1470.old:=Null:C1517
	This:C1470.cur:=Null:C1517
	This:C1470.meta:=Null:C1517
	This:C1470.pos:=0
	
	
	
	This:C1470.related:=Null:C1517
	// structure
	This:C1470.listbox:=Null:C1517
	This:C1470.fc:=Null:C1517
	This:C1470.fcNew:=Null:C1517
	
	
	// could change to a case based on the This.dataClassName
	// manage each list box on its own, do not add lines except to their own listbox
	
	// get the FC record
	var $o : Object
	//name of the listbox, entry subform, etc....
	//If (False)  // set these into their own functions
	If (Not:C34($refs.prebuilt))
		This:C1470._getFC()
		
		// Fix_QQQ by: Bill James (2023-04-06T05:00:00Z)
		// change this to load the subform or build the columns depending of fc
		This:C1470.setColumns()
	End if 
	//End if 
	
	
	//MARK:- reset
Function redraw()
	This:C1470.ents:=This:C1470.ents
	
Function reset()
	This:C1470.ents:=This:C1470.source
	
	
	
	//MARK:- get
	
Function get isSelected->$isSelected : Boolean
	If (This:C1470.pos#Null:C1517)
		$isSelected:=This:C1470.pos>0
	End if 
	
Function get index->$index : Integer
	If (This:C1470.pos#Null:C1517)
		$index:=This:C1470.pos-1
	End if 
	
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
	
	//MARK:-  setters
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
	If (This:C1470.ents.length#Null:C1517)
		If (This:C1470.ents.length>0)
			This:C1470.cur:=This:C1470.ents[0]
			This:C1470.edit:=This:C1470.cur
			This:C1470.old:=This:C1470.cur
			This:C1470.pos:=1
			This:C1470.sel:=This:C1470.cur
			This:C1470.entry_o:=New object:C1471()
			entry_o:=This:C1470.cur.toObject()
			////entry_e:=This.cur
			////This.entry_e:=This.cur
			
			//// entry should only be set for the item in this object
			//If (Value type(This.cur)=Is object)
			//var $rec_e : Object
			//$rec_e:=ds[This.dataClassName].query("id = :1"; This.cur.id).first()
			//This.entry_o:=$rec_e.toObject()
			//Else 
			//This.entry_o:=This.cur.toObject()
			//End if 
			//If (This.cur.seq#Null)
			//This.setSeq()
			//End if 
		End if 
	End if 
	
Function setSelected($label : Text; $value : Text)
	$c:=This:C1470.ents.indices($label+" = :1"; $value)
	$row:=$c[0]+1
	// listbox name
	OBJECT SET SCROLL POSITION:C906(*; This:C1470.name; $row)
	LISTBOX SELECT ROW:C912(*; This:C1470.name; $row)
	
	
Function setSeq
	var $line : Object
	var $seq : Integer
	$seq:=0
	For each ($line; This:C1470.ents)
		$seq:=$seq+1
		$line.seq:=$seq
	End for each 
	
	
	
	
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
	
	
	
Function setMeta($formName : Text)
	If (ds:C1482[This:C1470.dataClassName].actionBy#Null:C1517)
		$fc_o:=ds:C1482.FC.query("purpose = :1 and tableName = :2"; $formName; This:C1470.dataClassName)
		If ($fc_o.length=0)
			$fc_o:=ds:C1482.FC.new()
			$fc_o.purpose:=$formName
			$fc_o.tableName:=This:C1470.dataClassName
			$fc_o.data:=New object:C1471(This:C1470.name; New object:C1471("meta"; Null:C1517))
			
		Else 
			$fc_o:=$fc_o.first()
			If ($fc_o.data[This:C1470.name]=Null:C1517)
				$fc_o.data[This:C1470.name]:=New object:C1471("meta"; Null:C1517)
			End if 
		End if 
		If ($fc_o.data[This:C1470.name].meta=Null:C1517)
			//https://doc.4d.com/4Dv19R5/4D/19-R5/Colors.302-5831645.en.html
			$fc_o.data[This:C1470.name].meta:=New collection:C1472  // meta expression object 
			$fc_o.data[This:C1470.name].meta.push(New object:C1471(\
				"stroke"; "automatic"; \
				"fill"; "automatic"; \
				"fontStyle"; "normal"; \
				"fontWeight"; "normal"; \
				"textDecoration"; "normal"))
			
			//  [1] will underline the text
			$fc_o.data[This:C1470.name].meta.push(New object:C1471(\
				"stroke"; "red"; \
				"fill"; "automatic"; \
				"fontStyle"; "normal"; \
				"fontWeight"; "normal"; \
				"textDecoration"; "underline"))
			
			//[2] will make the text red and italic
			$fc_o.data[This:C1470.name].meta.push(New object:C1471(\
				"stroke"; "automatic"; \
				"fill"; "yellow"; \
				"fontStyle"; "normal"; \
				"fontWeight"; "normal"; \
				"textDecoration"; "normal"))
			
			//[3] will make the text red and italic
			$fc_o.data[This:C1470.name].meta.push(New object:C1471(\
				"stroke"; "dark gray"; \
				"fill"; "automatic"; \
				"fontStyle"; "normal"; \
				"fontWeight"; "normal"; \
				"textDecoration"; "normal"))
			
			//[4] will make the text red and italic
			$fc_o.data[This:C1470.name].meta.push(New object:C1471(\
				"stroke"; "blue"; \
				"fill"; "automatic"; \
				"fontStyle"; "normal"; \
				"fontWeight"; "normal"; \
				"textDecoration"; "normal"))
			
			//[5] will make the text red and italic
			$fc_o.data[This:C1470.name].meta.push(New object:C1471(\
				"stroke"; "green"; \
				"fill"; "automatic"; \
				"fontStyle"; "normal"; \
				"fontWeight"; "normal"; \
				"textDecoration"; "normal"))
			
			//[6] will make the text red and italic -- Dawn
			$fc_o.data[This:C1470.name].meta.push(New object:C1471(\
				"stroke"; "brown"; \
				"fill"; "automatic"; \
				"fontStyle"; "normal"; \
				"fontWeight"; "normal"; \
				"textDecoration"; "normal"))
			$fc_o.save()
		End if 
		Form:C1466[This:C1470.name].meta:=$fc_o.data[This:C1470.name].meta
	Else 
		Form:C1466[This:C1470.name].meta:=""
	End if 
	//If (Is Windows)
	//ST SET ATTRIBUTES(_Descriptions{_TabTitles}; ST Start text; ST End text; Attribute text size; 14)
	//Else 
	//ST SET ATTRIBUTES(_Descriptions{_TabTitles}; ST Start text; ST End text; Attribute text size; 16)
	//End if 
	
Function listClick
	This:C1470.entitySave()
	If (This:C1470.cur#Null:C1517)
		This:C1470.old:=This:C1470.cur.clone()
		This:C1470.edit:=This:C1470.cur
		$return:=This:C1470.cur.toObject()
		$new.pageNum:=1
	End if 
	$0:=$return
	
	
	//MARK:-  add
	
Function setNewLine($item_o)->$return : Object
	If (process_o.dataClassNameLines#"")
		var $return : Object
		$return:=New object:C1471
		This:C1470.dataClassName:=process_o.dataClassNameLines
		$new:=ds:C1482[This:C1470.dataClassName].new()
		//For each ($name; $new)
		//$return[$name]:=$new[$name]
		//End for each 
		
		If ((process_o.alerts.dialog) & ($item_o.alertMessage#""))
			ALERT:C41($item_o.itemNum+": "+$item_o.alertMessage)
		End if 
		If ((process_o.alerts.console) & ($item_o.alertMessage#""))
			ConsoleLog($item_o.itemNum+": "+$item_o.alertMessage)
		End if 
		$new.obHistory:=Init_ObHistory
		$new.obHistory.id.parent1:=entry_o.id
		If (entry_o.obHistory=Null:C1517)
			entry_o.obHistory:=Init_ObHistory
			If (entry_o.obHistory.id=Null:C1517)
				entry_o.obHistory.id:=New object:C1471
				entry_o.obHistory.id:=Init_ObHistory("id")
			End if 
		End if 
		
		// likely this should be done in mass when converting to a better use of id
		If (entry_o.obHistory.id.parent1#Null:C1517)
			$new.obHistory.id.parent2:=entry_o.obHistory.id.parent1
		End if 
		Case of 
			: (process_o.dataClassNameLines="OrderLine")
				$new.customerID:=entry_o.customerID
				$new.idNumOrder:=entry_o.idNum
			: (process_o.dataClassNameLines="ProposalLine")
				$new.customerID:=entry_o.customerID
				$new.idNumProposal:=entry_o.idNum
				
			: (process_o.dataClassNameLines="InvoiceLine")
				$new.customerID:=entry_o.customerID
				$new.idNumInvoice:=entry_o.idNum
				$new.idNumOrder:=entry_o.idNumOrder
				
			: (process_o.dataClassNameLines="POLine")
				$new.vendorID:=entry_o.vendorID
				$new.idNumPO:=entry_o.idNum
		End case 
		$new.seq:=This:C1470.ents.length+1
		$new.itemNum:=$item_o.itemNum
		$new.qty:=$item_o.qtySaleDefault
		$new.taxJuris:=$item_o.taxID
		$new.description:=$item_o.description
		$new.itemNumAlt:=$item_o.mfrItemNum
		$new.printNot:=$item_o.printNot
		// catalogs
		$new.unitPrice:=$item_o.priceA
		$new.discount:=0
		$new.unitCost:=$item_o.costMSC
		$new.unitofMeasure:=$item_o.unitOfMeasure
		$new.obSerial:=New object:C1471
		$new.obGeneral:=New object:C1471
		$new.obItem:=New object:C1471
		
		process_o.entry_o.changed:=True:C214
		var $status : Object
		$status:=$new.save()
		$return:=$new.toObject()
		This:C1470.ents.insert(This:C1470.ents.length; $return)
		This:C1470.calcLine(This:C1470.cur)
		This:C1470.cur:=$return
		DB_SaveDinventory(process_o.dataClassNameLines; $new; $return; "New line")
	End if 
	
	
	//MARK:-  calc
	
Function calcQty($qty : Real)
	//var $line : Object
	If (This:C1470.sel#Null:C1517)
		For each ($line; This:C1470.sel)
			$line.qty:=$qty
			$line.changed:=True:C214
			This:C1470.calcLine($line)
		End for each 
		This:C1470.redraw()
	End if 
	
Function calcPrice($price : Real)
	If (This:C1470.sel#Null:C1517)
		For each ($line; This:C1470.sel)
			$line.unitPrice:=$price
			$line.changed:=True:C214
			This:C1470.calcLine($line)
		End for each 
		This:C1470.redraw()
	End if 
	
Function calcDiscount($discount : Real)
	If (This:C1470.sel#Null:C1517)
		For each ($line; This:C1470.sel)
			$line.discount:=$discount
			$line.changed:=True:C214
			This:C1470.calcLine($line)
		End for each 
		This:C1470.redraw()
	End if 
	
Function calcUnitPrice($unitPrice : Real)
	If (This:C1470.sel#Null:C1517)
		For each ($line; This:C1470.sel)
			$line.unitPrice:=$unitPrice
			$line.changed:=True:C214
			This:C1470.calcLine($line)
		End for each 
		This:C1470.redraw()
	End if 
	
	
Function calcLine($line : Object)
	If (Count parameters:C259=0)
		$line:=This:C1470.cur
	End if 
	
	If ($line=Null:C1517)
		$line:=This:C1470.cur
	End if 
	process_o.entry_o.changed:=True:C214
	// This is the collection of lines. cur is the line to calculate
	//This.dataClassName:=This.dataClassName
	If ($line=Null:C1517)
		// loop through objects named _TOTAL@ and set to zero
		OBJECT Get pointer:C1124(Object named:K67:5; "_TOTAL_LB_Lines_qty_")->:=0
		OBJECT Get pointer:C1124(Object named:K67:5; "_TOTAL_LB_Lines_cnt_")->:=0
		If (OBJECT Get pointer:C1124(Object named:K67:5; "_TOTAL_LB_Lines_qtyBackLogged_")#Null:C1517)
			OBJECT Get pointer:C1124(Object named:K67:5; "_TOTAL_LB_Lines_qtyBackLogged_")->:=0
		End if 
		If (OBJECT Get pointer:C1124(Object named:K67:5; "_TOTAL_LB_Lines_extendedPrice_")#Null:C1517)
			OBJECT Get pointer:C1124(Object named:K67:5; "_TOTAL_LB_Lines_extendedPrice_")->:=0
		End if 
		If (OBJECT Get pointer:C1124(Object named:K67:5; "_TOTAL_LB_Lines_extendedCost_")#Null:C1517)
			OBJECT Get pointer:C1124(Object named:K67:5; "_TOTAL_LB_Lines_extendedCost_")->:=0
		End if 
		
		
	Else 
		
		If (process_o.dataClassName="PO")
			
		Else 
			
			$line.discountedPrice:=Round:C94($line.unitPrice*(1-(0.01*$line.discount)); Storage:C1525.precision.currency)
			$line.extendedPrice:=$line.qty*$line.discountedPrice
			$line.extendedCost:=$line.qty*$line.unitCost
			$line.extendedWt:=$line.qty*$line.unitWt
		End if 
		Case of 
			: (process_o.dataClassName="Order")
				var $thePrec : Integer
				$thePrec:=2
				$line.qtyBackLogged:=$line.qty-$line.qtyShipped
				$line.discountedPrice:=Round:C94($line.unitPrice*(1-(0.01*$line.discount)); Storage:C1525.precision.currency)
				$line.extendedPrice:=$line.qty*$line.discountedPrice
				$line.extendedCost:=$line.qty*$line.unitCost
				$line.extendedWt:=$line.qty*$line.unitWt
				$line.qtyBackLogged:=$line.qty-$line.qtyShipped
				
				entry_o.lineCount:=This:C1470.ents.length
				entry_o.amount:=This:C1470.ents.sum("extendedPrice")
				entry_o.salesTax:=This:C1470.ents.sum("salesTax")
				entry_o.weightEstimate:=This:C1470.ents.sum("extendedWt")
				OBJECT Get pointer:C1124(Object named:K67:5; "_TOTAL_LB_Lines_qty_")->:=This:C1470.ents.sum("qty")
				OBJECT Get pointer:C1124(Object named:K67:5; "_TOTAL_LB_Lines_qtyBackLogged_")->:=This:C1470.ents.sum("qtyBackLogged")
				OBJECT Get pointer:C1124(Object named:K67:5; "_TOTAL_LB_Lines_extendedPrice_")->:=entry_o.amount
				OBJECT Get pointer:C1124(Object named:K67:5; "_TOTAL_LB_Lines_cnt_")->:=This:C1470.ents.length
				//OBJECT Get pointer(Object named; "_TOTAL_TEXT_Quantity")->:=Get localized string("Total")
				//OBJECT Get pointer(Object named; "_TOTAL_TEXT_Total")->:=Get localized string("Total")
				//Form.editEntity.Tax:=Form.editEntity.Invoices_to_Invoice_Lines.sum("")
				
				
		End case 
		
	End if 
	
Function dropItems($items : Object)
	Case of 
		: (dragFrom="_LB_Item_")
			If ($items#Null:C1517)
				var $oLine : Object
				For each ($o; $items)
					//$oLine:=New object
					//$oLine:=cs.cLine.new("OrderLine"; $o; process_o)
					//LB_Lines.ents.insert(LB_Lines.ents.length; $oLine)
					LB_Lines.setNewLine($o)
					//$oLine.calc("OrderLine"; LB_Lines.ents[LB_Lines.ents.length-1])
				End for each 
			End if 
			dragFrom:=""
			
		: (FORM Event:C1606.objectName="LB_Lines")
			var $to; $seq; $start; $span; $cnt : Integer
			For each ($line; This:C1470.ents)
				$line.seq:=0
			End for each 
			//skip past last line
			$to:=FORM Event:C1606.row
			If ($to=0)
				$start:=This:C1470.ents.length-This:C1470.sel.length
				$span:=This:C1470.ents.length-This:C1470.sel.length-1
			Else 
				$span:=$to+This:C1470.sel.length-1
				$start:=$to-1
			End if 
			$seq:=0
			$seq:=$start
			For each ($line; This:C1470.sel)
				$seq:=$seq+1
				$line.seq:=$seq
			End for each 
			
			$cnt:=0
			$seq:=0
			For each ($line; This:C1470.ents)
				$cnt:=$cnt+1
				If ($cnt=$to)
					$seq:=$span
				End if 
				If ($line.seq=0)  // not part of sel
					$seq:=$seq+1
					$line.seq:=$seq
				End if 
				$line.change:=True:C214
			End for each 
			This:C1470.ents:=This:C1470.ents.orderBy("seq asc")
			This:C1470.redraw()
			
			
			
	End case 
	
	
	
	
	
	
Function setRecord($record_o : Object)->$result : Collection
	// build a collection of field names and values for a record
	If ($record_o#Null:C1517)
		var $result : Collection
		$result:=New collection:C1472
		//This.dataClassName:=$record_o.getInfo().tableName
		This:C1470.dataClass:=$record_o.getDataClass()
		For each ($name; This:C1470.dataClass)
			Case of 
				: (This:C1470.dataClass[$name].type="blob")
				: (This:C1470.dataClass[$name].type="object")
				Else 
					$result.push(New object:C1471("name"; $name; "value"; $record_o[$name]))
			End case 
		End for each 
		$result.orderBy("name")
	End if 
	
Function setImage($path : Text)->$result : Picture
	var $image : Picture
	var $file_o : Object
	$file_o:=File:C1566($path)
	Case of 
		: ($path="")
			$path:=Storage:C1525.images.noImage
			//$result:=READ PICTURE FILE($path)
			READ PICTURE FILE:C678($path; $result)
		: ($path="http@")
			var $answer : Object
			$status:=HTTP Get:C1157($path; $answer)
		: ($file_o.exists($path))
			// see if this cares about System or not
			READ PICTURE FILE:C678($path; $result; *)
		: (False:C215)  // set server file
			$vtPath:=PathToSystem(vImagePath)
			$viResult:=Test path name:C476($vtPath)
		: (False:C215)  // check web
			Case of 
				: ($viResult=1)
					//READ PICTURE FILE($vtPath;$thePict)
					OPEN URL:C673($vtPath)
				: ($viResult=0)
					ConsoleLog("ERROR: Path is a folder")
				Else 
					ConsoleLog("ERROR: "+String:C10($viResult)+"  FILE NOT FOUND\r"+$vtPath)
			End case 
	End case 
	
	
Function insert($index : Integer; $element : Variant)->$result : Object
	// attempts to add the element into data
	// only supports collections
	
	If (Num:C11(This:C1470.kind)=Is collection:K8:32)
		This:C1470.source.insert($index; $element)
		This:C1470.ents.insert($index; This:C1470.source[$index])
		This:C1470.redraw()
		TRACE:C157
		//$result:=result_object(True)
	Else 
		TRACE:C157
		//$result:=result_object(False; "Can only insert into collections. ")
	End if 
	
	
	//MARK:-  save
	
Function saveAll()
	If (process_o.dataClassNameLines#"")
		var $record : Object
		var $parent_o : Object
		$parent_o:=ds:C1482[process_o.dataClassName].query("id = :1"; entry_o.id).first()
		For each ($line; This:C1470.ents)
			var $dinv_o : Object
			var $doSave : Integer
			$doSave:=0
			$record:=Null:C1517
			
			If ($line.changed)
				$record:=ds:C1482[process_o.dataClassNameLines].query("idNum = :1"; $line.idNum).first()
				//If ($record=Null)
				//$record:=ds[process_o.dataClassNameLines].new()
				//End if 
				DB_SaveDinventory(process_o.dataClassNameLines; $record; $line; "update")
				// create dInventory then save record
				// $record:=$line.fromObject()
				DB_SaveObjectToRecord($line; $record)
			End if 
		End for each 
	End if 
	$parent_o:=New object:C1471
	//var $line_o; $orig_o : Object
	//For each ($line; LB_Lines.sel)
	//If ($orig_o.obHistory=Null)
	//$orig_o.obHistory:=New object("old"; New collection)
	//$orig_o.obHistory.old.push(New object(Current date; $orig_o.toObject()))
	//$orig_o.obHistory:=New object("dInventory"; New collection)
	//End if 
	//Case of 
	//: ($line.changed=Null)
	//// no change
	//: ($line.id="")
	//// new line
	//: ($line.changed)
	//$orig_o:=ds[process_o.dataClassNameLines].query("id = :1"; $line.id)
	
	//End case 
	//End for each 
	
	
Function saveOne($line : Object)
	
	
	
/*
	
"LB_Tables": {
"type": "listbox",
"dataSource": "Form:C1466.LB_Tables.ents",
"top": 345,
"left": 1130,
"width": 229,
"height": 298,
"visibility": "visible",
"sizingX": "move",
"sizingY": "fixed",
"headerHeight": "1em",
"listboxType": "collection",
"scrollbarHorizontal": "automatic",
"scrollbarVertical": "automatic",
"resizingMode": "legacy",
"currentItemSource": "Form:C1466.LB_Table.cur",
"currentItemPositionSource": "Form:C1466.LB_Table.pos",
"selectedItemsSource": "Form:C1466.LB_Table.sel",
"class": "cssInput16",
"events": [
"onLoad",
"onDoubleClick"
],
"selectionMode": "single",
"showHeaders": true,
"method": "ObjectMethods/LB_Tables.4dm",
"borderStyle": "double",
"alternateFill": "#FFFCCC",
"metaSource": "metaExpression",
	
*/
	
	
	//MARK:-  Edit
	// build string of object values a collection.join(";")
	
	
	//MARK:-  FC
Function _getFC($input_o : Object)
	If ($input_o=Null:C1517)
		// NOTENOW: fix the FC records.
		$input_o:=New object:C1471(\
			"purpose"; "setup"; \
			"dataClassName"; This:C1470.dataClassName; \
			"name"; This:C1470.name; \
			"role"; Storage:C1525.user.role)
	End if 
	
	This:C1470.fc:=STR_FCGet($input_o)
	
	This:C1470._viewArrayFC()
	
	// set this outside the listbox setup
	// pass it process_o.source
	//This.setSource()
	
	
Function _createFC($o : Object)
	
	var $input_o : Object
	$input_o:=New object:C1471
	// which list box, entry, or something else
	$input_o.purpose:="listboxSetup"
	$input_o.dataClassName:=This:C1470.dataClassName
	// name of the listbox
	$input_o.name:=This:C1470.name
	$input_o.view:="default"
	This:C1470.fc:=STR_FCGet($input_o)
	If (Form:C1466.fcNew#This:C1470.fc)
		Form:C1466.fcNew:=This:C1470.fc
	End if 
	
	This:C1470._viewArrayFC()
	
Function _setFCByID($id : Text)->$fc_o : Object
	$fc_o:=Null:C1517
	If ($id#"")
		$fc_o:=ds:C1482.FC.query("id = :1"; $id).first()
	End if 
	
	// need for listboxes, entry, and detail other uses of FC
Function _fixFCdata($fields : Text; $columns : Collection; $lbValues : Object)
	If ($fields="")
		$fields:="id"
	End if 
	If ($columns=Null:C1517)
		var $fields_c : Collection
		var $fieldName : Text
		$fields_c:=Split string:C1554($fields; ",")
		For each ($fieldName; $fields_c)
			$columns.push(LBX_ColumnFromName($fc_o.tableName; $fieldName))
		End for each 
	End if 
	
	
Function _viewChoicesFC()->$popUpList : Text
	
	var $c; $d : Collection
	$d:=New collection:C1472
	// HOWTO:popup
	For each ($name; This:C1470.fc.data.views)
		$d.push($name)
	End for each 
	$d:=$d.orderBy()
	var $popUpList : Text
	$popUpList:=$d.join(";")
	
	$popUpList:="From list;From string;Save;Save New;-;Delete View;-;"+$popUpList
	
	If (Not:C34(Undefined:C82(aViewsList)))
		aViewsList:=Find in array:C230(aViewsList; This:C1470.view)
	End if 
	
Function _viewArrayFC()
	// set the outside selection array popup
	$popUpList:=This:C1470._viewChoicesFC()
	var $viewList_c : Collection
	$viewList_c:=New collection:C1472
	$viewList_c:=Split string:C1554($popUpList; ";")
	ARRAY TEXT:C222(aViewsList; 0)
	COLLECTION TO ARRAY:C1562($viewList_c; aViewsList)
	
	If (Not:C34(Undefined:C82(aViewsList)))
		aViewsList:=Find in array:C230(aViewsList; This:C1470.view)
	End if 
	
	
	
	//MARK:- PopUps
	
	//MARK:- RightClick
	// 
Function _popupRightClick()
	var $popUpList : Text
	$popUpList:=This:C1470._popupFieldsRightClick()
	var $c : Collection
	
	$c:=Split string:C1554($popUpList; ";")
	$select:=Pop up menu:C542($popUpList)
	var $columnNum : Integer
	$columnNum:=0
	If (FORM Event:C1606.column#Null:C1517)
		$columnNum:=FORM Event:C1606.column
	End if 
	Case of 
		: ($select>8)  // 5 is a placeholder, > 5 adds a new column
			
			$sourceName:=$c[$select-1]
			This:C1470._setColumnByFieldName($sourceName; $columnNum)
			
		: ($select=1)  //"Delete Column" 
			This:C1470._deleteColumn($columnNum)
			
		: ($select=2)  //($popup{$select}="Add Formula")
			This:C1470._addFormulaColumn($columnNum)  // pass in the columnNum
			
		: ($select=3)  //($popup{$select}="From list")
			This:C1470._setColumnsFromList()
			
		: ($select=4)  //($popup{$select}="From string")
			This:C1470._setColumnsString(This:C1470.fc.data.views[This:C1470.view].fields)
			
		: ($select=5)  // "Save"
			This:C1470.fc.data.views[This:C1470.view].columns:=This:C1470.getColumns().columns
			This:C1470.fc.save()
			SF_cur.fc.save()
			
		: ($select=6)  // "Save New"
			This:C1470._popupSaveNewView()
			
		: ($select=6)  // "Save New"
			This:C1470._popupSaveNewView()
			
			
	End case 
	//End if 
	
Function _popupSaveNewView()
	var $viewName : Text
	var $c; $c2 : Collection
	var $duplicate_i; $counter : Integer
	$viewName:=Request:C163("Enter name of new view"; This:C1470.view)
	If ((OK=1) & ($viewName#""))
		$c:=New collection:C1472
		$counter:=-1
		For each ($view; This:C1470.fc.data.views)
			$counter:=$counter+1
			If ($view=$viewName)
				$duplicate_i:=1
				break
			End if 
		End for each 
		
		If ($duplicate_i=1)
			CONFIRM:C162("Overwrite exiting: "+$view)
			If (OK=1)
				This:C1470.view:=$view
				This:C1470.fc.data.views[This:C1470.view].columns:=This:C1470.getColumns().columns
				
				This:C1470.fc.data.views[This:C1470.view].entry:=New object:C1471("fields"; ""; "subform"; New object:C1471)
				
				
				This:C1470.fc.save()
			End if 
		Else 
			// $viewName is not currently in fc so use existing view name
			This:C1470.fc.data.views[$viewName]:=New object:C1471("name"; $viewName; \
				"fieldsList"; This:C1470.fc.data.views[This:C1470.view].fields; \
				"columns"; This:C1470.fc.data.views[This:C1470.view].columns; \
				"sfColumns"; Null:C1517)
			This:C1470.fc.save()
			// $viewName is not currently in fc so use existing view name
			SF_cur.fc.views[$viewName]:=New object:C1471("name"; $viewName; \
				"fieldsEntry"; SF_cur.fc.data.views[This:C1470.view].fields; \
				"sfEntry"; Null:C1517)
			SF_cur.fc.save()
			// do this is cEntry also
			
			// this is defective
			This:C1470._viewArrayFC()
			// This._buildViewChoices()
			
			// this should be done when changes are made
			//This.setColumns()
		End if 
	End if 
	
Function _popupFieldsRightClick()->$popup : Text
	// build list of unused fields...
	LISTBOX GET ARRAYS:C832(*; This:C1470.name; $aColNames_t; $aHeaderNames_t; $aColVars_p; $aHeaderVars_p; $aColsVisible_b; $aStyles_p)
	For each ($field; This:C1470.dataClass)
		$fieldobject:=This:C1470.dataClass[$field]
		$pos:=Find in array:C230($aColNames_t; "Column_"+This:C1470.dataClassName+"_"+$field+"_")
		If ($pos<0)
			If (($fieldobject.fieldType#Is BLOB:K8:12) & ($fieldobject.fieldType#Is picture:K8:10) & ($fieldobject.fieldType#Is object:K8:27))
				$popup:=$popup+$field+";"
			End if 
		End if 
	End for each 
	$popup:=Substring:C12($popup; 1; Length:C16($popup)-1)
	$c:=Split string:C1554($popup; ";")
	
	// sort by name
	$c:=$c.orderBy(ck ascending:K85:9)
	$popup:=$c.join(";")
	$popup:="Delete Column;Add Formula;From list;From string;Save;Save New;Shift to Change Views;--; "+$popup
	
	
	
Function _addFormulaColumn($columnNum : Integer)
	$formula:=Request:C163("Formula (this.field)")
	If (OK=1)
		C_POINTER:C301($nullpointer)
		If ($formula="this.@")
			$title:=Substring:C12($formula; 6)
		Else 
			$title:=$formula
		End if 
		LISTBOX INSERT COLUMN FORMULA:C970(*; This:C1470.name; $columnNum+1; $title; $formula; Is text:K8:3; $title; $nullpointer)
		OBJECT SET TITLE:C194(*; $title; $title)
	End if 
	
	
Function _deleteColumn($select_i)
	LISTBOX DELETE COLUMN:C830(*; This:C1470.name; $select_i)
	
	
	
	
	
	
	
	//MARK:- Shift Click
	
Function _popupBuild()->$popUpList : Text
	var $c; $d : Collection
	$d:=New collection:C1472
	// HOWTO:popup
	For each ($name; This:C1470.fc.data.views)
		$d.push($name)
	End for each 
	$d.orderBy()
	var $popUpList : Text
	$popUpList:=$d.join(";")
	
	$popUpList:="From list;From string;Save;Save New;-;Delete View;-;"+$popUpList
	
Function _popupViewShiftClick()
	// 
	var $c : Collection
	$c:=Split string:C1554("From list;From string;Save;Save New;-;Delete View;-;"; ";")
	$select:=Pop up menu:C542($popUpList)
	This:C1470._popupViewSelected($c[$select-1])
	
Function _popupName($arrayName : Text)
	//aViewsList
	If ($arrayName="")
		$arrayName:="aViewsList"
	End if 
	var $ptArray : Pointer
	$ptArray:=Get pointer:C304($arrayName)
	If (Not:C34(Is nil pointer:C315($ptArray)))
		$ptArray->:=Find in array:C230($ptArray->; This:C1470.view)
	End if 
	
Function _popupViewSelected($selectValue : Text; $outSidePopup : Text)
	var $c : Collection
	$c:=Split string:C1554("From list;From string;Save;Save New;-;Delete View;-;"; ";")
	Case of 
		: ($selectValue="Delete View")
			If ($selectValue#"default")
				
				
				This:C1470._popupName()
			End if 
		: ($selectValue="From list")
			This:C1470._setColumnsFromList()
			
		: ($selectValue="From string")
			This:C1470._setColumnsString(This:C1470.fc.data.views[This:C1470.view].fields)
			
		: ($selectValue="Save")
			This:C1470.fc.data.views[This:C1470.view].columns:=LB_DataBrowser.getColumns().columns
			This:C1470.fc.save()
			SF_cur.fc.save()
			
		: ($selectValue="Save New")
			This:C1470._popupSaveNewView()
			
		: (This:C1470.fc.data.views[$selectValue]#Null:C1517)  // "Shift to Change views"
			This:C1470.view:=$selectValue
			This:C1470.setColumns(This:C1470.fc.data.views[This:C1470.view].columns)
			
	End case 
	
	
	
	
	
	
	
	
	//MARK:- Build
	
	
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
	
Function _setColumnByFieldName($field : Text; $postion : Integer)
	// 1 field: uses the name of the field to create a column and sets it into the listbox
	var $column_o : Object
	$column_o:=This:C1470._setColumnName($field; "")
	If ($column_o#Null:C1517)
		This:C1470._setColumnConstruct($postion; $column_o)
	End if 
	
Function _setColumnConstruct($position : Integer; $column_o : Object)
	// constructs column and put it into the listbox at a position
	var $nullpointer : Pointer
	$nullpointer:=Null:C1517
	$field_t:=Replace string:C233($column_o.dataSource; "This."; "")
	If ($column_o.header.text="")
		$column_o.header.text:=$field_t
		If ($doCaps)
			$column_o.header.text:=Uppercase:C13($field_t[[1]])+Substring:C12($field_t; 2)
		End if 
	End if 
	If ($column_o.fieldType=Null:C1517)
		$column_o.fieldType:=ds:C1482[This:C1470.dataClassName][$field_t].fieldType
	End if 
	
	If (True:C214)  // so this can be condensed
		
		
		
		LISTBOX INSERT COLUMN FORMULA:C970(*; This:C1470.name; $position; \
			$column_o.name; $column_o.dataSource; $column_o.fieldType; \
			$column_o.header.name; $nullpointer; $column_o.footer.name; $nullpointer)
		OBJECT SET TITLE:C194(*; $column_o.header.name; $column_o.header.text)
		
		
		If ($column_o.enterable=Null:C1517)
			OBJECT SET ENTERABLE:C238(*; $column_o.name; False:C215)
		End if 
		
		If ($column_o.turncate=Null:C1517)
			LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk truncate:K53:37; lk without ellipsis:K53:64)
		Else 
			LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk truncate:K53:37; $column_o.turncate)
		End if 
		//  lk without ellipsis = , lk with ellipsis = 
		
		
		
		If ($column_o.width=Null:C1517)
			LISTBOX SET COLUMN WIDTH:C833(*; $column_o.name; 100)
		Else 
			LISTBOX SET COLUMN WIDTH:C833(*; $column_o.name; $column_o.width)
		End if 
		
		If ($column_o.format#Null:C1517)
			
			OBJECT SET FORMAT:C236(*; $column_o.name; $column_o.format)
			//$column_o.format:=OBJECT Get format(*; $column_o.name)  // 1
		End if 
		
		
		If ($column_o.align#Null:C1517)
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $column_o.name; $column_o.align)
			//$column_o.align:=OBJECT Get horizontal alignment(*; $column_o.name)
		End if 
		
		If ($column_o.wordWrap#Null:C1517)  // boolean
			LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk allow wordwrap:K53:39; $column_o.wordWrap)
			// $column_o.wordWrap:=LISTBOX Get property(*; $column_o.name; lk allow wordwrap)
		End if 
		
		If ($column_o.bgColor#Null:C1517)
			LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk background color expression:K53:47; $column_o.bgColor)
			// $column_o.bgColor:=LISTBOX Get property(*; $column_o.name; lk background color expression)
		End if 
		
		If ($column_o.fontColor#Null:C1517)
			LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk font color expression:K53:48; $column_o.fontColor)
			//$column_o.fontColor:=LISTBOX Get property(*; $column_o.name; lk font color expression)
		End if 
		
		If ($column_o.widthMin#Null:C1517)  // integer
			LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk column min width:K53:50; $column_o.widthMin)
			// $column_o.widthMin:=LISTBOX Get property(*; $column_o.name; lk column min width)
		End if 
		
		If ($column_o.widthMax#Null:C1517)  // integer
			LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk column max width:K53:51; $column_o.widthMax)
			//$column_o.widthMax:=LISTBOX Get property(*; $column_o.name; lk column max width)
		End if 
		
		If ($column_o.resizable#Null:C1517)  // boolean
			LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk column resizable:K53:40; $column_o.resizable)
			// $column_o.resizable:=LISTBOX Get property(*; $column_o.name; lk column resizable)
		End if 
		
		If ($column_o.displayType#Null:C1517)
			LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk display type:K53:46; $column_o.displayType)
			//  lk numeric format
			//  
			//  Display Type property for numeric columns
			//  $column_o.displayType:=LISTBOX Get property(*; $column_o.name; lk display type)
		End if 
		
		
		If ($column_o.doubleClick#Null:C1517)  // integer
			//LISTBOX SET PROPERTY(*; $column_o.name; lk double click on row; lk do nothing ||  lk edit record  || lk display record)
			// $column_o.resizable:=LISTBOX Get property(*; $column_o.name; lk double click on row)
			// LISTBOX SET PROPERTY(*; $column_o.name; lk detail form name; vFormName_t)
		End if 
	End if 
	
	This:C1470.fc.data.views[This:C1470.view].columns.push($column_o)
	
	ON ERR CALL:C155("")
	
Function _setColumnNameImport($fieldName_t : Text; $columnAdder_t : Text; $type : Integer)->$column_o : Object
	// names the header, column and footer
	$column_o:=New object:C1471
	//$column_o.name:="Column_"+This.dataClassName+"_"+$fieldName_t+"_"+$columnAdder_t
	$column_o.name:="Column_Import_"+$fieldName_t+"_"+$columnAdder_t
	$column_o.dataSource:="This."+$fieldName_t
	$column_o.fieldType:=$type
	
	$column_o.header:=New object:C1471("name"; "Header_Import_"+$fieldName_t+"_"+$columnAdder_t; \
		"text"; $fieldName_t)
	
	$column_o.footer:=New object:C1471("name"; "Footer_Import_"+$fieldName_t+"_"+$columnAdder_t)
	
	$column_o.width:=100
	$column_o.alignment:=Align left:K42:2
	$column_o.alignment:=Align left:K42:2
	
	
	// Fix_QQQ by: Bill James (2022-12-17T06:00:00Z)
	// have these values set by an FC record and/or Storage
	Case of 
		: (($column_o.fieldType=Is alpha field:K8:1) | ($column_o.fieldType=Is text:K8:3) | ($column_o.fieldType=Is string var:K8:2))
			Case of 
				: ($fieldName_t="@phone@")
					$column_o.width:=100
					$column_o.alignment:=Align left:K42:2
					$column_o.format:="(###) ###-#### #### ####"
				: ($fieldName_t="@creditcardnum@")
					$column_o.alignment:=Align left:K42:2
					$column_o.format:="xxxx-xxxx-xxxx-####"
				: ($fieldName_t="@zip@")
					$column_o.width:=70
				: ($fieldName_t="state")
					$column_o.width:=60
				: ($fieldName_t="@description@")
					$column_o.width:=220
			End case 
			
		: ($column_o.fieldType=Is time:K8:8)
			//timeFormatstring"systemShort", "systemMedium", "systemLong", 
			//"iso8601", "hh_mm_ss", "hh_mm", "hh_mm_am", "mm_ss", 
			//"HH_MM_SS", "HH_MM", "MM_SS", "blankIfNull" 
			//(can be combined with the other possible values) 
			//https://developer.4d.com/docs/FormObjects/pr\
																																																																																								opertiesDisplay#date-format
			
			
			$column_o.width:=70
			$column_o.alignment:=Align center:K42:3
			// use the default 
			//$column_o.format:="systemShort"
			//$column_o.format:="hh_mm_am"
			//$column_o.format:=HH MM AM PM
			//OBJECT SET FORMAT(*; $vtColumnName; HH MM AM PM))  // 5   Char(HH MM AM PM)
			
		: ($column_o.fieldType=Is date:K8:7)
			//dateFormatstring"systemShort", "systemMedium", "systemLong", "iso8601",\
																																																																																								 "rfc822", "short", "shortCentury", "abbreviated", "long", "blankIfNull"
			// https://developer.4d.com/docs/FormObjects/propertiesDisplay#date-format
			$column_o.width:=70
			$column_o.alignment:=Align center:K42:3
			// us the default format to avoid having the full year
			//$column_o.format:="systemShort"  
			// this should return the 2-digit year 
			// but returned 4, which is the internal date short
			
			//  
			//$column_o.format:=System date short
			
			
		: ($column_o.fieldType=Is boolean:K8:9)
			$column_o.width:=40
			$align:=Align center:K42:3
			$column_o.format:=" "
			//LISTBOX SET COLUMN WIDTH(*; $vtColumnName; 40)
			//OBJECT SET HORIZONTAL ALIGNMENT(*; $vtColumnName; Align center)
			
			
		: ($column_o.fieldType=Is real:K8:4)
			$column_o.width:=100
			Case of 
				: (($fieldName_t="@cost@") | ($fieldName_t="@price@"))
					$column_o.format:="###,###,###,###,##0.00"
					
				: (($fieldName_t="@rate@") | ($fieldName_t="discount"))
					$column_o.format:="###,###,##0.0"
					
				: ($fieldName_t="@wt@")
					$column_o.width:=60
					$column_o.format:="###,###,##0.0"
					
				: ($fieldName_t="@tax@")
					$column_o.width:=70
					$column_o.format:="###,###,###,###,##0.00"
				Else 
					
			End case 
			
		: ($column_o.fieldType=Is integer:K8:5)
			$column_o.width:=100
			$column_o.alignment:=Align right:K42:4
			Case of 
				: ($fieldName_t="DT@")
					
					
					
			End case 
	End case 
	
	
	
	
Function _setColumnName($fieldName_t : Text; $columnAdder_t : Text)->$column_o : Object
	// names the header, column and footer
	$column_o:=New object:C1471
	$column_o.name:="Column_"+This:C1470.dataClassName+"_"+$fieldName_t+"_"+$columnAdder_t
	$column_o.dataSource:="This."+$fieldName_t
	$column_o.fieldType:=This:C1470.dataClass[$fieldName_t].fieldType
	
	$column_o.header:=New object:C1471("name"; "Header_"+This:C1470.dataClassName+"_"+$fieldName_t+"_"+$columnAdder_t; \
		"text"; $fieldName_t)
	
	$column_o.footer:=New object:C1471("name"; "Footer_"+This:C1470.dataClassName+"_"+$fieldName_t+"_"+$columnAdder_t)
	
	$column_o.width:=100
	$column_o.alignment:=Align left:K42:2
	$column_o.alignment:=Align left:K42:2
	
	
	// Fix_QQQ by: Bill James (2022-12-17T06:00:00Z)
	// have these values set by an FC record and/or Storage
	Case of 
		: (($column_o.fieldType=Is alpha field:K8:1) | ($column_o.fieldType=Is text:K8:3) | ($column_o.fieldType=Is string var:K8:2))
			Case of 
				: ($fieldName_t="@phone@")
					$column_o.width:=100
					$column_o.alignment:=Align left:K42:2
					$column_o.format:="(###) ###-#### #### ####"
				: ($fieldName_t="@creditcardnum@")
					$column_o.alignment:=Align left:K42:2
					$column_o.format:="xxxx-xxxx-xxxx-####"
				: ($fieldName_t="@zip@")
					$column_o.width:=70
				: ($fieldName_t="state")
					$column_o.width:=60
				: ($fieldName_t="@description@")
					$column_o.width:=220
			End case 
			
		: ($column_o.fieldType=Is time:K8:8)
			//timeFormatstring"systemShort", "systemMedium", "systemLong", 
			//"iso8601", "hh_mm_ss", "hh_mm", "hh_mm_am", "mm_ss", 
			//"HH_MM_SS", "HH_MM", "MM_SS", "blankIfNull" 
			//(can be combined with the other possible values) 
			//https://developer.4d.com/docs/FormObjects/pr\
																																																																																																																																opertiesDisplay#date-format
			
			
			$column_o.width:=70
			$column_o.alignment:=Align center:K42:3
			// use the default 
			//$column_o.format:="systemShort"
			//$column_o.format:="hh_mm_am"
			//$column_o.format:=HH MM AM PM
			//OBJECT SET FORMAT(*; $vtColumnName; HH MM AM PM))  // 5   Char(HH MM AM PM)
			
		: ($column_o.fieldType=Is date:K8:7)
			//dateFormatstring"systemShort", "systemMedium", "systemLong", "iso8601",\
																																																																																																																																 "rfc822", "short", "shortCentury", "abbreviated", "long", "blankIfNull"
			// https://developer.4d.com/docs/FormObjects/propertiesDisplay#date-format
			$column_o.width:=70
			$column_o.alignment:=Align center:K42:3
			// us the default format to avoid having the full year
			//$column_o.format:="systemShort"  
			// this should return the 2-digit year 
			// but returned 4, which is the internal date short
			
			//  
			//$column_o.format:=System date short
			
			
		: ($column_o.fieldType=Is boolean:K8:9)
			$column_o.width:=40
			$align:=Align center:K42:3
			$column_o.format:=" "
			//LISTBOX SET COLUMN WIDTH(*; $vtColumnName; 40)
			//OBJECT SET HORIZONTAL ALIGNMENT(*; $vtColumnName; Align center)
			
			
		: ($column_o.fieldType=Is real:K8:4)
			$column_o.width:=100
			Case of 
				: (($fieldName_t="@cost@") | ($fieldName_t="@price@"))
					$column_o.format:="###,###,###,###,##0.00"
					
				: (($fieldName_t="@rate@") | ($fieldName_t="discount"))
					$column_o.format:="###,###,##0.0"
					
				: ($fieldName_t="@wt@")
					$column_o.width:=60
					$column_o.format:="###,###,##0.0"
					
				: ($fieldName_t="@tax@")
					$column_o.width:=70
					$column_o.format:="###,###,###,###,##0.00"
				Else 
					
			End case 
			
		: ($column_o.fieldType=Is integer:K8:5)
			$column_o.width:=100
			$column_o.alignment:=Align right:K42:4
			Case of 
				: ($fieldName_t="DT@")
					
					
					
			End case 
	End case 
	
Function _setColumnsStringCollection($fields_t : Text)
	ASSERT:C1129($fields_t#""; "No list of fields passed")
	
	
	//This._deleteColumns()
	LISTBOX DELETE COLUMN:C830(*; This:C1470.name; 1; \
		LISTBOX Get number of columns:C831(*; This:C1470.name))
	
	var $fields_c; $columns_c : Collection
	$columns_c:=New collection:C1472
	var $field : Text
	var $postion : Integer
	$postion:=0
	$fields_c:=Split string:C1554($fields_t; ";")
	var $column_o : Object
	$column_o:=New object:C1471
	For each ($field; $fields_c)
		var $type : Integer
		$type:=Value type:C1509($field)
		
		$postion:=$postion+1
		$column_o:=LB_Import._setColumnNameImport($field; $postion; $type)
		This:C1470._setColumnConstruct($postion; $column_o)
	End for each 
	
	
	
	
	
	
	
Function _setColumnsString($fields_t : Text)
	// splits a string builds the columns and installs column into the listbox
	// only internal data
	//This._deleteColumns()
	LISTBOX DELETE COLUMN:C830(*; This:C1470.name; 1; \
		LISTBOX Get number of columns:C831(*; This:C1470.name))
	
	
	// should check this, but wrong syntax
	var $fields_c; $columns_c : Collection
	$columns_c:=New collection:C1472
	If (Position:C15(","; $fields_t)>0)
		$fields_c:=Split string:C1554($fields_t; ",")
	Else 
		$fields_c:=Split string:C1554($fields_t; ";")
	End if 
	
	var $field : Text
	var $postion : Integer
	$postion:=0
	
	For each ($field; $fields_c)
		$fieldobject:=This:C1470.dataClass[$field]
		If ($fieldobject.kind="storage")  // only show existing fields, not relations, not alias, not calculated
			If (($fieldobject.fieldType#Is BLOB:K8:12) & ($fieldobject.fieldType#Is object:K8:27))
				$postion:=$postion+1
				This:C1470._setColumnByFieldName($field; $postion)
			End if 
		End if 
	End for each 
	
	This:C1470._popupName("aViewsList")
	
	
Function _setColumnsFromList()
	If (Form:C1466.LB_Show.ents.length=0)
		ALERT:C41("There are no fields in the top list.")
	Else 
		//This._deleteColumns()
		LISTBOX DELETE COLUMN:C830(*; This:C1470.name; 1; \
			LISTBOX Get number of columns:C831(*; This:C1470.name))
		
		This:C1470.fc.data.views[This:C1470.view].fields:=""
		var $line_o : Object
		var $c : Collection
		$c:=New collection:C1472
		For each ($line_o; Form:C1466.LB_Show.ents)
			$c.push(This:C1470.fc.data.views[This:C1470.view].fields+$line_o.fieldName)
		End for each 
		This:C1470.fc.data.views[This:C1470.view].fields:=$c.join(";")
		
		This:C1470._setColumnsString(This:C1470.fc.data.views[This:C1470.view].fields)
	End if 
	
	This:C1470._popupName()
	
Function setColumnsFromEmpty()
	This:C1470._deleteColumns()
	This:C1470.fc.data.views[This:C1470.view].fields:=""
	var $columns_c : Collection
	$columns_c:=New collection:C1472
	$counter:=0
	var $column_o : Object
	For each ($field; This:C1470.dataClass) While ($counter<10)
		$fieldobject:=This:C1470.dataClass[$field]
		If ($fieldobject.kind="storage")  // only show existing fields, not relations, not alias, not calculated
			If (($fieldobject.fieldType#Is BLOB:K8:12) & ($fieldobject.fieldType#Is object:K8:27))
				$counter:=$counter+1
				This:C1470._setFieldAdd($field)
			End if 
		End if 
	End for each 
	This:C1470._setClipComma()
	This:C1470._setColumnsString()
	
	This:C1470._popupName()
	
Function setColumns($columns_c : Collection)
	If ($columns_c=Null:C1517)
		If (This:C1470.fc.data.views[This:C1470.view].columns#Null:C1517)
			//If (Not(Undefined(This.fc.data.views[This.view].columns.length)))
			$columns_c:=This:C1470.fc.data.views[This:C1470.view].columns
		End if 
	End if 
	This:C1470._deleteColumns()
	
	
	
	If ($columns_c=Null:C1517)
		This:C1470.fc.data.views[This:C1470.view].columns:=New collection:C1472
		This:C1470._setColumnsString(This:C1470.fc.data.views[This:C1470.view].fields)
	Else 
		var $column_o : Object
		var $counter : Integer
		var $fields_t : Text
		
		$counter:=1
		$fields_t:=""
		For each ($column_o; $columns_c)
			$fields_t:=$fields_t+Replace string:C233($column_o.dataSource; "This."; "")+","
			
			If (False:C215)
				LBX_ColumnSet(This:C1470.name; $counter; $column_o)
			Else 
				This:C1470._setColumn($column_o; $position)
			End if 
			
			
		End for each 
		This:C1470.fc.data.views[This:C1470.view].fields:=Substring:C12($fields_t; 1; Length:C16($fields_t)-1)
	End if 
	This:C1470._popupName()
	
	
Function _setColumn($column_o : Object; $position : Integer)
	ON ERR CALL:C155("OEC_ConsoleDebug")
	var $field_t : Text
	$field_t:=Replace string:C233($column_o.dataSource; "This."; "")
	If ($column_o.header.text="")
		$column_o.header.text:=$field_t
		If ($doCaps)
			$column_o.header.text:=Uppercase:C13($field_t[[1]])+Substring:C12($field_t; 2)
		End if 
	End if 
	If ($column_o.fieldType=Null:C1517)
		$column_o.fieldType:=ds:C1482[Form:C1466.dataClassName][$field_t].fieldType
	End if 
	LISTBOX INSERT COLUMN FORMULA:C970(*; This:C1470.name; $position; \
		$column_o.name; $column_o.dataSource; $column_o.fieldType; \
		$column_o.header.name; $nullpointer; $column_o.footer.name; $nullpointer)
	OBJECT SET TITLE:C194(*; $column_o.header.name; $column_o.header.text)
	
	
	If ($column_o.enterable=Null:C1517)
		OBJECT SET ENTERABLE:C238(*; $column_o.name; False:C215)
	End if 
	
	If ($column_o.turncate=Null:C1517)
		LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk truncate:K53:37; lk without ellipsis:K53:64)
	Else 
		LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk truncate:K53:37; $column_o.turncate)
	End if 
	//  lk without ellipsis = , lk with ellipsis = 
	
	If ($column_o.width=Null:C1517)
		LISTBOX SET COLUMN WIDTH:C833(*; $column_o.name; 100)
	Else 
		LISTBOX SET COLUMN WIDTH:C833(*; $column_o.name; $column_o.width)
	End if 
	If ($column_o.format#Null:C1517)
		OBJECT SET FORMAT:C236(*; $column_o.name; $column_o.format)
		//$column_o.format:=OBJECT Get format(*; $column_o.name)  // 1
	End if 
	If ($column_o.align#Null:C1517)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $column_o.name; $column_o.align)
		//$column_o.align:=OBJECT Get horizontal alignment(*; $column_o.name)
	End if 
	If ($column_o.wordWrap#Null:C1517)  // boolean
		LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk allow wordwrap:K53:39; $column_o.wordWrap)
		// $column_o.wordWrap:=LISTBOX Get property(*; $column_o.name; lk allow wordwrap)
	End if 
	If ($column_o.bgColor#Null:C1517)
		LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk background color expression:K53:47; $column_o.bgColor)
		// $column_o.bgColor:=LISTBOX Get property(*; $column_o.name; lk background color expression)
	End if 
	If ($column_o.fontColor#Null:C1517)
		LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk font color expression:K53:48; $column_o.fontColor)
		//$column_o.fontColor:=LISTBOX Get property(*; $column_o.name; lk font color expression)
	End if 
	If ($column_o.widthMin#Null:C1517)  // integer
		LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk column min width:K53:50; $column_o.widthMin)
		// $column_o.widthMin:=LISTBOX Get property(*; $column_o.name; lk column min width)
	End if 
	If ($column_o.widthMax#Null:C1517)  // integer
		LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk column max width:K53:51; $column_o.widthMax)
		//$column_o.widthMax:=LISTBOX Get property(*; $column_o.name; lk column max width)
	End if 
	If ($column_o.resizable#Null:C1517)  // boolean
		LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk column resizable:K53:40; $column_o.resizable)
		// $column_o.resizable:=LISTBOX Get property(*; $column_o.name; lk column resizable)
	End if 
	If ($column_o.displayType#Null:C1517)
		LISTBOX SET PROPERTY:C1440(*; $column_o.name; lk display type:K53:46; $column_o.displayType)
		//  lk numeric format
		//  
		//  Display Type property for numeric columns
		//  $column_o.displayType:=LISTBOX Get property(*; $column_o.name; lk display type)
	End if 
	
	
	
	
	
Function _deleteColumns()
	LISTBOX DELETE COLUMN:C830(*; This:C1470.name; 1; \
		LISTBOX Get number of columns:C831(*; This:C1470.name))
	
Function setColumnSave($select_i)
	
	
	
	
	
	
	
	
	//MARK:-  Harvest
	
Function _getLBDefinitionZZ()
	
Function getProperties($column_o : Object)->$properties : Object
	$properties:=New object:C1471
	$properties.align:=OBJECT Get horizontal alignment:C707($column_o)
	$properties.format:=OBJECT Get format:C894($column_o)
	$properties.width:=LISTBOX Get column width:C834($column_o)
	$properties.formula:=LISTBOX Get column formula:C1202($column_o)
	$properties.displayType:=LISTBOX Get property:C917($column_o; lk display type:K53:46)
	$properties.wordWrap:=LISTBOX Get property:C917($column_o; lk allow wordwrap:K53:39)
	$properties.bgColor:=LISTBOX Get property:C917($column_o; lk background color expression:K53:47)
	$properties.fontColor:=LISTBOX Get property:C917($column_o; lk font color expression:K53:48)
	$properties.widthMin:=LISTBOX Get property:C917($column_o; lk column min width:K53:50)
	$properties.widthMax:=LISTBOX Get property:C917($column_o; lk column max width:K53:51)
	$properties.displayType:=LISTBOX Get property:C917($column_o; lk display type:K53:46)
	$properties.resizable:=LISTBOX Get property:C917($column_o; lk column resizable:K53:40)
	
	
	//$properties:=New object(\
																																																																		"number"; $count; \
																																																																		"enterable"; OBJECT Get enterable(*; $column); \
																																																																		"allowWordwrap"; LISTBOX Get property(*; $column; lk allow wordwrap); \
																																																																		"autoRowHeight"; LISTBOX Get property(*; $column; lk auto row height); \
																																																																		"backgroundColorExpression"; LISTBOX Get property(*; $column; lk background color expression); \
																																																																		"columnMinWidth"; LISTBOX Get property(*; $column; lk column min width); \
																																																																		"columnResizable"; LISTBOX Get property(*; $column; lk column resizable); \
																																																																		"detailFormName"; LISTBOX Get property(*; $column; lk detail form name); \
																																																																		"displayFooter"; LISTBOX Get property(*; $column; lk display footer); \
																																																																		"displayHeader"; LISTBOX Get property(*; $column; lk display header); \
																																																																		"displayType"; LISTBOX Get property(*; $column; lk display type); \
																																																																		"doubleClickOnRow"; LISTBOX Get property(*; $column; lk double click on row); \
																																																																		"extraRows"; LISTBOX Get property(*; $column; lk extra rows); \
																																																																		"fontColorExpression"; LISTBOX Get property(*; $column; lk font color expression); \
																																																																		"fontStyleExpression"; LISTBOX Get property(*; $column; lk font style expression); \
																																																																		"hideSelectionHighlight"; LISTBOX Get property(*; $column; lk hide selection highlight); \
																																																																		"highlightSet"; LISTBOX Get property(*; $column; lk highlight set); \
																																																																		"horScrollbarHeight"; LISTBOX Get property(*; $column; lk hor scrollbar height); \
																																																																		"multiStyle"; LISTBOX Get property(*; $column; lk multi style); \
																																																																		"namedSelection"; LISTBOX Get property(*; $column; lk named selection); \
																																																																		"resizingMode"; LISTBOX Get property(*; $column; lk resizing mode); \
																																																																		"rowHeightUnit"; LISTBOX Get property(*; $column; lk row height unit); \
																																																																		"selectionMode"; LISTBOX Get property(*; $column; lk selection mode); \
																																																																		"singleClickEdit"; LISTBOX Get property(*; $column; lk single click edit); \
																																																																		"sortable"; LISTBOX Get property(*; $column; lk sortable); \
																																																																		"truncate"; LISTBOX Get property(*; $column; lk truncate); \
																																																																		"verScrollbarWidth"; LISTBOX Get property(*; $column; lk ver scrollbar width)\
																																																																		)
	
Function getColumns()->$return : Object
	
	ARRAY TEXT:C222($arrColNames; 0)
	ARRAY TEXT:C222($arrHeaderNames; 0)
	ARRAY POINTER:C280($arrColVars; 0)
	ARRAY POINTER:C280($arrHeaderVars; 0)
	ARRAY BOOLEAN:C223($arrColsVisible; 0)
	ARRAY POINTER:C280($arrStyles; 0)
	ARRAY TEXT:C222($arrFooterNames; 0)
	ARRAY POINTER:C280($arrFooterVars; 0)
	LISTBOX GET ARRAYS:C832(*; This:C1470.name; $arrColNames; $arrHeaderNames; $arrColVars; $arrHeaderVars; $arrColsVisible; $arrStyles; $arrFooterNames; $arrFooterVars)
	
	
	var $listboxSetup_o : Object
	$listboxSetup_o:=New object:C1471("listboxName"; This:C1470.name; "tableName"; tableName; "fieldList"; ""; "priority"; "harvest"; "role"; ""; "idUser"; ""; "columns"; New object:C1471)
	
	// general listbox properties
	var $viScrollHorizontal; $viScrollVertical : Integer
	//$listboxSetup_o.scroll:=OBJECT GET SCROLLBAR(*; This.name; $viScrollHorizontal; $viScrollVertical)
	//$listboxSetup_o.scrollPosition:=OBJECT GET SCROLL POSITION(*; This.name; $viScrollHorizontal; $viScrollVertical)
	$listboxSetup_o.scrollbarHeight:=LISTBOX Get property:C917(*; This:C1470.name; lk hor scrollbar height:K53:7)
	//$listboxSetup_o.footerHeight:=LISTBOX Get footers height
	//$listboxSetup_o.headerHeight:=LISTBOX Get headers height
	$listboxSetup_o.backGroundColor:=LISTBOX Get property:C917(*; This:C1470.name; lk background color expression:K53:47)
	$listboxSetup_o.detailFormName:=LISTBOX Get property:C917(*; This:C1470.name; lk detail form name:K53:44)
	$listboxSetup_o.displayFooter:=LISTBOX Get property:C917(*; This:C1470.name; lk display footer:K53:20)
	$listboxSetup_o.displayHeader:=LISTBOX Get property:C917(*; This:C1470.name; lk display header:K53:4)
	$listboxSetup_o.clickDouble:=LISTBOX Get property:C917(*; This:C1470.name; lk double click on row:K53:43)
	$listboxSetup_o.extraRows:=LISTBOX Get property:C917(*; This:C1470.name; lk extra rows:K53:38)
	$listboxSetup_o.fontColor:=LISTBOX Get property:C917(*; This:C1470.name; lk font color expression:K53:48)
	$listboxSetup_o.hideSelection:=LISTBOX Get property:C917(*; This:C1470.name; lk hide selection highlight:K53:41)
	$listboxSetup_o.highlightSet:=LISTBOX Get property:C917(*; This:C1470.name; lk highlight set:K53:66)
	
	var $fieldList : Text
	$fieldList:=""
	var $obColumn; $lbWhole_o : Object
	ARRAY TEXT:C222($arrLBObjects; 0)
	LISTBOX GET OBJECTS:C1302(*; This:C1470.name; $arrLBObjects)
	var $cntOb; $incOb; $viWidth : Integer
	$cntOb:=Size of array:C274($arrLBObjects)
	var $cntColumns_i : Integer
	$cntColumns_i:=-1
	var $obColumn; $obFooter; $obHeader : Object
	var $footerName; $headerName : Text
	var $columns_c : Collection
	$columns_c:=New collection:C1472
	For ($incOb; 1; $cntOb)
		Case of 
			: ($arrLBObjects{$incOb}="Column_@")
				$cntColumns_i:=$cntColumns_i+1
				
				var $header_c : Collection
				$header_c:=Split string:C1554($arrLBObjects{$incOb}; "_")
				$vtColString:=Substring:C12($arrLBObjects{$incOb}; Length:C16("Column")+1)
				
				$obColumn:=New object:C1471("header"; New object:C1471; "footer"; New object:C1471)
				
				
				$obColumn.name:=$arrLBObjects{$incOb}
				$begin_i:=Position:C15("_"; $obColumn.name; 14)+1
				$end_i:=Position:C15("_"; $obColumn.name; $begin_i)
				$source_t:=Substring:C12($obColumn.name; $begin_i; $end_i-$begin_i)
				$fieldList:=$fieldList+$source_t+";"
				
				$obColumn.header.name:="Header"+$vtColString
				$obColumn.header.text:=Uppercase:C13($source_t[[1]])+Substring:C12($source_t; 2; Length:C16($source_t))
				$headerName:=$obColumn.header.name
				$obColumn.footer.name:="Footer"+$vtColString
				$footerName:=$obColumn.footer.name
				$obColumn.className:=$header_c[1]
				$obColumn.valueName:=$source_t
				$obColumn.dataSource:="This."+$source_t
				
				var $properties : Object
				var $name : Text
				$properties:=New object:C1471
				$properties.align:=OBJECT Get horizontal alignment:C707(*; $arrLBObjects{$incOb})
				$properties.format:=OBJECT Get format:C894(*; $arrLBObjects{$incOb})
				$properties.width:=LISTBOX Get column width:C834(*; $arrLBObjects{$incOb})
				$properties.formula:=LISTBOX Get column formula:C1202(*; $arrLBObjects{$incOb})
				$properties.displayType:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk display type:K53:46)
				$properties.wordWrap:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk allow wordwrap:K53:39)
				$properties.bgColor:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk background color expression:K53:47)
				$properties.fontColor:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk font color expression:K53:48)
				$properties.widthMin:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk column min width:K53:50)
				$properties.widthMax:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk column max width:K53:51)
				$properties.displayType:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk display type:K53:46)
				$properties.resizable:=LISTBOX Get property:C917(*; $arrLBObjects{$incOb}; lk column resizable:K53:40)
				//This.getProperties($obColumn)
				For each ($name; $properties)
					$obColumn[$name]:=$properties[$name]
				End for each 
				$columns_c.push($obColumn)
				
				
			: ($arrLBObjects{$incOb}="Head@")  //  avoiding null, may not be required   $obColumn.header.name)
				
			: ($arrLBObjects{$incOb}="Footer@")  //  avoiding null, may not be required $obColumn.footer.name)
				
		End case 
	End for 
	$return:=New object:C1471("columns"; $columns_c)
	
	This:C1470.fc.data.views[This:C1470.view].fields:=Substring:C12($fieldList; 1; Length:C16($fieldList)-1)
	
	
	
	
	
	