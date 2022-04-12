//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/19/19, 19:04:37
// ----------------------------------------------------
// Method: WC_GanttBuild
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $socket)  //voState.socket

//QUERY([TallyMaster];[TallyMaster]Publish>1;*)
//QUERY([TallyMaster]; & ;[TallyMaster]Purpose="jQuery-Gantt";*)
//QUERY([TallyMaster]; & ;[TallyMaster]Name="WorkOrder")

C_TEXT:C284(vUUIDKeypr)
C_LONGINT:C283($projectNum)
vUUIDKeypr:=WCapi_GetParameter("vUUIDKeypr"; "")
$projectNum:=Num:C11(WCapi_GetParameter("projectNum"; ""))
C_LONGINT:C283($incRecs; $cntRecs)
QUERY:C277([Project:24]; [Project:24]id:23=vUUIDKeypr)
If (Records in selection:C76([Project:24])=0)
	If ($projectNum=0)
		QUERY:C277([Project:24]; [Project:24]projectNum:1=19)
	Else 
		QUERY:C277([Project:24]; [Project:24]projectNum:1=$projectNum)
	End if 
End if 
QUERY:C277([WorkOrder:66]; [WorkOrder:66]projectNum:80=[Project:24]projectNum:1)
QUERY:C277([Order:3]; [Order:3]projectNum:50=[Project:24]projectNum:1)
QUERY:C277([PO:39]; [PO:39]projectNum:6=[Project:24]projectNum:1)
QUERY:C277([Proposal:42]; [Proposal:42]projectNum:22=[Project:24]projectNum:1)

$cntRecs:=Records in selection:C76([WorkOrder:66])
ORDER BY:C49([WorkOrder:66]; [WorkOrder:66]woNum:29)

ARRAY OBJECT:C1221($aObjWorkOrders; 0)
C_OBJECT:C1216($voProject)
C_OBJECT:C1216($voEmpty)

FIRST RECORD:C50([WorkOrder:66])
ORDER BY:C49([WorkOrder:66]; [WorkOrder:66]seq:26)
For ($incRecs; 1; $cntRecs)
	$voSend:=OB Copy:C1225($voEmpty)
	GanttRecordInOut("WorkOrder"; "send"; ->$voSend)
	APPEND TO ARRAY:C911($aObjWorkOrders; $voSend)
	NEXT RECORD:C51([WorkOrder:66])
End for 
REDUCE SELECTION:C351([WorkOrder:66]; 0)

OB SET ARRAY:C1227($voProject; "tasks"; $aObjWorkOrders)

ARRAY OBJECT:C1221($aObDeletedTasks; 0)
OB SET ARRAY:C1227($voProject; "deletedtaskIDs"; $aObDeletedTasks)

ARRAY OBJECT:C1221($aObRoles; 0)
ARRAY OBJECT:C1221($aObEmployees; 0)

QUERY:C277([Employee:19]; [Employee:19]active:12=True:C214)
C_LONGINT:C283($incRecs; $cntRecs)
$cntRecs:=Records in selection:C76([Employee:19])
FIRST RECORD:C50([Employee:19])
For ($incRecs; 1; $cntRecs)
	//  If (OB Get([Employee]ObGeneral;"Project"))
	INSERT IN ARRAY:C227($aObEmployees; Size of array:C274($aObEmployees)+1; 1)
	OB SET:C1220($aObEmployees{$incRecs}; "id"; [Employee:19]nameID:1; "name"; [Employee:19]nameID:1)
	// End if 
	NEXT RECORD:C51([Employee:19])
End for 
REDUCE SELECTION:C351([Employee:19]; 0)

// Build Roles

OB SET ARRAY:C1227($voProject; "resources"; $aObEmployees)

ARRAY TEXT:C222($aRoles; 0)
COPY ARRAY:C226(<>aJobType; $aRoles)
DELETE FROM ARRAY:C228($aRoles; 1; 1)
$cntRecs:=Size of array:C274($aRoles)
For ($incRecs; 1; $cntRecs)
	INSERT IN ARRAY:C227($aObRoles; Size of array:C274($aObRoles)+1; 1)
	OB SET:C1220($aObRoles{$incRecs}; "id"; "tmp-"+String:C10($incRecs); "name"; $aRoles{$incRecs})
End for 

// fill with empty
OB SET ARRAY:C1227($voProject; "roles"; $aObRoles)

// finish up the project  put these values in the Project
OB SET:C1220($voProject; "selectedRow"; 3)

OB SET:C1220($voProject; "canDelete"; True:C214)
OB SET:C1220($voProject; "canAdd"; True:C214)
OB SET:C1220($voProject; "canWrite"; True:C214)
OB SET:C1220($voProject; "canWriteOnParent"; True:C214)
OB SET:C1220($voProject; "zoom"; "1M")


If (False:C215)
	//C_TIME($myDoc)
	//$myDoc:=Open document("")
	//CLOSE DOCUMENT($myDoc)
	$working:=Document to text:C1236("Beldin:Users:williamjames:CommerceExpert:jitWeb:GanttDataDemo.txt")
	//SET TEXT TO PASTEBOARD(document)
End if 

If (False:C215)
	QUERY:C277([SyncRecord:109]; [SyncRecord:109]idNum:1=468)
	$working:=[SyncRecord:109]body:34
	$working:=Replace string:C233($working; "\r"; "")
	$working:=Replace string:C233($working; "\t"; "")
	$working:=Replace string:C233($working; "\\n"; "")
	$working:=Replace string:C233($working; "\\r"; "")
	$working:=Replace string:C233($working; "\\t"; "")
	$working:=Replace string:C233($working; "    "; "")
	[SyncRecord:109]body:34:=$working
	// only if received.
	// [SyncRecord]ObReceived:=JSON Parse([SyncRecord]Body)
	SAVE RECORD:C53([SyncRecord:109])
End if 

C_TEXT:C284($working)
$working:=JSON Stringify:C1217($voProject)
$working:=JSON Stringify:C1217($working)

If (<>viDeBugMode>410)
	ConsoleMessage("GanttBuild")
	ConsoleMessage($working)
End if 
C_BLOB:C604(vblWCResponse)

TEXT TO BLOB:C554($working; vblWCResponse; UTF8 text without length:K22:17; *)
Http_SendWWWHd(voState.socket; "application/json"; BLOB size:C605(vblWCResponse))
WC_SendBody(voState.socket; ->vblWCResponse)
//{
//"id": [WorkOrder]WONum,
//"name": "[WorkOrder]Title",
//"progress": [WorkOrder]FlowProgress,
//"progressByWorklog": [WorkOrder]FlowProgressByWorklog,
//"description": "[WorkOrder]Description",
//"code": "[WorkOrder]FlowCode",
//"level": [WorkOrder]FlowLevel,
//"status": "[WorkOrder]Status",
//"depends": "FlowDepends",
//"start": _jit_0_dtEpochPlannedjj,
//"duration": [WorkOrder]DurationPlanned,
//"end": _jit_0_dtEpochEndPlanjj,
//"startIsMilestone": [WorkOrder]FlowStartIsMilestone,
//"endIsMilestone": [WorkOrder]FlowEndIsMilestone,
//"collapsed": [WorkOrder]FlowCollapsed,
//"canWrite": [WorkOrder]FlowCanWrite,
//"canAdd": [WorkOrder]FlowCanAdd,
//"canDelete": [WorkOrder]FlowCanDelete,
//"canAddIssue": [WorkOrder]FlowCanIssue,  
//"hasChild": [WorkOrder]FlowHasChildren,
//"assigs": [
//{
//"id": "tmp_1545589986961_1",
//"resourceId": "tmp_3",
//"roleId": "tmp_1",
//"effort": 799200000
//}
//]
//}

//{
//"id": -3,
//"name": "gantt part",
//"progress": 0,
//"progressByWorklog": false,
//"description": "",
//"code": "",
//"level": 2,
//"status": "STATUS_ACTIVE",
//"depends": "",
//"start": 1545631200000,
//"duration": 2,
//"end": 1545803999999,
//"startIsMilestone": false,
//"endIsMilestone": false,
//"collapsed": false,
//"canWrite": true,
//"canAdd": true,
//"canDelete": true,
//"canAddIssue": true,
//"assigs": [
//{
//"id": "tmp_1545589986961_1",
//"resourceId": "tmp_3",
//"roleId": "tmp_1",
//"effort": 799200000
//}
//],
//"hasChild": false
//}
If (False:C215)
	C_REAL:C285(vrTimeStart; vrTimeEnd)
	C_BOOLEAN:C305(vbChildrenHas)
	C_TEXT:C284(vtDepends)
	
	C_TEXT:C284(vtjqid; vtjqname; vtjqprogress; vtjqprogressByWorklog; vtjqdescription; vtjqcode; vtjqlevel)
	C_TEXT:C284(vtjqstatus; vtjqdepends; vtjqstart; vtjqduration; vtjqend; vtjqstartIsMilestone; vtjqe)
	C_TEXT:C284(vtjqcollapsed; vtjqcanWrite; vtjqcanAdd; vtjqcanDelete; vtjqcanAddIssue; vtjqassigs)
	C_TEXT:C284(vtjqhasChild)
	C_TEXT:C284(vtjqresourceId; vtjqroleId; vtjqeffort)
	
	
	[WorkOrder:66]woNum:29:=0
	[WorkOrder:66]name:76:=""
	[WorkOrder:66]flowProgress:87:=0
	[WorkOrder:66]flowProgressByWorklog:97:=False:C215
	[WorkOrder:66]description:3:=""
	[WorkOrder:66]flowCode:95:=""
	[WorkOrder:66]flowLevel:96:=0
	[WorkOrder:66]action:33:=""
	[WorkOrder:66]flowDepends:89:=""
	[WorkOrder:66]durationPlanned:10:=0
	[WorkOrder:66]flowStartIsMileStone:99:=False:C215
	[WorkOrder:66]flowEndIsMileStone:100:=False:C215
	[WorkOrder:66]flowCollapsed:101:=False:C215
	[WorkOrder:66]flowCanWrite:98:=False:C215
	[WorkOrder:66]flowCanAdd:102:=False:C215
	[WorkOrder:66]flowCanDelete:103:=False:C215
	[WorkOrder:66]flowCanIssue:104:=False:C215
	//  _jit_0_dtEpochPlannedjj:=false
	//  _jit_0_dtEpochEndPlanjj:=false
	
End if 