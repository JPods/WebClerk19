//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/02/18, 08:53:51
// ----------------------------------------------------
// Method: jsonParseGoogleMap
// Description
// 
//
// Parameters
// --------------------($voTemp; "lat")


//  See OB_SetShared

//  Shareable vs Alterable entity selections  
//  https://doc.4d.com/4Dv18R5/4D/18-R5/Entity-selections.300-5126508.en.html

ARRAY TEXT:C222($at; 1)

APPEND TO ARRAY:C911($at; "Apple")
APPEND TO ARRAY:C911($at; "Orange")
APPEND TO ARRAY:C911($at; "Grape")

C_COLLECTION:C1488($sharedCol)
$sharedCol:=New shared collection:C1527

Use ($sharedCol)
	ARRAY TO COLLECTION:C1563($sharedCol; $at)
End use 