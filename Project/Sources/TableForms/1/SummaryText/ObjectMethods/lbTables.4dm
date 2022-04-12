C_OBJECT:C1216($obEvent; obDisplay)
C_LONGINT:C283(viRow; $viRow)
$obEvent:=FORM Event:C1606

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		STR_TablesListBox
		STR_FieldsListBox
		
	: (Form event code:C388=On Clicked:K2:4)
		
		vtTableName:=Form:C1466.tableCurrent.tableName
		
		STR_FieldsListBox
		
End case 