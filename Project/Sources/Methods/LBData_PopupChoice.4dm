//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/09/21, 18:27:55
// ----------------------------------------------------
// Method: LBData_PopupChoice
// Description
// 
//
// Parameters
// ----------------------------------------------------
#DECLARE($voQuery : Object)->$result : Collection

C_COLLECTION:C1488($cTemp)
C_OBJECT:C1216($obSel)
$obSel:=ds:C1482[$voQuery.tableName].query($voQuery.queryString; $voQuery.queryValue1)
If (False:C215)
	Case of 
		: ($voQuery.parameters=1)
			$obSel:=ds:C1482[$voQuery.tableName].query($voQuery.queryString; $voQuery.parameters[1])
		: ($voQuery.parameters=2)
			$obSel:=ds:C1482[$voQuery.tableName].query($voQuery.queryString; $voQuery.parameters[1]; $voQuery.parameters[2])
		: ($voQuery.parameters=3)
			$obSel:=ds:C1482[$voQuery.tableName].query($voQuery.queryString; $voQuery.parameters[1]; $voQuery.parameters[2]; $voQuery.parameters[3])
		: ($voQuery.parameters=4)
			$obSel:=ds:C1482[$voQuery.tableName].query($voQuery.queryString; $voQuery.parameters[1]; $voQuery.parameters[2]; $voQuery.parameters[3]; $voQuery.parameters[4])
		: ($voQuery.parameters=5)
			$obSel:=ds:C1482[$voQuery.tableName].query($voQuery.queryString; $voQuery.parameters[1]; $voQuery.parameters[2]; $voQuery.parameters[3]; $voQuery.parameters[4]; $voQuery.parameters[5])
		: ($voQuery.parameters=6)
			$obSel:=ds:C1482[$voQuery.tableName].query($voQuery.queryString; $voQuery.parameters[1]; $voQuery.parameters[2]; $voQuery.parameters[3]; $voQuery.parameters[4]; $voQuery.parameters[5]; $voQuery.parameters[6])
			
	End case 
End if 
$obSel:=$obSel.orderBy("choice")
$cTemp:=New collection:C1472
C_COLLECTION:C1488($cFilter)
$cFilter:=Split string:C1554("choice,alternate,id"; ";")
$cTemp:=$obSel.toCollection($cFilter)

// Form.cPopupChoice:=$cTemp
$0:=$cTemp
