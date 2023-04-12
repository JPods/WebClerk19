


If (Form:C1466.obHarvest=Null:C1517)
	ALERT:C41("There is nothing to build in Form.obHarvest.")
Else 
	var $obSetup : Object
	$obSetup:=New object:C1471("listboxName"; "LB_Draft"; \
		"tableName"; $tableName; \
		"subForm"; "SF_Draft")
	
	// QQQ WHY is this a compiler error
	//OBJECT SET SUBFORM(*; "SF_Draft"; Form.obHarvest)
End if 

