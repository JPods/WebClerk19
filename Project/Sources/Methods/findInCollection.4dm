//%attributes = {}
// findInCollection (from Add K.)
// Modified by: Bill James (2023-03-09T06:00:00Z)
// Method: findInCollection
// Description 
// Parameters
// ----------------------------------------------------
/*
Calling examples
$col:=New collection()
$col.push(New object("a"; 2))
$col.push(New object("a"; 5))
$col.push(New object("a"; "x"))
$col.push(New object("a"; "y"))
$col.push(New object("a"; Current date))




$result:=$col.filter("findInCollection"; "a"; 2)
$result:=$col.filter("findInCollection"; "a"; "y")
$result:=$col.filter("findInCollection"; "a"; Current date)

var $k : Integer
$k:=$col.findIndex("findInCollection"; "a"; "y")
$k:=$col.findIndex("findInCollection"; "a"; 2)
$k:=$col.findIndex("findInCollection"; "a"; 5)
$k:=$col.findIndex("findInCollection"; "a"; "x")

$c:=New collection(1; 2; 3; 4; 5; 6; 7; 8; 9; 0)
$result:=$c.filter("findInCollection"; 3)

$c:=New collection("1"; "2"; "3"; "4"; "5"; "6"; "7"; "8"; "9"; "0")
$result:=$c.filter("findInCollection"; "7")

$c:=New collection(New object("name"; "aa"); \
New object("name"; "bb"); New object("name"; "cc"); New object("name"; "aa"))
$result:=$c.filter("findInCollection"; "name"; "aa")




*/

C_OBJECT:C1216($1)
C_VARIANT:C1683($2; $3)

Case of 
	: (Count parameters:C259=2)
		If (Value type:C1509($1.value)=Value type:C1509($2))
			$1.result:=Bool:C1537($1.value=$2)
		End if 
		
	: (Count parameters:C259=3)
		If (Value type:C1509($1.value[$2])=Value type:C1509($3))
			$1.result:=Bool:C1537($1.value[$2]=$3)
		Else 
			$1.result:=False:C215
		End if 
End case 