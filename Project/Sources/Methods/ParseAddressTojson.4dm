//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/13/19, 20:00:44
// ----------------------------------------------------
// Method: ParseAddressTojson
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1)
C_TEXT:C284($rawAddress)
C_OBJECT:C1216(objaddress)
$rawAddress:=$1->
// first name
// last name
// address1
// address2
// city
// state
// zip
// 

ARRAY TEXT:C222($atAddress; 0)
TextToArray($rawAddress; ->$atAddress; "\r"; True:C214)



