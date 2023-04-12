//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 07/29/21, 15:04:03
// ----------------------------------------------------
// Method: WindowCountToShow
// Description
// 
//
// Parameters
// ----------------------------------------------------
#DECLARE()->$window_o : Object

Process_ListActive
$window_o:=New object:C1471()
$window_o.count:=Size of array:C274(<>aPrsName)
$window_o.topOffset:=$window_o.count*20
$window_o.leftOffset:=$window_o.count*30
