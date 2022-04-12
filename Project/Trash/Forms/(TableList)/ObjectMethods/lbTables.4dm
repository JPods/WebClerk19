C_OBJECT:C1216($event_o; obDisplay)
C_LONGINT:C283(viRow; $viRow)
$event_o:=FORM Event:C1606

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		STR_TablesListBox
		STR_FieldsListBox
		
	: (Form event code:C388=On Clicked:K2:4)
		
		tableName:=Form:C1466.tableCurrent.tableName
		
		STR_FieldsListBox
		
End case 