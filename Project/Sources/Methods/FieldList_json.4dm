//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/22/20, 00:07:32
// ----------------------------------------------------
// Method: FieldList_json
// Description
// 
// ----------------------------------------------------

C_TEXT:C284($0; $1; $tableName; $vtTableLC)
C_LONGINT:C283($cntFields)
C_OBJECT:C1216($voFields; $voField)
C_TEXT:C284($vtFieldList; $vtWebType; $textAdd)
C_POINTER:C301($ptField)

C_LONGINT:C283($typeFld; $lenField; $numFld)
C_BOOLEAN:C305($indexed; $isUnique; $isInvisible)
If (Count parameters:C259=1)
	$tableName:=$1
Else 
	$tableName:="Employee"
End if 
$k:=Size of array:C274(aFieldLns)
$textAdd:=""
For ($i; 1; $k)
	$ptField:=STR_GetFieldPointer($tableName; theFields{aFieldLns{$i}})
	GET FIELD PROPERTIES:C258($ptField; $typeFld; $lenField; $indexed; $isUnique; $isInvisible)  // file #, field #, type, length, index
	If (($typeFld=Is picture:K8:10) | ($typeFld=Is BLOB:K8:12))
		// no blobs or pictures
	Else 
		$textAdd:=$textAdd+theFields{aFieldLns{$i}}
		If ($i<$k)
			$textAdd:=$textAdd+","
		End if 
	End if 
End for 
$0:=$tableName+"\r"+"["+$textAdd+"]"


