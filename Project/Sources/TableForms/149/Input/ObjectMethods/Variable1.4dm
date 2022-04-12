If (Form event code:C388=On Clicked:K2:4)
	DB_QueryByUniqueID([ChangeLog:149]linkedTableName:2; [ChangeLog:149]ideLinked:3)
	If (Records in selection:C76(Table:C252(STR_GetTableNumber([ChangeLog:149]linkedTableName:2))->)>0)
		DB_ShowCurrentSelection(Table:C252(STR_GetTableNumber([ChangeLog:149]linkedTableName:2)); ""; 1; "")
	End if 
End if 