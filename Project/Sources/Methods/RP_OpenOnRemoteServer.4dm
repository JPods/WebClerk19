//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-10-06T00:00:00, 22:49:43
// ----------------------------------------------------
// Method: RP_OpenOnRemoteServer
// Description
// Modified: 10/06/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $tableName; $uniqueTitle)
$tableName:=$1
C_LONGINT:C283($uniqueID)
Case of 
	: ([SyncRecord:109]StatusSend:17="PackedRelated@")
		ALERT:C41("Local only")
	: ($tableName="SyncRelation")
		$uniqueID:=-1
	: ($tableName="SyncExchange")
		QUERY:C277([SyncRelation:103]; [SyncRelation:103]idUnique:1=[SyncExchange:104]SyncRelationIDLocal:3)
		$uniqueID:=[SyncExchange:104]idUniqueRemote:11
	: ($tableName="SyncRecord")
		QUERY:C277([SyncRelation:103]; [SyncRelation:103]id:30=[SyncRecord:109]idRelation:49)
		$uniqueID:=[SyncRecord:109]idUniqueRemote:27
	Else 
		$tableName:=""
End case 
If ((Record number:C243([SyncRelation:103])>-1) & ($tableName#""))
	$uniqueTitle:=[SyncRelation:103]Name:8
	RP_LoadVariablesRelationship
	SET BLOB SIZE:C606(HTTP_Data; 0)
	$sizeResponse:=WC_Request("GET"; HTTP_URL+"/heart_beat"; "")  //Sends empth 
	SET BLOB SIZE:C606(HTTP_Data; 0)
	If ($sizeResponse>0)
		HTTP_Path:="/RP_OpenRecord?TableName="+$tableName+"&username="+vUsername+"&password="+vPassword+"&SecurityLevel=5&title="+$uniqueTitle+"&UniqueID="+String:C10($uniqueID)+"&jitPageOne=noticeOnly"
		SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
		$error:=WC_Request("GET")  //Sends Blob: HTTP_Data 
		
		If ($error>0)
			$httpHeader:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)
			SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
			
			If (Position:C15("RemoteUser Approved"; $httpHeader)<0)
				ALERT:C41("Signin Failed")
			Else 
				ALERT:C41("If Relation allows window opening, check remote server")
			End if 
		End if 
	End if 
Else 
	ALERT:C41("No matching SyncRelation Record")
End if 