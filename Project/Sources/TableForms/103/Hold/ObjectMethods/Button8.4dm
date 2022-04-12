// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/21/11, 14:33:31
// ----------------------------------------------------
// Method: Object Method: B16
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (vUniqueID<10)
	ALERT:C41("You must select a relationship.")
Else 
	C_BLOB:C604(HTTP_IncomingBlob)
	SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
	SET BLOB SIZE:C606(HTTP_Data; 0)
	C_LONGINT:C283(vWindowCurrent)
	C_LONGINT:C283(thermoProcess)
	<>vConnectionStatus:="Checking heart_beat"
	vWindowCurrent:=Current form window:C827
	$path:=HTTP_Path  //store original path to execute, restore in line 47
	//HTTP_Path:="/heart_beat"
	//$error:=WC_Request ("GET";->HTTP_IncomingBlob)//Sends Blob: HTTP_Data 
	//HTTP_Path:=$path
	eventID_Cookie:=""  //initial contact, clear existing cookie
	//  QUERY([SyncRelation];[SyncRelation]UniqueTitle=$relationshipName)
	
	C_LONGINT:C283($sizeResponse)
	SET BLOB SIZE:C606(HTTP_Data; 0)
	$sizeResponse:=WC_Request("GET"; HTTP_URL+"/heart_beat"; "")  //Sends empth 
	If ($sizeResponse=0)
		HTTP_Path:=$path  // restore path incase another action
	Else 
		If ([SyncRelation:103]idNum:1#vUniqueID)
			QUERY:C277([SyncRelation:103]; [SyncRelation:103]idNum:1=vUniqueID)
		End if 
		HTTP_Path:="/RP_Command?command=pending&username="+vUsername+"&password="+vPassword+"&SecurityLevel=5&syncExchangeRemote="+String:C10([SyncRelation:103]idNum:1)+"&syncRelation="+[SyncRelation:103]name:8+"&jitPageOne=noticeOnly"
		
		
		
		
		
		
		// QUERY([SyncRecord])
		//  ProcessTableOpen  
		// DB_ShowCurrentSelection (->[SyncRecord];"";1;$adderCommentt;0)
		// DB_ShowCurrentSelection (-[SyncRecord];no script;create a set "";$adderComment;  0 -- unload current process)
	End if 
End if 