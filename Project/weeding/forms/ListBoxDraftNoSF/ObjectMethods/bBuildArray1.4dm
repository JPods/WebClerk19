var $obSetup; $field_o; $listboxSetup_o : Object
var $fieldList_t; $tableName : Text

// MustFixQQQZZZ: Bill James (2021-09-02T05:00:00Z)


$obSetup:=New object:C1471("listboxName"; "LB_Draft"; "tableName"; tableName; "fieldList"; vtFieldList; "priority"; "Selection")
//$listboxSetup_o:=LBX_DraftFromFieldString($obSetup)

//LBX_ColumnBuild($listboxSetup_o)

LBDraftTable:=cs:C1710.listbox.new("LBDraftTable"; ds:C1482[tableName].all())
var $coordinates : Object
$coordinates:=LBDraftTable.getCoordinates()

Form:C1466.items:=ds:C1482[$listboxSetup_o.tableName].all()
