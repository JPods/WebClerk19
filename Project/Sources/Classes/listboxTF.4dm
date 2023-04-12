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

USE for Tables and Field listboxes
*/

Class constructor($name : Text; $dataClassName : Text; $refs : Object)
	// listboxTF constructor
	var $key : Text
	// (name{;object})
	ASSERT:C1129(Count parameters:C259>=1; "The name of the listbox object is required.")
	
	This:C1470.name:=$name  //      the name of the listbox
	This:C1470.refs:=$refs
	
	This:C1470.source:=Null:C1517  //  collection/entity selection form.<>.data is drawn from
	This:C1470.ents:=Null:C1517
	This:C1470.sel:=Null:C1517
	This:C1470.kind:=Null:C1517
	This:C1470.edit:=Null:C1517
	This:C1470.old:=Null:C1517
	This:C1470.cur:=Null:C1517
	This:C1470.meta:=Null:C1517
	This:C1470.pos:=0
	This:C1470.dataClassName:=$dataClassName
	This:C1470.dataClassNum:=ds:C1482[This:C1470.dataClassName].getInfo().tableNumber
	This:C1470.dataClassPt:=Table:C252(This:C1470.dataClassNum)
	
	
Function get isSelected->$isSelected : Boolean
	$isSelected:=This:C1470.pos>0
	
Function get index->$index : Integer
	$index:=This:C1470.pos-1
	
Function get_item()->$value : Variant
	//  gets the current item using the position index
	If (This:C1470.pos>0)
		$value:=This:C1470.ents[This:C1470.index]
	End if 
	
Function indexOf($what : Variant)->$index : Integer
	// listboxTF indexOf
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
Function setTables($source : Collection)
	// listboxTF setTables
	If (Count parameters:C259=0)
		C_COLLECTION:C1488($source)
		$source:=New collection:C1472
		C_TEXT:C284($vtProperty)
		var $tableNum : Integer
		For each ($vtProperty; ds:C1482)
			If ($vtProperty#"zz@")  // remove any non-user tables 
				$source.push(New object:C1471("tableName"; $vtProperty; "tableNum"; ds:C1482[$vtProperty].getInfo().tableNumber))
			End if 
		End for each 
	End if 
/*   Set the source data and determine it's kind   */
	var $type : Integer
	$type:=Value type:C1509($source)
	
	This:C1470.source:=$source
	This:C1470.kind:=$type
	This:C1470.setDataTables()
	
Function setFields($source : Collection)
	// listboxTF setFields
	If (Count parameters:C259=0)
		C_COLLECTION:C1488($source)
		$source:=New collection:C1472
		var $vtProperty : Text
		var $obClass : Object
		$obClass:=ds:C1482[Form:C1466.dataClassName]
		For each ($vtProperty; $obClass)
			$obProperty:=$obClass[$vtProperty]
			$source.push(New object:C1471("fieldName"; $obProperty.name; "type"; $obProperty.type; "fieldType"; $obProperty.fieldType; "fieldNumber"; $obProperty.fieldNumber))
		End for each 
		$source:=$source.orderBy("fieldName")
	End if 
	This:C1470.source:=$source
	This:C1470.setDataFields()
	
Function setFieldChar($purpose : Text)
	// listboxTF setFieldChar
	
	var $rec_o : Object
	$rec_o:=ds:C1482.FC.query("purpose = :1 and tableName = :2"; $purpose; This:C1470.dataClassName).first()
	If ($rec_o.id#Null:C1517)
		C_COLLECTION:C1488($source)
		$source:=New collection:C1472
		var $vtProperty : Text
		var $obClass : Object
		var $names_c : Collection
		$names_c:=$rec_o.data.fieldList
		$obClass:=ds:C1482[This:C1470.dataClassName]
		For each ($vtProperty; $names_c)
			$obProperty:=$obClass[$vtProperty]
			$source.push(New object:C1471("fieldName"; $obProperty.name; "type"; $obProperty.type; "fieldType"; $obProperty.fieldType; "fieldNumber"; $obProperty.fieldNumber))
		End for each 
		$source:=$source.orderBy("fieldName")
	End if 
	This:C1470.setData()
	
	
	
	
Function setDataTables
	// listboxTF setDataTables
	ASSERT:C1129(Count parameters:C259=0)  //  set the data to the source
	This:C1470.ents:=This:C1470.source
	If (This:C1470.ents.length#Null:C1517)
		If (This:C1470.ents.length>0)
			$c:=This:C1470.ents.indices("tableName = :1"; This:C1470.dataClassName)
			// returns a collection of numbers
			$row:=$c[0]
			
			This:C1470.cur:=This:C1470.ents[$row]
			This:C1470.pos:=$row
			This:C1470.sel:=This:C1470.cur
			//This.cur.setEntry()
			//If (This.cur.seq#Null)
			//This.setSeq()
			//End if 
			
			OBJECT SET SCROLL POSITION:C906(*; This:C1470.name; $row)
			LISTBOX SELECT ROW:C912(*; This:C1470.name; $row)
		End if 
	End if 
	
Function setDataFields
	ASSERT:C1129(Count parameters:C259=0)  //  set the data to the source
	This:C1470.ents:=This:C1470.source
	
	
Function setSelected($label : Text; $value : Text)
	// listboxTF setSelected
	$c:=This:C1470.ents.indices($label+" = :1"; $value)
	$row:=$c[0]
	// listbox name
	OBJECT SET SCROLL POSITION:C906(*; This:C1470.name; $row)
	LISTBOX SELECT ROW:C912(*; This:C1470.name; $row)
	
	
Function setSeq
	// listboxTF setSeq
	var $line : Object
	var $seq : Integer
	$seq:=0
	For each ($line; This:C1470.ents)
		$seq:=$seq+1
		$line.seq:=$seq
	End for each 
	
Function setMinus($propertyName : Text; $start_c : Collection; $parent_c : Collection)
	// listboxTF setMinus
	var $line : Object
	var $seq : Integer
	For each ($line; $start_c)
		$parent_c.remove($parent_c.indices($propertyName+" = :1"; $line[$propertyName])[0])
	End for each 
	
	
	
	//MARK:-  add
	
	
	//MARK:-  calc
	
Function dropItems($items : Object)
	// listboxTF dropItems
	Case of 
		: (dragFrom="LB_Fields")
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
			
		: (FORM Event:C1606.objectName="LB_Show")
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
	
	
	
Function insert($index : Integer; $element : Variant)->$result : Object
	// listboxTF insert
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
	
	
	
	
	//MARK:-
Function redraw()
	This:C1470.ents:=This:C1470.ents
	
Function reset()
	This:C1470.ents:=This:C1470.source