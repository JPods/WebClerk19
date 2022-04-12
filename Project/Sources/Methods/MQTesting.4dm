//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/22/18, 12:09:36
// ----------------------------------------------------
// Method: MapTasQVariables
// Description
// 
//
// Parameters
// ----------------------------------------------------

// Sourish documentation page
//  https://docs.google.com/document/d/1n-oWi5vVtKNpH3GOloqV-iOsP01pQNb4pi5VdJNr1bU/edit?ts=5d519cb1

// display multiple addresses
// https://developers.google.com/maps/documentation/maps-static/intro

// importing
// https://developers.google.com/maps/documentation/javascript/importing_data

// example status message


///  Not part of this Begin Pod EventLoop   ///
var $o : Object

$o:=New object:C1471("wifi"; "OK"; "sensors"; Null:C1517; "switches"; Null:C1517; \
"motor"; Null:C1517; "location"; Null:C1517; "others"; Null:C1517)
$o.sensors:=New object:C1471("f_cam"; "bc value"; "r_cam"; "not installed"; \
"fr_ToF"; 100; "fl_ToF"; 100; "rf_ToF"; 85; "et..."; "ect...")
$o.switches:=New object:C1471("front"; "left"; "rear"; "left")
$o.motor:=New object:C1471("lastVolts"; 3.2; "currentVolts"; 3.4; "speed"; 53)
$o.location:=New object:C1471("we1"; 241; "we2"; 243; "toEZ"; 325; \
"toSwitch"; 375; "switchDirection"; "left"; "ezSlot"; 234234888)
$o.others:=New object:C1471
$o.others.onLine:=New object:C1471("1front"; New object:C1471("id"; "Blue"; "distance"; 143); \
"1back"; New object:C1471("id"; "Yellow"; "distance"; 98)); 
$o.others.ez:=New object:C1471("1front"; New object:C1471("id"; "Green"; "timeSlot"; 234234777); \
"1back"; New object:C1471("id"; "Cyan"; "timeSlot"; 234234999))
$o.others.marker:=New object:C1471("id"; "1223"; "action"; "reset encoder")
$o.others.more:=New object:C1471("more"; "stuff")
$text:=JSON Stringify:C1217($o)
///  Not part of this End ///

C_LONGINT:C283($1; $workOrderNum; $3; $contactUniqueID)
C_TEXT:C284($2; $customerID; $4; $action)
C_TEXT:C284($direction)
If (Count parameters:C259>0)
	$workOrderNum:=$1
	$customerID:=$2
	$contactUniqueID:=$3
	$direction:=$4
Else 
	
	$workOrderNum:=2200247
	
	$workOrderNum:=2200241
	$workOrderNum:=2200249
	
	$customerID:="JPods"
	$contactUniqueID:=3229
	$direction:="Send"
	QUERY:C277([SyncRelation:103]; [SyncRelation:103]name:8="Sourish-MapTasQ")
	QUERY:C277([WorkOrder:66]; [WorkOrder:66]woNum:29=$workOrderNum)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=$customerID)
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=3230)
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=3229)  // jimmy dean
	<>viDebugMode:=411
End if 


$apiAction:="API_APP_UPDATE_WORK"

If (False:C215)
	
	
	$apiAction:="REGISTER_ADMIN"
	
	$apiAction:="REGISTER_MEMBER"
	
	$apiAction:="API_ADD_AND_LINK_WORK"
	
	$apiAction:="API_PULL_WORK_LIST"
	
	$apiAction:="API_ALLOCATION-ADD"
	
	$apiAction:="API_ALLOCATION-DELETE"
	
	
	$apiAction:="WORKER_DETAIL_REQUEST"
	
	$apiAction:="WORK_IMAGES_REQUEST"
	
	$apiAction:="API_APP_UPDATE_WORK"
End if 

C_TEXT:C284($template; $textFinal)
QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8=$apiAction)
$template:=[TallyMaster:60]template:29
REDUCE SELECTION:C351([TallyMaster:60]; 0)

C_OBJECT:C1216($voSynRecRelate)
RP_LoadVariablesRelationship  // load the SyncRelationship varibles


MQWOEvent($apiAction)  // create message record
C_LONGINT:C283($woeventID)
$woeventID:=[WorkOrderEvent:121]idNum:1


C_TEXT:C284($worker)
$worker:="jimmy dean"
QUERY:C277([Contact:13]; [Contact:13]idNum:28=3229)  // jimmy dean
$worker:="Sourish"
QUERY:C277([Contact:13]; [Contact:13]idNum:28=3230)  // Sourish
$worker:="Bill"
QUERY:C277([Contact:13]; [Contact:13]idNum:28=3231)  // bill


MQVariables($direction)  // translate variables
C_TEXT:C284($working)
$working:=TagsToText($template)  // convert tags to values
SET BLOB SIZE:C606(HTTP_Data; 0)
TEXT TO BLOB:C554($working; HTTP_Data; UTF8 text without length:K22:17)
HTTP_ContentType:="application/json"



// ### bj ### 20181222_1914, delete this after debugging
If (<>viDebugMode>410)  // save the exact message
	[WorkOrderEvent:121]messageOut:17:=$working
	[WorkOrderEvent:121]obGeneral:11:=JSON Parse:C1218($working)  // try this 
	SAVE RECORD:C53([WorkOrderEvent:121])
End if 

HTTPClient_URL:=HTTP_Host
vDataReceived:=""  // clear data from receive variable
$error:=WC_Request("POST")  // post to MapTasQ

// vWCPayload  =  vDataReceived  // should contain the payload received back
//  incoming blob   // HTTP_IncomingBlob
// aHeaderNameIn  // header names/values
// aHeaderValueIn
// aParameterName  // parameter names/values
// aParameterValue

If (<>viDebugMode>410)  // save the exact message
	[WorkOrderEvent:121]messageIn:18:=vDataReceived
	SAVE RECORD:C53([WorkOrderEvent:121])
End if 

REDUCE SELECTION:C351([WorkOrderEvent:121]; 0)
REDUCE SELECTION:C351([SyncRelation:103]; 0)
REDUCE SELECTION:C351([WorkOrder:66]; 0)
REDUCE SELECTION:C351([Customer:2]; 0)
REDUCE SELECTION:C351([Contact:13]; 0)
If ((<>viDebugMode>410) | (Caps lock down:C547))
	C_TEXT:C284($script)
	$script:="QUERY([WorkOrderEvent];[WorkOrderEvent]UniqueID="+String:C10($woeventID)+")"
	ProcessTableOpen(Table:C252(->[WorkOrderEvent:121]); $script; $apiAction)
	
End if 


If (False:C215)
	
	
	Case of 
		: ($apiAction="API_ALLOCATION")
		: ($apiAction="API_ADD_AND_LINK_WORK")
		: ($apiAction="ADD_WORKERS_TO_WORK")
		: ($apiAction="REGISTER_MEMBER")
		: ($apiAction="REGISTER_ADMIN")
		: ($apiAction="WORKER_DETAIL_REQUEST")
		: ($apiAction="WORK_IMAGES_REQUEST")
		: ($apiAction="API_APP_UPDATE_WORK")
	End case 
	
	ARRAY TEXT:C222($apiCalls; 0)
	APPEND TO ARRAY:C911($apiCalls; "API_ALLOCATION")
	APPEND TO ARRAY:C911($apiCalls; "API_ADD_AND_LINK_WORK")
	APPEND TO ARRAY:C911($apiCalls; "ADD_WORKERS_TO_WORK")
	APPEND TO ARRAY:C911($apiCalls; "REGISTER_MEMBER")
	APPEND TO ARRAY:C911($apiCalls; "REGISTER_ADMIN")
	APPEND TO ARRAY:C911($apiCalls; "WORKER_DETAIL_REQUEST")
	APPEND TO ARRAY:C911($apiCalls; "WORK_IMAGES_REQUEST")
	APPEND TO ARRAY:C911($apiCalls; "API_APP_UPDATE_WORK")
	
End if 