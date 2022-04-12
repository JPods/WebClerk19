//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/23/18, 12:40:17
// ----------------------------------------------------
// Method: WC_ganttReceive
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $socket; $duration; $sizeIncoming)
C_POINTER:C301($2; $ptBlob)
// ----------------------------------------------------
C_TEXT:C284($working)
C_BLOB:C604($data)
$socket:=voState.socket

C_LONGINT:C283($p)
// ### bj ### 20190131_1253
C_LONGINT:C283(<>viGanttSave)
If (<>viGanttSave<2)
	<>viGanttSave:=2
End if 
C_BOOLEAN:C305($notLocal)
If ((vWCRequestHost="localhost@") | (vWCRequestHost="127.0.0.1"))
	$notLocal:=False:C215
End if 

If ((<>viGanttSave>viSecureLvl) & ($notLocal))
	vResponse:="Your Security Level "+String:C10(viSecureLvl)+" does not permit saving Projects."
Else 
	C_TEXT:C284($host)
	vResponse:="No SyncRelation record available."
	$host:=PageGetHeader("Host")
	C_TEXT:C284(vUUIDKeypr)
	vUUIDKeypr:=WCapi_GetParameter("vUUIDKeypr"; "")
	If (vUUIDKeypr="")  // adjust if the page has not be modified from the original parameter
		vUUIDKeypr:=WCapi_GetParameter("CM"; "")
	End if 
	// consider an option to allow uncreated projects to be created
	
	QUERY:C277([SyncRelation:103]; [SyncRelation:103]hostRemote:50=$host; *)  // confirm there is a relationship
	QUERY:C277([SyncRelation:103];  & ; [SyncRelation:103]name:8="jquerygantt"; *)
	QUERY:C277([SyncRelation:103];  & ; [SyncRelation:103]active:17=True:C214)
	If (Records in selection:C76([SyncRelation:103])=0)
		vResponse:="A SyncRelation record does not exist for host: "+$host
	Else 
		If (Records in selection:C76([SyncRelation:103])>1)
			FIRST RECORD:C50([SyncRelation:103])
		End if 
		$working:=WCapi_GetParameter("prj"; "")
		If ($working="")
			$working:=ConvertUnixChar(vWCPayload)
			// $working:=JSONStringifyClean(vWCPayload)
			$p:=Position:C15("{"; $working)
			If ($p<1)
				vResponse:="Not a recognized gantt json."
			Else 
				vResponse:="Gantt update received."
				$working:=Substring:C12($working; $p)
			End if 
		Else 
			$working:=ConvertUnixChar($working)
			// $working:=JSONStringifyClean($working)
			vResponse:="Gantt update received."
		End if 
		
		CREATE RECORD:C68([SyncRecord:109])
		[SyncRecord:109]date:26:=Current date:C33
		[SyncRecord:109]approvedByReceive:9:=Current user:C182
		[SyncRecord:109]approvedBySend:10:=$host
		[SyncRecord:109]body:34:=$working
		// only if received.
		[SyncRecord:109]obReceived:46:=JSON Parse:C1218([SyncRecord:109]body:34)
		[SyncRecord:109]comment:25:="ProjectUUIDKey: "+vUUIDKeypr
		[SyncRecord:109]dtAction:2:=DateTime_Enter
		[SyncRecord:109]dtCreated:15:=[SyncRecord:109]dtAction:2
		[SyncRecord:109]statusReceive:19:="jQuery-Gantt"
		[SyncRecord:109]statusSend:17:=""
		[SyncRecord:109]size:38:=Length:C16([SyncRecord:109]body:34)
		[SyncRecord:109]host:45:=$host
		[SyncRecord:109]purpose:40:="jquerygantt"
		SAVE RECORD:C53([SyncRecord:109])
		
		If ((vUUIDKeypr="SVPROJEC@") | (vUUIDKeypr="NewPro@"))
			CREATE RECORD:C68([Project:24])
			[Project:24]idNum:1:=CounterNew(->[Project:24])
			[Project:24]dateGantt:17:=Current date:C33
			[Project:24]obGeneral:28:=JSON Parse:C1218($working)
			[Project:24]dateDocument:10:=Current date:C33
			[Project:24]ganttStatus:16:="jQuery-Gantt created"
			[Project:24]attention:27:="ReName"  // fill this in
			
			[Project:24]publish:29:=1
			SAVE RECORD:C53([Project:24])
		Else 
			QUERY:C277([Project:24]; [Project:24]id:23=vUUIDKeypr)
		End if 
		
		If (False:C215)  // (viSecureLvl<[Project]Publish)
			// ### bj ### 20190131_1435
			//  too hard to train people with mutilple security factors at this moment
			// add at some point
			vResponse:="Security Level is below the [Project]Publish "+String:C10(viSecureLvl)
		Else 
			GanttParse([SyncRecord:109]body:34)
		End if 
		
		// think about parsing behaviors. Perhaps  before parsing
		//  a dialog, time delay, automatically, backup WorkOrders
		
	End if 
	REDUCE SELECTION:C351([SyncRecord:109]; 0)
	
End if 

SET BLOB SIZE:C606(vblWCResponse; 0)
C_LONGINT:C283($viSent)
TEXT TO BLOB:C554(vResponse; vblWCResponse; UTF8 text without length:K22:17; *)
Http_SendWWWHd($socket; "application/json"; BLOB size:C605(vblWCResponse))
$viSent:=TCP Send Blob($socket; vblWCResponse)
