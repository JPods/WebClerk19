Case of 
	: (vtFieldList="")
		ALERT:C41("vtFieldList is empty, there must be fields selected")
	: (tableName_t="")
		ALERT:C41("tableName_t is empty, there must be a selected table")
	Else 
		C_OBJECT:C1216($obTableOutput)
		$obTableOutput:=New object:C1471
		
		
		
		$obTableOutput:=LBX_GetColumnObject("LB_Empty"; tableName_t)
		
		LBX_oLoDefaultSave($obTableOutput)
End case 

