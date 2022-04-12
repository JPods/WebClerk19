Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(aTableNames; 0)
		ARRAY LONGINT:C221(aTableNums; 0)
		STR_GetTableNameArray(->aTableNames; ->aTableNums)
		SORT ARRAY:C229(aTableNums)
	: (Form event code:C388=On Data Change:K2:15)
		If (aTableNames>0)
			tableName:=aTableNames{aTableNames}
			STR_FieldsListBox
			aTableNums:=STR_GetTableNumber(aTableNames{aTableNames})
		End if 
	Else 
		
		
End case 