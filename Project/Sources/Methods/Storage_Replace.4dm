//%attributes = {}

// Modified by: Bill James (2022-01-14T06:00:00Z)
// Method: Storage_Replace
// Description 
// Parameters
// ----------------------------------------------------
//Storage_ToNew($default_o; "default")

var $1; $o : Object
var $2 : Variant
var $vtTopic; $3; $vtAction : Text
$o:=$1
If (Count parameters:C259=2)
	$vtTopic:=$2
	Use (Storage:C1525)
		If (Storage:C1525[$vtTopic]=Null:C1517)
			Storage:C1525[$vtTopic]:=New shared object:C1526  // replace existing
		End if 
		Use (Storage:C1525[$vtTopic])
			Storage_Replace($o; Storage:C1525[$vtTopic]; "recursive")
		End use 
	End use 
Else 
	$vtAction:=$3
	$voInput:=$1
	$voShared:=$2
	ARRAY TEXT:C222($arrNames; 0)
	OB GET PROPERTY NAMES:C1232($voInput; $arrNames; $arrTypes)
	For ($counter; 1; Size of array:C274($arrNames))
		Case of 
				//Attribute type is object, copy with OB_CopyObject again
			: ($arrTypes{$counter}=Is object:K8:27)
				If ($voShared[$arrNames{$counter}]=Null:C1517)
					$voShared[$arrNames{$counter}]:=New shared object:C1526
				End if 
				Use ($voShared[$arrNames{$counter}])
					Storage_Replace($voInput[$arrNames{$counter}]; $voShared[$arrNames{$counter}]; "recursive")
				End use 
				//Attribute type is collection, copy with OB_CopyCollection
			: ($arrTypes{$counter}=Is collection:K8:32)
				If (($voShared[$arrNames{$counter}]=Null:C1517) | ($vtAction="new"))
					$voShared[$arrNames{$counter}]:=New shared collection:C1527
				End if 
				Use ($voShared[$arrNames{$counter}])
					Storage_ValuesToCollection($voInput[$arrNames{$counter}]; $voShared[$arrNames{$counter}]; "replace")
				End use 
			Else 
				// The rest supported types can be copied directly.
				$voShared[$arrNames{$counter}]:=$voInput[$arrNames{$counter}]
		End case 
	End for 
End if 