var $listboxSetup_o : Object
var vtFieldList : Text
var $cFilter : Collection
If (vtFieldList="")
	ALERT:C41("There are not values in the FieldList")
Else 
	$listboxSetup_o:=New object:C1471("listboxName"; "LBDraftTable"; "tableName"; tableName; "fieldList"; vtFieldList; "priority"; "fieldList")
	$listboxSetup_o:=LBX_DraftFromFieldString($listboxSetup_o)
	
	LBX_ColumnBuild($listboxSetup_o)
	
	Form:C1466.ents:=ds:C1482[$listboxSetup_o.tableName].all()
End if 