//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/26/21, 00:33:26
// ----------------------------------------------------
// Method: Process_ShowTableDS
// Description
// 
// Parameters
// ----------------------------------------------------
#DECLARE($o : Object)
//var process_o : cs.cProcess
// $o is instantiated as a cs.cProcess in the sending process
process_o:=$o

var $obWindows : Object
$obWindows:=WindowCountToShow
//var $window_i : Integer

//$window_i:=Open form window(\
process_o.dialog; \
Plain form window; \
$obWindows.leftOffset; \
53+$obWindows.topOffset)

var $leftOS; $topOS : Integer
$leftOS:=$obWindows.leftOffset
$topOS:=53+$obWindows.topOffset
$window_i:=Open form window:C675(\
process_o.dialog; \
Plain form window:K39:10; \
$leftOS; \
$topOS)

//$window_i:=Open form window(\
process_o.dialog; \
Plain form window; \
process_o.window_o.leftOffset; \
53+process_o.window_o.topOffset)

process_o.window_i:=$window_i

If (process_o.fc#Null:C1517)
	// store the form in the FC record
	DIALOG:C40(process_o.fc.data.dialog; process_o)
Else 
	DIALOG:C40(process_o.dialog; process_o)
End if 
CLOSE WINDOW:C154(process_o.window_i)
process_o.destructor()

DELAY PROCESS:C323(Current process:C322; 30)
CALL WORKER:C1389("Processes"; "Process_ListActive")
