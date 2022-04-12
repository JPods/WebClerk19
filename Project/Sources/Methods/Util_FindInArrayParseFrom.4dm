//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-06-28T00:00:00, 09:14:30
// ----------------------------------------------------
// Method: Util_FindInArrayParseFrom
// Description
// Modified: 06/28/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $2; $3; $delimiter)
C_POINTER:C301($1)  // array
C_LONGINT:C283($w; $inString; $lengthDelimiter; $4; $startAt)
$delimiter:=""
$startAt:=0
If (Count parameters:C259>2)
	$delimiter:=$3
	$lengthDelimiter:=Length:C16($delimiter)
	If (Count parameters:C259>3)
		If ($4>0)
			$startAt:=$4
		End if 
	End if 
End if 
$2:=$2+"@"
$w:=Find in array:C230($1->; $2; $startAt)

If ($w<1)
	$0:=""
Else 
	If ($delimiter="")
		$0:=$1->{$w}
	Else 
		$0:=$1->{$w}
		$inString:=Position:C15($delimiter; $0)
		If ($inString>0)
			$0:=Substring:C12($0; $inString+$lengthDelimiter)
		End if 
	End if 
	
	$0:=Txt_TrimSpaces($0)
End if 