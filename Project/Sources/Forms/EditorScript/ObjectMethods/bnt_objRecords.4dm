
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-27T00:00:00, 01:25:56
// ----------------------------------------------------
// Method: b32
// Description
// Modified: 08/27/17curTableNum
// 
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
$vtFieldList:=SE_jsonFieldList($tableName; Size of array:C274(aFieldLns))
C_OBJECT:C1216($veSelection)
$veSelection:=API_SelectionToObject($tableName)
$jsondata:=API_EntityToText($veSelection; $vtFieldList)
//end if
vTextSummary:=vTextSummary+(Num:C11(vTextSummary#"")*("\r"*3))+$jsondata

