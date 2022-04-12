//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-30T06:00:00Z)
// Method: InfoRep
// Description 
// Parameters
// ----------------------------------------------------


var $1; pvRepAcct : Text
var pvRepCo : Text

If ($1#pvRepAcct)
	$o:=ds:C1482.Rep.query("repID= :1"; $1)
	If ($o=Null:C1517)
		pvRepAcct:=""
		pvRepCo:=""
	Else 
		pvRepAcct:=""
		pvRepCo:=""
		$2->:=$o.repID
		$3->:=$o.company
	End if 
End if 