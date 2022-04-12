C_OBJECT:C1216($event_o; obDisplay)
C_LONGINT:C283(viRow; $viRow)
$event_o:=FORM Event:C1606
Case of 
	: (Form event code:C388=On Load:K2:1)
		C_OBJECT:C1216($obSel)
		C_COLLECTION:C1488($cTemp)
		$obSel:=ds:C1482.TallyMaster.query("purpose = :1 OR purpose = :2 AND tableName = :3 AND publish <= :4 "; "Search"; "Query"; tableName; Storage:C1525.user.securityLevel)
		
		
	: (Form event code:C388=On Double Clicked:K2:5)
		
		tableName:=Form:C1466.tableCurrent.tableName
		
		STR_FieldsListBox
		
End case 