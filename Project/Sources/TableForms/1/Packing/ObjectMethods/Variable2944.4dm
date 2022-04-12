//TRACE

//If (<>vrWeightErrPC>5)
//<>pkScaleComment:="Weight Mismatch"
//PKAlertWindow 
//Else 
//TRACE
OBJECT SET ENABLED:C1123(b3; False:C215)  // disables button to prevent multiple clicking
PKBoxItemsTags
//<>vbPKScaleRead:=$skipWtMarker
//End if 

iLoReal3:=0