//%attributes = {}

// Modified by: Bill James (2023-01-03T06:00:00Z)
// Method: TextToCollection
// Description 
// Parameters
// ----------------------------------------------------
//Internal error while compiling with clang
#DECLARE($working_t : Text; $delim : Text; \
$allowEmpty : Boolean; $vbUnique : Boolean)->$c : Collection

If ($delim="")
	$delim:=","
End if 
If (Not:C34($allowEmpty))
	$working_t:=Replace string:C233($working_t; $delim+$delim; $delim)
End if 
$c:=Split string:C1554($response; $delim)
If ($vbUnique)
	$c:=$c.distinct()
End if 