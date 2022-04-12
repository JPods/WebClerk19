//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/31/21, 00:43:52
// ----------------------------------------------------
// Method: GoogleMap_LatLngAll
// Description
// 
//
// Parameters
// ----------------------------------------------------
#DECLARE($tableName : Text)
If (Count parameters:C259=0)
	$tableName:="Customer"
End if 
C_OBJECT:C1216($veSelection)
$veSelection:=ds:C1482[$tableName].query("lat = :1 OR lng =:2"; 0; 0)

TRACE:C157
GoogleMaps_LatLng($veSelection)
