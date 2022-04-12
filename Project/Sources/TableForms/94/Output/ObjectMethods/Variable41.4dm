If (False:C215)
	//olo [FieldCharacteristic]
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 

If (<>aTableNames>1)
	QUERY:C277([FieldCharacteristic:94]; [FieldCharacteristic:94]tableNumber:1=<>aTableNums{<>aTableNames})
Else 
	ALL RECORDS:C47([FieldCharacteristic:94])
End if 