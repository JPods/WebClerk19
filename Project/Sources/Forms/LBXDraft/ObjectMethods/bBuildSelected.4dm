
// Modified by: Bill James (2022-04-10T05:00:00Z)
// Method: LBXDraft.bBuildArray3
// Description 
// Parameters
// ----------------------------------------------------




var $obSetup; $field_o; $listboxSetup_o : Object
var $fieldList_t; $tableName; $lbName_t : Text

var form_o : Object  // testing
form_o:=New object:C1471("setup"; $obSetup)
$lbName_t:="LB_Draft"
$tableName:=tableName

$obSetup:=New object:C1471("listboxName"; $lbName_t; \
"tableName"; $tableName; \
"subForm"; "SF_Draft")

form_o.draft:=LBX_DraftFieldLB($obSetup)  // keep for a reference, $form:=LBX_ColumnReturn($obSetup)

// seems to require an empty string for the tableName
OBJECT SET SUBFORM:C1138(*; "SF_Draft"; ""; form_o.draft)


