
var $obSetup; $field_o; $listboxSetup_o : Object
var $fieldList_t; $tableName : Text

var form_o : Object  // testing
form_o:=New object:C1471("setup"; $obSetup)

$tableName:=tableName
// $obSetup:=New object("listboxName"; "LB_"+$tableName; \
"tableName"; $tableName; \
"subForm"; "SF_Draft")

$obSetup:=New object:C1471("listboxName"; "LB_Draft"; \
"tableName"; $tableName; \
"subForm"; "SF_Draft")

$form:=LBX_DraftFieldLB($obSetup)  // keep for a reference, $form:=LBX_ColumnReturn($obSetup)


form_o.draft:=$form


OBJECT SET SUBFORM:C1138(*; $obSetup.subForm; $form)
var subformDraft : Object
subformDraft:=$form
Form:C1466.obHarvest:=subformDraft
//LBX_ColumnBuild($listboxSetup_o)
