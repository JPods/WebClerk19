//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_COLLECTION:C1488($zePaths)
C_OBJECT:C1216($currentSelection)
C_TEXT:C284($zeProperty_name)
C_POINTER:C301($fieldPtr)
C_LONGINT:C283($tableNb;$fieldNb)

$currentSelection:=$1
$zeProperty_name:=$2

$zePaths:=New collection:C1472

$dataClass:=$currentSelection.getDataClass()
$tableNb:=$dataClass.getInfo().tableNumber
$fieldNb:=$dataClass[$zeProperty_name].fieldNumber
$fieldPtr:=Field:C253($tableNb;$fieldNb)

ARRAY TEXT:C222($ar_Paths;0)
USE ENTITY SELECTION:C1513($currentSelection)
DISTINCT ATTRIBUTE PATHS:C1395($fieldPtr->;$ar_Paths)
If (Size of array:C274($ar_Paths)>0)
	ARRAY TO COLLECTION:C1563($zePaths;$ar_Paths)
End if 

$0:=$zePaths