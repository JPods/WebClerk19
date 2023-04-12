//%attributes = {}

// Modified by: Bill James (2022-06-24T05:00:00Z)
// Method: entity_Add
// Description 
// Parameters
//  https://discuss.4d.com/t/listbox-select-rows-and-new-added-record/14186/4
// ----------------------------------------------------

#DECLARE($ents : Object; $listBox : Text; $step_l : Integer)

//If (Count parameters>=1)
//$step_l:=$1
//End if 

var $vo_record : Object
var $dataClassName : Text
$dataClassName:=$ents.getDataClass.getInfo("name")
Case of 
	: (Form event code:C388=On Clicked:K2:4) & ($step_l=0)
		
		$vo_record:=ds:C1482[$dataClassName].new()
		$vo_record.Name:="__New Record "+String:C10(Current time:C178)
		$vo_record.save()
		
		$ents:=$ents.add($vo_record)
		CALL FORM:C1391(Current form window:C827; Current method name:C684; 1)
		
	: ($step_l=1)
		LISTBOX SELECT ROW:C912(*; $listBox; ents.length)
		CALL FORM:C1391(Current form window:C827; Current method name:C684; 2)
		
	: ($step_l=2)
		LISTBOX SORT COLUMNS:C916(*; $listBox; 1; >)
End case 