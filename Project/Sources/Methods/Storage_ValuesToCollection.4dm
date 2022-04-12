//%attributes = {}

// Modified by: Bill James (2022-01-09T06:00:00Z)
// Method: Storage_ValuesToCollection
// Description 
// Parameters
// ----------------------------------------------------

var $1; $2; $vcInput; $vcShared : Collection
var $counter : Integer
var $3; $vtAction : Text
$vcInput:=$1
$vcShared:=$2
$vtAction:=$3
For ($counter; 0; $vcInput.length-1)
	Case of 
		: (Value type:C1509($vcInput[$counter])=Is object:K8:27)
			$vcShared[$counter]:=New shared object:C1526  // collections must replace
			Use ($vcShared[$counter])
				//Element type is object, copy with OB_CopyObject
				Storage_Replace($vcInput[$counter]; $vcShared[$counter]; "recursive")
			End use 
		: (Value type:C1509($vcInput[$counter])=Is collection:K8:32)
			//Element type is collection, copy with OB_CopyCollection //Element type is collection, copy with OB_CopyCollection//Element type is collection, copy with OB_CopyCollection
			$vcShared[$counter]:=New shared collection:C1527  // collections must replace
			Use ($vcShared[$counter])
				Storage_ValuesToCollection($vcInput[$counter]; $vcShared[$counter])
			End use 
		Else 
			// Other supported types can be copied directly.
			$vcShared[$counter]:=$vcInput[$counter]
	End case 
End for 
