// Modified by: Bill James (2022-04-21T05:00:00Z)
// Method: clLines
// Description 
// Parameters
// ----------------------------------------------------

Class constructor($dataClassName : Text; $process_o : Object)
	This:C1470.$dataClassName:=$dataClassName
	//This.subFormName:=$dataClassName
	
	This:C1470.ents:=New collection:C1472
	This:C1470.cur:=New collection:C1472
	This:C1470.old:=New collection:C1472
	This:C1470.sel:=New collection:C1472
	This:C1470.pos:=-1
	This:C1470.cnt:=0
	This:C1470.cntSel:=0
	
Function destructor
	Use (Storage:C1525)
		Use (Storage:C1525.windowList)
			Storage:C1525.windowList[This:C1470.dataClassName]:=0
		End use 
	End use 
	This:C1470.ents:=New object:C1471
	This:C1470.cur:=New object:C1471
	This:C1470.old:=New object:C1471
	This:C1470.sel:=New object:C1471
	This:C1470.pos:=-1
	This:C1470.cnt:=0
	choices_o:=New object:C1471
	
Function selectInit
	var $return : Object
	$return:=New object:C1471
	If (This:C1470.cnt=0)
		// must have ()
		$return:=This:C1470.selectZero()
	Else 
		$return:=This:C1470.selectChanged()
	End if 
	$0:=$return
	
Function selectChanged
	process_o.entitySave()
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
	End case 