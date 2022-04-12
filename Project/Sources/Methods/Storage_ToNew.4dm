//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-14T06:00:00Z)
// Method: Storage_ToNew
// Description 
// Parameters
// ----------------------------------------------------



var $1; $o : Object
var $2 : Variant
var $3; $vtTopic; $vtAction : Text
$o:=$1
If (Count parameters:C259=2)
	$vtTopic:=$2
	Use (Storage:C1525)
		Storage:C1525[$vtTopic]:=New shared object:C1526  // replace existing
		Use (Storage:C1525[$vtTopic])
			Storage_ToNew($o; Storage:C1525[$vtTopic]; "new")
		End use 
	End use 
Else 
	$voInput:=$1
	$voShared:=$2
	$vtAction:=$3
	ARRAY TEXT:C222($arrNames; 0)
	OB GET PROPERTY NAMES:C1232($voInput; $arrNames; $arrTypes)
	For ($counter; 1; Size of array:C274($arrNames))
		Case of 
				//Attribute type is object, copy with OB_CopyObject again
			: ($arrTypes{$counter}=Is object:K8:27)
				$voShared[$arrNames{$counter}]:=New shared object:C1526
				Use ($voShared[$arrNames{$counter}])
					Storage_ToNew($voInput[$arrNames{$counter}]; $voShared[$arrNames{$counter}]; $vtAction)
				End use 
				//Attribute type is collection, copy with OB_CopyCollection
			: ($arrTypes{$counter}=Is collection:K8:32)
				$voShared[$arrNames{$counter}]:=New shared collection:C1527
				Use ($voShared[$arrNames{$counter}])
					Storage_ValuesToCollection($voInput[$arrNames{$counter}]; $voShared[$arrNames{$counter}]; "new")
				End use 
			Else 
				// The rest supported types can be copied directly.
				$voShared[$arrNames{$counter}]:=$voInput[$arrNames{$counter}]
		End case 
	End for 
End if 