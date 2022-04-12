C_LONGINT:C283($i; $k)
$k:=Records in selection:C76([FieldCharacteristic:94])
FIRST RECORD:C50([FieldCharacteristic:94])
For ($i; 1; $k)
	If (([FieldCharacteristic:94]tableNumber:1>0) & (Get last table number:C254>=[FieldCharacteristic:94]tableNumber:1))
		If ([FieldCharacteristic:94]tableName:7="")
			[FieldCharacteristic:94]tableName:7:=Table name:C256([FieldCharacteristic:94]tableNumber:1)
			If (([FieldCharacteristic:94]fieldNumber:5>0) & (Get last field number:C255([FieldCharacteristic:94]tableNumber:1)>=[FieldCharacteristic:94]fieldNumber:5))
				If ([FieldCharacteristic:94]fieldName:8="")
					[FieldCharacteristic:94]fieldName:8:=Field name:C257([FieldCharacteristic:94]tableNumber:1; [FieldCharacteristic:94]fieldNumber:5)
				End if 
			End if 
			SAVE RECORD:C53([FieldCharacteristic:94])
		End if 
	End if 
	NEXT RECORD:C51([FieldCharacteristic:94])
End for 
