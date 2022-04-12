//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/19/18, 09:19:28
// ----------------------------------------------------
// Method: RPFieldCharacteristics
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $output)
C_LONGINT:C283($1)
C_LONGINT:C283($2; $viSecurityLevel)

$viSecurityLevel:=-222
If (Count parameters:C259>1)
	$viSecurityLevel:=$2
End if 

QUERY:C277([FieldCharacteristic:94]; [FieldCharacteristic:94]securityLevel:3=$viSecurityLevel; *)
QUERY:C277([FieldCharacteristic:94];  & [FieldCharacteristic:94]tableNumber:1=$1; *)
QUERY:C277([FieldCharacteristic:94];  & [FieldCharacteristic:94]fieldName:8#"")
ARRAY TEXT:C222($atFieldNames; 0)
If (Records in selection:C76([FieldCharacteristic:94])>0)
	SELECTION TO ARRAY:C260([FieldCharacteristic:94]fieldName:8; $atFieldNames)
	For ($incRay; 1; $cntRay)
		$output:=$output+$atFieldNames{$incRay}
		If ($incRay<$cntRay)
			$output:=$output+","
		End if 
	End for 
End if 
$0:=$output