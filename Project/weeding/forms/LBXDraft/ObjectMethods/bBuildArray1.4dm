var $obSetup; $field_o; $listboxSetup_o : Object
var $fieldList_t; $tableName : Text

// MustFixQQQZZZ: Bill James (2021-09-02T05:00:00Z)
var $form : Object
$obSetup:=New object:C1471("listboxName"; "LB_"+tableName; "tableName"; tableName; "fieldList"; vtFieldList; "priority"; "Selection")






$listboxSetup_o:=LBX_DraftFromFieldString($obSetup)


LBX_ColumnBuild($listboxSetup_o)

Form:C1466.ents:=ds:C1482[$listboxSetup_o.tableName].all()
