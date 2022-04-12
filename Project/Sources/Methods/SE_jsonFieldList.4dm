//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/17/19, 16:28:18
// ----------------------------------------------------
// Method: SE_jsonFieldList
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $1; $tableName)
C_LONGINT:C283($2; $cntPassed; $cntRay)
C_LONGINT:C283($tableNum)
$cntPassed:=0
If (Count parameters:C259>0)
	$tableName:=$1
	If (Count parameters:C259>1)
		$cntPassed:=$2
		$cntRay:=$cntPassed
	End if 
Else 
	$tableName:="Customer"
End if 
$tableNum:=STR_GetTableNumber($tableName)
If ($cntPassed=0)
	$cntPassed:=5
End if 
If ($tableNum#curTableNum)  // not in an existing TextSummary window)
	$cntRay:=$cntPassed
	curTableNum:=$tableNum
	StructureFields($tableNum)
	$scaleOfTest:="first 5 fields"
End if 
If ($cntRay>Size of array:C274(theFields))
	// if a very large number is passed cut it back to the number of fields
	$cntRay:=Size of array:C274(theFields)
End if 


C_LONGINT:C283($typeFld; $lenField; $numFld; $k; $w; $tableNum)
C_BOOLEAN:C305($indexed; $isUnique; $isInvisible)
C_TEXT:C284($fieldname)

C_TEXT:C284($fieldList)
For ($incRay; 1; $cntRay)
	// $fieldname:=Field name(Field(curTableNum;$incRay))
	// $fieldname:=theFields{aFieldLns{$incRay}}
	GET FIELD PROPERTIES:C258(curTableNum; theFldNum{aFieldLns{$incRay}}; $typeFld; $lenField; $indexed; $isUnique; $isInvisible)  // file #, field #, type, length, index
	If (($typeFld=Is picture:K8:10) | ($typeFld=Is BLOB:K8:12))  // | (theTypes{aFieldLns{$incRay}}="*"))  // no blobs or pictures
		If ($incRay=$cntRay)
			$fieldList:=Substring:C12($fieldList; 1; Length:C16($fieldList)-1)  // clip the comma
		End if 
	Else 
		$fieldList:=$fieldList+theFields{aFieldLns{$incRay}}
		If ($incRay<$cntRay)
			$fieldList:=$fieldList+","
		End if 
	End if 
End for 

$0:=$fieldList