//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 05/11/20, 11:37:16
// ----------------------------------------------------
// Method: KeyWordCleanup
// Description
//
//
// Parameters
// ----------------------------------------------------
var $0; $1; $vtCleaned; $vtText; $word : Text
var $2; $ptArray : Pointer
var $words_c; $clean_c : Collection
$clean_c:=New collection:C1472
$ptArray:=$2

$vtCleaned:=Replace string:C233($1; ", "; ";")
$keyWords:=Replace string:C233($keyWords; ","; ";")
$keyWords:=Replace string:C233($keyWords; "; "; ";")
$vtCleaned:=Replace string:C233($vtCleaned; " "; ";")
$words_c:=Split string:C1554($vtCleaned; ";")
$words_c:=$words_c.distinct()

For each ($word; $words_c)
	If (Length:C16($word)>1)
		$clean_c.push($word)
	End if 
End for each 
$0:=$clean_c.join(";")
