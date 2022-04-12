//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/17/21, 06:23:38
// ----------------------------------------------------
// Method: Col_DistinctGet
// Description
// 
// Parameters
// ----------------------------------------------------


var $1; $0; $c; $c2 : Collection
var $2 : Text
$c:=New collection:C1472
var $answer_t : Text
For each ($answer_t; $1)
	$c.push(New object:C1471($2; $answer_t))
End for each 

$0:=$c