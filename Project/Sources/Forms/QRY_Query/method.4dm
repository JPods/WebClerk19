$evt:=Form event code:C388

Case of 
	: ($evt=On Load:K2:1)
		Form:C1466.criteria:=New collection:C1472
		Form:C1466.popUpPtr:=OBJECT Get pointer:C1124(Object named:K67:5;"_MASTER_")
		Form:C1466.plistChoice:=1
		Form:C1466.queryMenus:=QRY_PrepareMenus 
		Form:C1466.qryTablesClose:=New object:C1471
		
		OBJECT SET ENABLED:C1123(*;"@_VAL_@";False:C215)
		Form:C1466.propertyList:=QRY_RedrawList (Form:C1466.propertyListOriginal;Form:C1466.plistChoice)
		
	: ($evt=On Clicked:K2:4)
		
		
End case 

If (($evt=On Load:K2:1) | ($evt=On Clicked:K2:4) | ($evt=On Double Clicked:K2:5) | ($evt=On Drop:K2:12) | ($evt=On Selection Change:K2:29) | ($evt=On Data Change:K2:15))
	OBJECT SET ENABLED:C1123(*;"@_ADD_@";((Form:C1466.propertySelected#Null:C1517) & (Form:C1466.propertyPosition<=Form:C1466.propertyList.length)))
	OBJECT SET ENABLED:C1123(*;"@_REM_@";(Form:C1466.criteria_Pos#0))
	OBJECT SET ENABLED:C1123(*;"@_VAL_@";(Form:C1466.criteria.length>0))
End if 
