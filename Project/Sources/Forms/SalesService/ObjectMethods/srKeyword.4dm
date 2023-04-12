C_OBJECT:C1216($obSel; $obRec)


KeyWordByAlpha(Table:C252(->[Customer:2]); srKeyword; True:C214)
C_OBJECT:C1216($obSel; $obRec)
$obSel:=Create entity selection:C1512([Customer:2])
Form:C1466.cServiceActions:=New collection:C1472
C_COLLECTION:C1488($filter_c)
$filter_c:=New collection:C1472
$filter_c:=Split string:C1554("actionBy,action,actionDate,actionTime,company,nameFirst,nameLast,need,id"; ";")

If ($obSel#Null:C1517)
	$temp_c:=$obSel.toCollection($filter_c)
	For each ($obRec; $temp_c)
		$obRec.tableName:="Customer"
		$obRec.variable:=$obRec.need
		$obRec.attention:=$obRec.nameFirst+" "+$obRec.nameLast
		Form:C1466.cServiceActions.push($obRec)
	End for each 
End if 
