//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/10/21, 00:36:38
// ----------------------------------------------------
// Method: QueryEd_ObjectBuild
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_OBJECT:C1216($voQuery; $voLine; $0)
ARRAY OBJECT:C1221($aObQueries; 0)
$voQuery:=New object:C1471
$voQuery.tableName:=Table name:C256(curTableNum)
C_LONGINT:C283($incRay; $cntRay)
$cntRay:=Size of array:C274(aQueryBooleans)
For ($incRay; 1; $cntRay)
	$voLine:=New object:C1471
	$voLine.field:=Substring:C12(aQueryFieldNames{$incRay}; Position:C15("]"; aQueryFieldNames{$incRay})+1)
	$voLine.operator:=aQueryOperators{$incRay}
	$voLine.value:=aQueryValues{$incRay}
	$voLine.boolean:=aQueryBooleans{$incRay}
	$voLine.allowEmpty:="true"
	APPEND TO ARRAY:C911($aObQueries; $voLine)
End for 
OB SET ARRAY:C1227($voQuery; "queries"; $aObQueries)
$0:=$voQuery