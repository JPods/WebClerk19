//%attributes = {}
var $date : cs:C1710.cDateTime
TRACE:C157



$date:=cs:C1710.cDateTime.new(Current date:C33)

$date.addDays(5)

$date.year:=2025

$test:=$date.getDate()
$testString:=$date.getDateString()

var $fullMonth : Text
$fullMonth:=$date.monthNameFull(Current date:C33)
