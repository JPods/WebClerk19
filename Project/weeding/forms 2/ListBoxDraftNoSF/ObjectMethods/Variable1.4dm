Case of 
	: (Form event code:C388=On Load:K2:1)
		//ARRAY TEXT(aTableNames; 0)
		//ARRAY TEXT(aTableNums; 0)
		//STR_GetTableNameArray(->aTableNames; ->aTableNums)
	: (Form event code:C388=On Data Change:K2:15)
		If (aTableNums>0)
			
			
			tableName:=aTableNames{aTableNames}
			STR_FieldsListBox
			aTableNums:=STR_GetTableNumber(aTableNames{aTableNames})
		End if 
	Else 
		
		
End case 