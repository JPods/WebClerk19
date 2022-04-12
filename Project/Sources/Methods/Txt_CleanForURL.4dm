//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/03/21, 14:25:26
// ----------------------------------------------------
// Method: Txt_CleanForURL
// Description
// 
// Parameters
// ----------------------------------------------------
var $1; $0; $incoming_t; $output_t : Text
// ($idUser_t=\\"\\")
$incoming_t:=$1
$incLetter:=0
$cnt:=Length:C16($incoming_t)
While ($incLetter<$cnt)
	$incLetter:=$incLetter+1
	$charCode:=Character code:C91($incoming_t[[$incLetter]])
	If ((($charCode>47) & ($charCode<58)) | \
		(($charCode>64) & ($charCode<91)) | \
		(($charCode>97) & ($charCode<123)))
		
		$output_t:=$output_t+$incoming_t[[$incLetter]]
	End if 
End while 
$0:=Replace string:C233($incoming_t; ":"; "")
//RegexExample
//Preg Replace