C_OBJECT:C1216($obEvent)
$obEvent:=FORM Event:C1606
Case of 
	: ($obEvent.code=On Load:K2:1)
		C_OBJECT:C1216($obSetup)
		C_TEXT:C284($vtFieldList)
		$vtFieldList:="actionBy,result, status,date,perCent"
		$tableName_t:="Result"
		$obSetup:=New object:C1471("listboxName"; "lbContacts"; "tableName"; $tableName_t; "fieldList"; $vtFieldList)
		LB_DraftFromFieldString($obSetup)
		
End case 