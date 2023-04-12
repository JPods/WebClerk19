$listboxHarvest_o:=New object:C1471("listboxName"; "_LB_"+Form:C1466.dataClassName+"_"; "purpose"; purpose_t; "role"; role_t; "tableName"; tableName; "columns"; New object:C1471)
//$listboxHarvest_o:=New object("listboxName"; "LB_Draft"; "purpose"; purpose_t; "role"; role_t; "tableName"; tableName; "columns"; New object)
$listboxHarvest_o:=LBX_ColumnHarvest($listboxHarvest_o)