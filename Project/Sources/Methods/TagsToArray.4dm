//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-18T00:00:00, 09:25:10
// ----------------------------------------------------
// Method: TagsToArray
// Description
// Modified: 12/18/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($field; $pFormat; $intQualifier; $p)
C_TEXT:C284($0; $strField; $myText)
C_TEXT:C284($strQualifier; $strFormat; $strExt)
C_POINTER:C301($pA)
$strFormat:=vWebTagFormat

// need to add type and formatting
$pA:=Get pointer:C304(vWebTagField)
$text:=""
For ($i; 1; Size of array:C274($pA->))
	$text:=$text+$pA->{$i}+Char:C90(13)
End for 
$0:=$text


If (False:C215)
	
	If (($pFormat>0) & ($1#-6))
		// TRACE
		$strField:=Substring:C12($2; 1; $pFormat-1)
		$strFormat:=Substring:C12($2; $pFormat+1)
		$strExt:="."+$strFormat
		$intQualifier:=Num:C11($strFormat)
		$strQualifier:="###,###,###,###,##0"+("."*Num:C11($intQualifier>0))+("0"*$intQualifier)
	Else 
		$strExt:=""
		$strField:=$2
		$strQualifier:=<>WebRealFormat
		$intQualifier:=<>vlWebRealPr
	End if 
	
End if 
