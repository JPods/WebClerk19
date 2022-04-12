//%attributes = {}

// Modified by: Bill James (2021-11-20T06:00:00Z)
// Method: Txt_ClearExtraReturns
// Description 
// Parameters
// ----------------------------------------------------
var $1; $0 : Text
var $len : Integer


Repeat 
	$len:=Length:C16($1)
	$1:=Replace string:C233($1; "\r"+"\r"; "\r")
Until (Length:C16($1)=$len)
$0:=$1
