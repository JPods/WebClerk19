//jaFilesManage (True;2)
////  --  CHOPPED  AL_UpdateArrays (eExportFlds;-2)
//// -- AL_SetSort (eExportFlds;1)
If (False:C215)
	//oLo [FieldCharacteristic]
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
QUERY:C277([FieldCharacteristic:94]; [FieldCharacteristic:94]tableNum:1=<>aTableNums{<>aTableNames}; *)
If (iLoLongInt1>0)
	QUERY:C277([FieldCharacteristic:94];  & [FieldCharacteristic:94]securityLevel:3=iLoLongInt1; *)
End if 
QUERY:C277([FieldCharacteristic:94])
ORDER BY:C49([FieldCharacteristic:94]; [FieldCharacteristic:94]tableNum:1; [FieldCharacteristic:94]fieldNumber:5; [FieldCharacteristic:94]securityLevel:3)