//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 09/23/19, 08:13:21
// ----------------------------------------------------
// Method: OB_CopyField
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_POINTER:C301($1; $vpvoSourceObject)
$vpvoSourceObject:=$1

C_TEXT:C284($2; $vtSourceKey)
$vtSourceKey:=$2

C_POINTER:C301($3; $vpvoDestinationObject)
$vpvoDestinationObject:=$3

C_TEXT:C284($4; $vtDestinationKey)
$vtDestinationKey:=$4

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

ARRAY OBJECT:C1221($aoValue; 0)
ARRAY BOOLEAN:C223($abValue; 0)
ARRAY LONGINT:C221($aiValue; 0)
ARRAY REAL:C219($arValue; 0)
ARRAY POINTER:C280($apValue; 0)
ARRAY TEXT:C222($atValue; 0)
ARRAY DATE:C224($adValue; 0)

C_TEXT:C284($vtJSON)
$vtJSON:=JSON Stringify:C1217($vpvoSourceObject->)

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

$viType:=OB_GetType($vpvoSourceObject->; $vtSourceKey)

Case of 
		
	: ($viType=Pointer array:K8:23)
		
		OB GET ARRAY:C1229($vpvoSourceObject->; $vtSourceKey; $apValue)
		OB SET ARRAY:C1227($vpvoDestinationObject->; $vtDestinationKey; $apValue)
		
	: ($viType=Date array:K8:20)
		
		OB GET ARRAY:C1229($vpvoSourceObject->; $vtSourceKey; $adValue)
		OB SET ARRAY:C1227($vpvoDestinationObject->; $vtDestinationKey; $adValue)
		
	: ($viType=Text array:K8:16)
		
		OB GET ARRAY:C1229($vpvoSourceObject->; $vtSourceKey; $atValue)
		OB SET ARRAY:C1227($vpvoDestinationObject->; $vtDestinationKey; $atValue)
		
	: ($viType=Object array:K8:28)
		
		OB GET ARRAY:C1229($vpvoSourceObject->; $vtSourceKey; $aoValue)
		OB SET ARRAY:C1227($vpvoDestinationObject->; $vtDestinationKey; $aoValue)
		
	: ($viType=Boolean array:K8:21)
		
		OB GET ARRAY:C1229($vpvoSourceObject->; $vtSourceKey; $abValue)
		OB SET ARRAY:C1227($vpvoDestinationObject->; $vtDestinationKey; $abValue)
		
	: ($viType=LongInt array:K8:19)
		
		OB GET ARRAY:C1229($vpvoSourceObject->; $vtSourceKey; $aiValue)
		OB SET ARRAY:C1227($vpvoDestinationObject->; $vtDestinationKey; $aiValue)
		
	: ($viType=Real array:K8:17)
		
		OB GET ARRAY:C1229($vpvoSourceObject->; $vtSourceKey; $arValue)
		OB SET ARRAY:C1227($vpvoDestinationObject->; $vtDestinationKey; $arValue)
		
	Else 
		
		OB SET:C1220($vpvoDestinationObject->; $vtDestinationKey; OB Get:C1224($vpvoSourceObject->; $vtSourceKey))
		
End case 

