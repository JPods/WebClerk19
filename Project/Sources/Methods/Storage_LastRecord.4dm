//%attributes = {}

// Modified by: Bill James (2022-01-15T06:00:00Z)
// Method: Storage_LastRecord
// Description 
// Parameters
// ----------------------------------------------------
var $1; $2 : Text
Use (Storage:C1525)
	Use (Storage:C1525.lastEntity)
		Storage:C1525.lastEntity[$1]:=$2
	End use 
End use 