If (Form event code:C388=On Clicked:K2:4)
	DB_QueryByUniqueID([ChangeLog:149]authorTableName:9; [ChangeLog:149]nameIDAuthor:8)
	If (Records in selection:C76(Table:C252(STR_GetTableNumber([ChangeLog:149]authorTableName:9))->)>0)
		DB_ShowCurrentSelection(Table:C252(STR_GetTableNumber([ChangeLog:149]authorTableName:9)); ""; 1; "")
	End if 
End if 