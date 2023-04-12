//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/05/13, 21:48:26
// ----------------------------------------------------
// Method: WC_ServerRP
// Description
// 
//
// Parameters
// ----------------------------------------------------

// 
//
C_LONGINT:C283($1; $socket; $duration; $sizeIncoming)
C_POINTER:C301($2; $ptBlob)
// ----------------------------------------------------
C_TEXT:C284($extension)
C_BLOB:C604($data)
$socket:=voState.socket
$message:="Got the Record"

$ptBlob:=$2
$sizeIncoming:=BLOB size:C605($ptBlob->)
$duration:=Milliseconds:C459

//  Sending Procedure is in RP_Editor  
// QQQ???? remove this to fix the pages

voState.url:=Replace string:C233(voState.url; "_"; "/")
Case of 
	: (voState.url="/RP/json@")
		RP_JSONReceive($1)
	: (voState.url="/RP/OpenRecord@")
		RP_OpenRecordRemote
	: (voState.url="/RP/StatusExchange@")
		C_LONGINT:C283($exchangeID)
		C_TEXT:C284($exchangeAction)
		$exchangeID:=Num:C11(WCapi_GetParameter("syncExchangeRemote"; ""))
		$exchangeAction:=WCapi_GetParameter("action"; "")
		SET BLOB SIZE:C606(vblWCResponse; 0)
		$myMessage:="Reply?Heartbeat=true&Reply="+Storage:C1525.default.company+"&Version="+Storage:C1525.version.rev
		If ($exchangeID>0)
			QUERY:C277([zzzSyncJob:104]; [zzzSyncJob:104]idNum:1=$exchangeID)
			If (Records in selection:C76([zzzSyncJob:104])=1)
				$myMessage:=$myMessage+"&SyncExchangeMatch=true"
				QUERY:C277([SyncRecord:109]; [SyncRecord:109]purpose:40=$exchangeID)
				If (Records in selection:C76([SyncRecord:109])>0)
					Case of 
						: ($exchangeAction="completeexchange")
							[zzzSyncJob:104]status:4:="ReceiveComplete"
							$myMessage:=$myMessage+"&message=ReceiveComplete"
							SAVE RECORD:C53([zzzSyncJob:104])
						: ($exchangeAction="showselection")
							$myMessage:=$myMessage+"&SyncRecord="+String:C10(Records in selection:C76([SyncRecord:109]))
							ProcessTableOpen(Table:C252(->[SyncRecord:109]))
					End case 
				End if 
			End if 
		End if 
		TEXT TO BLOB:C554($myMessage; vblWCResponse; UTF8 text without length:K22:17; *)
		Http_SendWWWHd($socket; "text/html"; BLOB size:C605(vblWCResponse))
		//WC_SendHeaders ($socket)
		WC_SendBody($socket)
		
		
		
	: (voState.url="/RP/Command@")
		If (obEventLog.securityLevel>=5)
			$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
			
			QUERY:C277([SyncRecord:109];  & ; [SyncRecord:109]idNum:1=vUniqueID; *)
			$adderComment:="Pending: "+HTTP_Host+", "+vScript
		Else 
			$adderComment:="Pending"
		End if 
		
		
		SET BLOB SIZE:C606(vblWCResponse; 0)
		$myMessage:="Reply?Heartbeat=true&Reply="+Storage:C1525.default.company+"&Version="+Storage:C1525.version.rev
		TEXT TO BLOB:C554($myMessage; vblWCResponse; UTF8 text without length:K22:17; *)
		Http_SendWWWHd($socket; "text/html"; BLOB size:C605(vblWCResponse))
		//WC_SendHeaders ($socket)
		WC_SendBody($socket)
		
		
	: (voState.url="/RP/ganttSave@")  // this saves the data from the page button
		WC_ganttReceive($socket; ->vText11)
		
	: (voState.url="/RP/ganttLoad@")  // this is called by the page to get the data
		WC_GanttBuild($1)
		
	: (voState.url="/RP/ganttPage@")
		vUUIDKeypr:=WCapi_GetParameter("vUUIDKeypr"; "")
		QUERY:C277([Project:24]; [Project:24]id:23=vUUIDKeypr)
		If (Records in selection:C76([Project:24])=1)
			$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
			If ($jitPageOne="")
				$jitPageOne:="gantt.html"
			End if 
			// ### bj ### 20191204_1245
			// note this use of a folder in a path. It is intended to allow more flexibility in having many different types of gantt pages
			$jitPageOne:="jQueryGantt"+Folder separator:K24:12+$jitPageOne
		End if 
		
		
		$thePage:=WC_DoPage($jitPageOne; "")
		$err:=WC_PageSendWithTags($socket; $thePage; 0)
		
	Else 
		SET BLOB SIZE:C606(vblWCResponse; 0)
		$text2Send:="Reply?Heartbeat=Failed RemoteUser Security"
		TEXT TO BLOB:C554($text2Send; vblWCResponse; UTF8 text without length:K22:17; *)
		Http_SendWWWHd($socket; "text/html"; BLOB size:C605(vblWCResponse))
		$0:=TCP Send Blob($socket; vblWCResponse)
End case 
