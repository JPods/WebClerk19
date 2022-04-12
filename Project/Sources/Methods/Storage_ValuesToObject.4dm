//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-09T06:00:00Z)
// Method: Storage_ValuesToObject
// Description 
// Parameters
// ----------------------------------------------------
var $1; $2; $voInput; $voShared : Object
$voInput:=$1
$voShared:=$2
ARRAY TEXT:C222($arrNames; 0)
OB GET PROPERTY NAMES:C1232($voInput; $arrNames; $arrTypes)
For ($counter; 1; Size of array:C274($arrNames))
	Case of 
			//Attribute type is object, copy with OB_CopyObject again
		: ($arrTypes{$counter}=Is object:K8:27)
			$voShared[$arrNames{$counter}]:=New shared object:C1526
			Use ($voShared[$arrNames{$counter}])
				Storage_ValuesToObject($voInput[$arrNames{$counter}]; $voShared[$arrNames{$counter}])
			End use 
			//Attribute type is collection, copy with OB_CopyCollection
		: ($arrTypes{$counter}=Is collection:K8:32)
			$voShared[$arrNames{$counter}]:=New shared collection:C1527
			Use ($voShared[$arrNames{$counter}])
				Storage_ValuesToCollection($voInput[$arrNames{$counter}]; $voShared[$arrNames{$counter}])
			End use 
		Else 
			// The rest supported types can be copied directly.
			$voShared[$arrNames{$counter}]:=$voInput[$arrNames{$counter}]
	End case 
End for 