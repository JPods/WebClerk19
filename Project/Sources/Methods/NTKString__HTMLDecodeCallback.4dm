//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/19/08, 08:58:09
// ----------------------------------------------------
// Method: NTKString__HTMLDecodeCallback
// Description
// 
//
// Parameters
// ----------------------------------------------------
// (PM) String__HTMLDecodeCallback
// Decodes a HTML entity
// $1 = Entity reference
// $0 = Replacement value

C_TEXT:C284($1; ${2}; $entity)
C_TEXT:C284($0; $replacement)
C_LONGINT:C283($codepoint; $item)

$entity:=$1
$replacement:=""

If ($entity="&#@;")  // It's a numerical entity
	
	$entity:=Substring:C12($entity; 3; Length:C16($entity)-1)
	If ($entity="x@")
		$codepoint:=NTKString_HexToDecimal($entity)
	Else 
		$codepoint:=Num:C11($entity)
	End if 
	$replacement:=Char:C90($codepoint)
	
Else   // It's a named entity
	
	// Perform a case-senstive find in array because we need to distinguish between uppercase and lowercase characters
	$item:=NTKArray_FindCaseSensitive(-><>HTML_Entities; $entity)
	If ($item#-1)
		$replacement:=Char:C90($item)
	End if 
	
End if 

$0:=$replacement