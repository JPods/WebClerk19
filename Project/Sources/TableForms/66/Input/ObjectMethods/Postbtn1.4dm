
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/22/18, 21:31:40
// ----------------------------------------------------
// Method: [WorkOrder].Input.Postbtn1
// Description
// 
//
// Parameters
// ----------------------------------------------------

vDataReceived:=""

iLoText2:=""
iLoText3:=""

READ ONLY:C145([SyncRelation:103])
QUERY:C277([SyncRelation:103]; [SyncRelation:103]name:8=[WorkOrder:66]siteIDTo:61)

If (Records in selection:C76([SyncRelation:103])#1)
	ALERT:C41("[WorkOrder]siteIDTo does not have a matching [SyncRelation]Name")
Else 
	If ([WorkOrder:66]customerID:28="")
		ALERT:C41("There is no customer assigned to this WorkOrder.")
	Else 
		If ([Customer:2]customerID:1#[WorkOrder:66]customerID:28)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[WorkOrder:66]customerID:28)
		End if 
	End if 
	If (Record number:C243([Contact:13])<0)
		ALERT:C41("There is no contact record choosen.")
	Else 
		$apiAction:=ailoText15{ailoText15}
		MQWOEvent($apiAction)  // create message record
		MQVariables  // translate variables
		C_TEXT:C284($working)
		
		iLoText2:=TagsToText(iLoText1)  // convert tags to values
		
		[WorkOrderEvent:121]messageOut:17:=iLoText2
		// [WorkOrderEvent]ObjectGeneral:=JSON Parse($working)  // try this 
		SAVE RECORD:C53([WorkOrderEvent:121])
		
		
		SET BLOB SIZE:C606(HTTP_Data; 0)
		TEXT TO BLOB:C554(iLoText2; HTTP_Data; UTF8 text without length:K22:17)
		HTTP_ContentType:="application/json"
		
		RP_LoadVariablesRelationship
		C_LONGINT:C283($error)
		$error:=WC_Request("POST")
		// 
		REDUCE SELECTION:C351([SyncRelation:103]; 0)
		READ WRITE:C146([SyncRelation:103])
		// 
		iLoText3:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)
		
		[WorkOrderEvent:121]messageIn:18:=iLoText3
		SAVE RECORD:C53([WorkOrderEvent:121])
		If ((<>viDebugMode>410) | (Caps lock down:C547))
			
			C_TEXT:C284($script)
			$script:="QUERY([WorkOrderEvent];[WorkOrderEvent]UniqueID="+String:C10([WorkOrderEvent:121]idNum:1)+")"
			
			REDUCE SELECTION:C351([WorkOrderEvent:121]; 0)
			
			ProcessTableOpen(Table:C252(->[WorkOrderEvent:121]); $script; $apiAction)
			
		End if 
	End if 
End if 