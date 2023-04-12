C_OBJECT:C1216($event_o)

$event_o:=FORM Event:C1606
Case of 
	: ($event_o.code=On Clicked:K2:4)
		C_OBJECT:C1216($obSel)
		// C_COLLECTION(cDisplayed)
		
		$tableName:="Order"
		C_COLLECTION:C1488($cTemp)
		$cTemp:=New collection:C1472
		
		$vtFieldList:="company,phone,actionDate,actionTime,shipAuto,orderNum,amount"
		$cFilter:=Split string:C1554($vtFieldList; ";")
		$cTemp:=ds:C1482[$tableName].all().toCollection($cFilter)
		//For each ($obRow; $cTemp)
		//Form.dateTime:=
		//End for each 
		Form:C1466.cOrderDisplayed:=$cTemp
End case 


