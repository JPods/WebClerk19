//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-26T00:00:00, 23:44:21
// ----------------------------------------------------
// Method: jsonSelectionBuild
// Description
// Modified: 08/26/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($template)
C_TEXT:C284($tableName; $0)
C_LONGINT:C283($inc; $cnt; $tableNum)
C_POINTER:C301($ptTable; $ptField; $1; $2)
ARRAY LONGINT:C221($aFieldNums; 0)
ARRAY POINTER:C280($aPtFields; 0)

If (Count parameters:C259=0)  // to work in Summary Editor
	$tableNum:=curTableNum
	$ptTable:=Table:C252($tableNum)
	$cnt:=Size of array:C274(aFieldLns)
	ARRAY POINTER:C280($aPtFields; $cnt)
	For ($inc; 1; $cnt)
		$aPtFields{$inc}:=Field:C253(curTableNum; theFldNum{aFieldLns{$inc}})
	End for 
	ALL RECORDS:C47($ptTable->)
	REDUCE SELECTION:C351(Table:C252(curTableNum)->; 10)
Else 
	$ptTable:=$1
	COPY ARRAY:C226($2; $aPtFields)
End if 
$tableName:="["+Table name:C256($ptTable)+"]"
$cnt:=Size of array:C274(aFieldLns)
C_TEXT:C284($textToCall)
$textToCall:="vText1:=Selection to JSON("+$tableName+""


For ($inc; 1; $cnt)
	$textToCall:=$textToCall+";"+$tableName+Field name:C257($aPtFields{$inc})
End for 
$textToCall:=$textToCall+")"
ExecuteText(0; $textToCall)
$0:=vText1
If (False:C215)
	For ($inc; 1; $cnt)
		OB SET:C1220($template; $tableName; $aPtFields)  //custom label and a single field
	End for 
	$0:=Selection to JSON:C1234($ptTable->; $template)
End if 
// $jsonString = [{"Member":"Durant"},{"Member":"Smith"},{"Member":"Anderson"},
// {"Member":"Albert"},{"Member":"Leonard"},{"Member":"Pradel"}]