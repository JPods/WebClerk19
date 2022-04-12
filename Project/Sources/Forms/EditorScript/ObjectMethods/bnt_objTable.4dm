
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/21/20, 14:08:31
// ----------------------------------------------------
// Method: [Control].SummaryText.jsonTable
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($error)
//  CHOPPED  $error:=AL_GetSelect(eExportFlds; aFieldLns)



C_LONGINT:C283($incRay; $cntRay)
C_LONGINT:C283($processNum)
C_TEXT:C284($tableName; $fieldList)
C_POINTER:C301($ptTable)
$ptTable:=Table:C252(curTableNum)
$tableName:=Table name:C256(curTableNum)
$cntRay:=Size of array:C274(<>aPrsName)
$processNum:=0
For ($incRay; 1; $cntRay)
	If (Position:C15($tableName; <>aPrsName{$incRay})>0)
		$processNum:=<>aPrsNum{$incRay}
		$incRay:=$cntRay
	End if 
End for 
READ ONLY:C145($ptTable->)
If ($processNum>0)
	<>prcControl:=401
	// <>aSummaryRecords
	POST OUTSIDE CALL:C329($processNum)
	Repeat 
		DELAY PROCESS:C323($processNum; 10)
	Until (<>prcControl=0)
	CREATE SELECTION FROM ARRAY:C640($ptTable->; <>aSummaryRecords)
	ARRAY LONGINT:C221(<>aSummaryRecords; 0)
Else 
	ALL RECORDS:C47($ptTable->)
	REDUCE SELECTION:C351($ptTable->; 7)
End if 
C_TEXT:C284($tableName; $fieldList; $tallyMasterName; $fieldValue)
C_TEXT:C284($vtFieldList)
$vtFieldList:=SE_TextFromSelectedFields(->theFields; ->aFieldLns)
C_OBJECT:C1216($voSelection)
$voSelection:=New object:C1471
$voSelection:=API_SelectionToObject($tableName)
$jsondata:=API_EntityToText($voSelection; $vtFieldList)

vTextSummary:=vTextSummary+(Num:C11(vTextSummary#"")*("\r"*3))+$jsondata

