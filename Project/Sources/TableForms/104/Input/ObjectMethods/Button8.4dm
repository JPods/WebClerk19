C_LONGINT:C283($error)
C_TEXT:C284($httpHeader; $stringMessage)


QUERY:C277([SyncRelation:103]; [SyncRelation:103]idUnique:1=[SyncExchange:104]SyncRelationIDLocal:3)
RP_LoadVariablesRelationship("RP_StatusExchange?syncExchangeRemote="+String:C10([SyncExchange:104]idUniqueRemote:11)+"&action=showselection")


SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
$error:=WC_Request("GET")  //Sends Blob: HTTP_Data
If ($error=0)
	ALERT:C41("Status Failed")
Else 
	$httpHeader:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)
	//WC_ParseRequestParameter 
	//$stringMessage:="SyncExchange: "+WCapi_GetParameter(->vText11;"SyncExchangeMatch";""))
	//$stringMessage:=$stringMessage+", SyncRecord: "+WCapi_GetParameter(->vText11;"SyncRecord";""))
	ALERT:C41("View other machine."+<>VCR+$stringMessage)
End if 