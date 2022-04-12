//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/14/12, 17:44:02
// ----------------------------------------------------
// Method: XML_ReturnAttribute
// Description
// 
If (False:C215)
	XML_ReturnValue
	
End if 
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $refElement; $2; $element; $refFound; $valueFound; $3; $attributeName)
C_POINTER:C301($4; $ptComment)
C_LONGINT:C283($0)
$0:=0

If (Count parameters:C259=4)
	$refElement:=$1
	$element:=$2
	$attributeName:=$3
	$ptComment:=$4
	
	
	$refFound:=DOM Find XML element:C864($refElement; $element)
	If ($refFound#"0000@")
		DOM GET XML ATTRIBUTE BY NAME:C728($refFound; $attributeName; $valueFound)
		$ptComment->:=$valueFound
		$0:=1
	End if 
End if 