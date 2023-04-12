//%attributes = {}

// Modified by: Bill James (2022-05-30T05:00:00Z)
// Method: Txt_ClipFrom
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($working_t : Text; $find_t : Text)->$return : Text
var $p; $findLength : Integer
//$findLength:=$find_t.length
$findLength:=Length:C16($find_t)
$return:=$working_t
$p:=Position:C15($find_t; $working_t)
If ($p>0)
	$return:=Substring:C12($working_t; $p+$findLength)
End if 