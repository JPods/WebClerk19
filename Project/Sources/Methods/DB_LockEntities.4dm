//%attributes = {}

// Modified by: Bill James (2022-01-25T06:00:00Z)
// Method: DB_LockEntities
// Description 
// Parameters
// ----------------------------------------------------


var $rec; $sel; $1; $status : Object
var $cntError; $0 : Integer
$cntError:=0
For each ($rec; $sel)
	$status:=$rec.lock(dk reload if stamp changed:K85:15)
	If (Not:C34($status.success))
		$cntError:=$cntError+1
	End if 
End for each 
$0:=$cntError