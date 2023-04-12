C_OBJECT:C1216($obEvent)
$obEvent:=FORM Event:C1606
Case of 
	: ($obEvent.code=On Load:K2:1)
		C_COLLECTION:C1488($cTemp)
		C_OBJECT:C1216($obSel)
		$obSel:=ds:C1482.PopUp.all()
		$obSel:=$obSel.orderBy("listName")
		$cTemp:=New collection:C1472
		C_COLLECTION:C1488($cFilter)
		$cFilter:=Split string:C1554("listName,arrayName,whereUsed,idNum,id"; ";")
		$cTemp:=$obSel.toCollection($cFilter)
		
		Form:C1466.cPopup:=$cTemp
		
	: ($obEvent.code=On Clicked:K2:4)
		
		// ### bj ### 20210809_1833
		C_COLLECTION:C1488($cTemp)
		$cTemp:=New collection:C1472
		
		C_OBJECT:C1216($obCollectionBuild)
		$obCollectionBuild:=New object:C1471("tableName"; "PopupChoice"; "queryString"; ""; "queryParameters"; ""; "fieldList"; "")
		$obCollectionBuild.tableName:="PopupChoice"
		$obCollectionBuild.queryString:="arrayName = :1"
		//$obCollectionBuild.queryParameters.push(Form.PopupCurrent.arrayName)
		$obCollectionBuild.queryValue1:=Form:C1466.PopupCurrent.arrayName
		$obCollectionBuild.fieldList:="choice,alternate,id"
		
		Form:C1466.cPopupChoice:=LBData_PopupChoice($obCollectionBuild)
		
End case 