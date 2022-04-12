C_OBJECT:C1216($event_o; obDisplay)
C_LONGINT:C283(viRow; $viRow)
$event_o:=FORM Event:C1606

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		// STR_TablesListBox
		If (LISTBOX Get number of columns:C831(*; "lbTables")=0)
			LISTBOX INSERT COLUMN FORMULA:C970(*; "lbTables"; 1; "tableName"; "This.tableName"; Is text:K8:3; "header1"; $NilPtr)
			OBJECT SET TITLE:C194(*; "header1"; "TableName")
		End if 
		
		//STR_FieldsListBox
		
		If (LISTBOX Get number of columns:C831(*; "lbFields")=0)
			LISTBOX INSERT COLUMN FORMULA:C970(*; "lbFields"; 1; "fieldName"; "This.fieldName"; Is text:K8:3; "header1"; $NilPtr)
			OBJECT SET TITLE:C194(*; "header1"; "FieldNames")
			LISTBOX INSERT COLUMN FORMULA:C970(*; "lbFields"; 2; "fieldType"; "This.fieldType"; Is text:K8:3; "header2"; $NilPtr)
			OBJECT SET TITLE:C194(*; "header2"; "FieldType")
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		tableName:=Form:C1466.tableCurrent.tableName
		
		STR_FieldsListBox
		
End case 
