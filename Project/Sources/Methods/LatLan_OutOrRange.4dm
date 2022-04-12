//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/27/21, 22:52:34
// ----------------------------------------------------
// Method: LatLan_OutOrRange
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($viRange; $1)
If (Count parameters:C259=1)
	$viRange:=$1/2
Else 
	$viRange:=200/2
End if 

// Latitude 1 degree ~ 69.172 miles
//  Longitude 69.172 at the equator, 53 miles at 40 degree
C_REAL:C285($vrLat; $vrLng; $vrLatSouth; $vrLngEast; $vrLatNorth; $vrLngWest)
C_OBJECT:C1216($obSel)
C_OBJECT:C1216(obLatLan)
obLatLan:=New object:C1471
$obSel:=ds:C1482.Default.query("primeDefault=1")
obLatLan.lat:=$obSel.first().lat
obLatLan.lng:=$obSel.first().lng
obLatLan.latSouth:=obLatLan.lat-1.5
obLatLan.latNorth:=obLatLan.lat+1.5
obLatLan.lngEast:=obLatLan.lng-1.5
obLatLan.lngWest:=obLatLan.lng+1.5
