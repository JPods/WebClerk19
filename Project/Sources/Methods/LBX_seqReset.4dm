//%attributes = {}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/16/21, 18:55:23
// ----------------------------------------------------
// Method: LBX_seqReset
// Description
// 
// Parameters
// ----------------------------------------------------
var $1; $es : Object
$es:=$1
var $2 : Text
//local Function reSeq($es : cs.EntitySelection)  // resequence all of these, according to their current order
//var $esNewSeq : cs.EntitySelection
If (Count parameters:C259>1)
	$esNewSeq:=$es.orderBy($2)  // we are keeping it in the same 'sequencing' but eliminating any missing seq numbers
End if 
var $idx : Integer
For each ($en; $esNewSeq)
	$idx:=$idx+1
	If ($en.seq#$idx)  // if there is an error in this one, fix it
		$en.seq:=$idx
		$en.save()
	End if 
End for each 