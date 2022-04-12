//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/14/12, 17:43:50
// ----------------------------------------------------
// Method: XML_ReturnValue
// Description
// 

If (False:C215)
	XML_ReturnAttribute
	
End if 

//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $refElement; $2; $element; $refFound; $valueFound)
C_POINTER:C301($3; $ptPointerField; $4; $ptComment)
C_LONGINT:C283($0)
$0:=0
If (Count parameters:C259=4)
	$refElement:=$1
	$element:=$2
	$ptPointerField:=$3
	$ptComment:=$4
	//$refFound:=DOM Find XML element(vRefPaymentMethod;"payment-method/payment-record/cc/first-name")
	$refFound:=DOM Find XML element:C864($refElement; $element)
	If ($refFound#"0000@")
		DOM GET XML ELEMENT VALUE:C731($refFound; $valueFound)
		//iloText9:=
		$valueFound:=Parse_UnWanted($valueFound)
		Wcc_FieldFromText($ptPointerField; $valueFound)
		$ptComment->:=$valueFound
		$0:=1
	Else 
		$ptComment->:="Error, no parameter found"
	End if 
Else 
	$ptComment->:="Missing parameters"
End if 