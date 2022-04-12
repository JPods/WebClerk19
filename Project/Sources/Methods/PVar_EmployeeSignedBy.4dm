//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-28T06:00:00Z)
// Method: PVar_EmployeeSignedBy
// Description 
// Parameters
// ----------------------------------------------------


var $0 : Text
var $1; $userName : Text
var $rec_o : Object
If (Count parameters:C259=1)
	$userName:=$1
Else 
	$userName:=Current user:C182
End if 
$0:=$userName
$rec_o:=ds:C1482.Employee.query("nameID = :1"; $userName).first()
If ($rec_o#Null:C1517)
	If ($rec_o.nameNick#"")
		$0:=$rec_o.nameNick
	Else 
		$0:=jConcat($rec_o.nameFirst)+" "+$rec_o.nameLast
	End if 
End if 
