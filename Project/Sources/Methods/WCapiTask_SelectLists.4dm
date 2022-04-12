//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/06/21, 22:15:53
// ----------------------------------------------------
// Method: WCapiTask_SelectList
// Description
//  all Init_SelectListObject
//
// Parameters$vtSelectList
// ----------------------------------------------------

TRACE:C157
// REPLACED

C_TEXT:C284($tableName; $vtSelectList; $vtChoices)
$tableName:="PopUp"
C_OBJECT:C1216($obSel; $obSelChoices; $obRecChoices; $obOutPut)
C_COLLECTION:C1488($cSelChoices)
$vtSelectList:=WCapi_GetParameter("selectList")
If ($vtSelectList="")
	Response:="Error: Failed to provide selectList"
Else 
	$obSel:=ds:C1482.PopUp.query("arrayName = :1"; "<>a"+$vtSelectList)
	If ($obSel.length#1)
		Response:="Error: No Popup selectList named: "+$vtSelectList
	Else 
		$obSelChoices:=ds:C1482.PopupChoice.query("arrayName = :1"; $obSel.first().arrayName)
		For each ($obRecChoices; $obSelChoices)
			$vtChoices:=$vtChoices+$obRecChoices.choice+","
		End for each 
		If (Length:C16($vtChoices)>0)
			$vtChoices:=Substring:C12($vtChoices; 1; Length:C16($vtChoices)-1)
		End if 
		// $cSelChoices:=$obSelChoices.toCollection("Choice")
		// $vtChoices:=$cSelChoices.join(",")
		$obOutPut:=New object:C1471($vtSelectList; $vtChoices)
		vResponse:=JSON Stringify:C1217($obRecChoices)
	End if 
End if 
voState.result:="Popup records in selection: "+String:C10($obSel.length)