//%attributes = {}

// Modified by: Bill James (2022-01-30T06:00:00Z)
// Method: Data_GarbageMake
// Description 
// Parameters
// ----------------------------------------------------
// make an exception table of data to be excluded from use and repetitively deleted until gone.

var $o; $garbage_o; $1 : Object
$o:=$1
For each ($o; $lockedSelection)
	$garbage_o:=ds:C1482.zzzGarbage.new()
	$garbage_o.idForeign:=$o.id
	$garbage_o.TableNum:=$o.getDataClass().tableNum
	$garbage_o.save()
End for each 