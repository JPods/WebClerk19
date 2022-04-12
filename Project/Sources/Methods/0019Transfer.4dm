//%attributes = {}
$recFirst:=ds:C1482.Employee.all().first()

$recSecond:=ds:C1482.Employee.all().first()
$recSecond.nameFirst:=$recSecond.nameFirst+"_2"
$result2_o:=$recSecond.save()

$result1_o:=$recFirst.save()

If (Not:C34($result1_o.success))  // ($result_o.success=dk status stamp has changed)
	
	$recCurrent:=ds:C1482.Employee.get($recFirst.id)  // should this be $result_o.id  ??  or  
	
	$result_o:=$recCurrent.lock()  //pessimistic lock
	// test for lock??
	
	If ($recFirst.touched())
		C_COLLECTION:C1488($touchedAttributes)
		$touchedAttributes:=$recFirst.touchedAttributes()
		
		For each ($attributed; $touchedAttributes)
			$recCurrent[$attributed]:=$recFirst[$attributed]
		End for each 
		
		$result_o:=$recCurrent.save()
		$recCurrent.unlock()
	End if 
	
End if 

