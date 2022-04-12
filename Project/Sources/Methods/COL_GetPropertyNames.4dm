//%attributes = {}
// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 05/13/19, 08:37:24
// ----------------------------------------------------
// Method: COL_GetPropertyNames
//
// Description:


// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

// $vtReturn IS THE COMMA-DELIMITED RETURN TEXT
C_COLLECTION:C1488($0; $vcPropertyNamesTotal)
$vcPropertyNamesTotal:=New collection:C1472

// PARAMETER 1 IS THE TABLE NAME
C_COLLECTION:C1488($1; $vcCollectionOfObjects)
$vcCollectionOfObjects:=$1



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

// $voRow IS EACH ROW OF DATA
C_OBJECT:C1216($voObject)

// $atHeaders IS THE FULL SET OF KEYS FROM THE OBJECTS IN THE ARRAY
ARRAY TEXT:C222($atPropertyNames; 0)
C_COLLECTION:C1488($vcPropertyNames)
$vcPropertyNames:=New collection:C1472


// ******************************************************************************************** //
// ** LOOP THROUGH SPECIFIED FIELDS AND RECORDS ON HAND TO BUILD CSV ************************** //
// ******************************************************************************************** //



For each ($voObject; $vcCollectionOfObjects)
	
	OB GET PROPERTY NAMES:C1232($voObject; $atPropertyNames)
	ARRAY TO COLLECTION:C1563($vcPropertyNames; $atPropertyNames)
	$vcPropertyNamesTotal.combine($vcPropertyNames)
	
End for each 

$vcPropertyNamesTotal:=$vcPropertyNamesTotal.distinct()


// ******************************************************************************************** //
// ** RETURN THE VALUE ************************************************************************ //
// ******************************************************************************************** //

$0:=$vcPropertyNamesTotal