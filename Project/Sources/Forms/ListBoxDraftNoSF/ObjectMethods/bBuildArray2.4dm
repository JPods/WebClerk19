var $listboxSetup_o : Object
var vtFieldList : Text
var $cFilter : Collection
If (vtFieldList="")
	ALERT:C41("There are not values in the FieldList")
Else 
	var $o : Object
	$o:=LBX_DraftColumsFromArrays(vtFieldList; vtLabelList)
	Form:C1466.obHarvest:=$o
End if 