C_OBJECT:C1216($event_o)

$event_o:=FORM Event:C1606
Case of 
	: ($event_o.code=On Load:K2:1)
		C_OBJECT:C1216($obSel)
		// C_COLLECTION(cDisplayed)
		
		$tableName:="Order"
		C_COLLECTION:C1488($cTemp)
		$cTemp:=New collection:C1472
		
		$vtFieldList:="company,phone,actionDate,actionTime,shipAuto,orderNum,amount"
		$cFilter:=Split string:C1554($vtFieldList; ";")
		Form:C1466.LBImport.ents:=ds:C1482[$tableName].all()
		Form:C1466.cDisplayed:=ds:C1482[$tableName].all().toCollection($cFilter)
End case 

