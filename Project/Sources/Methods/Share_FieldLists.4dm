//%attributes = {}
C_OBJECT:C1216(<>voFieldList)
C_OBJECT:C1216($voSelFieldChar)
TRACE:C157

Use (Storage:C1525)
	Storage:C1525.vbEDIPass:=New shared object:C1526("EDI"; True:C214)
	C_OBJECT:C1216(tables)
	Storage:C1525.vbEDIPass:=New shared object:C1526("tables"; True:C214)
	If (False:C215)  // these fai
		C_OBJECT:C1216($voTest)
		$voTest:=New object:C1471
		Storage:C1525.test:=New shared object:C1526("oTest"; $voTest)
	End if 
End use 




$voSelFieldChar:=ds:C1482.FC.query("tableName = FieldLists")