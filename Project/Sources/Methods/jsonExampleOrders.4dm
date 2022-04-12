//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/26/18, 22:51:38
// ----------------------------------------------------
// Method: jsonExampleOrders
// Description
// 
//
// Parameters
// ----------------------------------------------------

ARRAY TEXT:C222($atHeader; 0)
ARRAY TEXT:C222($atBody; 0)
ARRAY TEXT:C222($atCustomers; 0)
ARRAY TEXT:C222($atOrders; 0)
ARRAY TEXT:C222($atOrderLines; 0)

ARRAY OBJECT:C1221($objArrayIn; 0)
// $atHeader


C_OBJECT:C1216($objHeader)
OB SET:C1220($objHeader; "header"; $atHeader)
OB SET:C1220($objHeader; "Text"; "Hello world!")
OB SET:C1220($objHeader; "Boolean"; True:C214)


C_OBJECT:C1216($objCustomers)
C_OBJECT:C1216($objOrders)
C_OBJECT:C1216($objOrderLines)

APPEND TO ARRAY:C911($atHeader; "header")
APPEND TO ARRAY:C911($atHeader; "tuesday")
APPEND TO ARRAY:C911($atHeader; "wednesday")