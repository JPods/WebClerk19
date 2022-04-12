//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/19/18, 01:10:43
// ----------------------------------------------------
// Method: B2B_Server
// Description
// 
//
// Parameters
// ----
C_LONGINT:C283($1)
C_POINTER:C301($2)
//
$c:=$1
vResponse:="Table is not available."
$doPage:=WC_DoPage("Error"+$suffix+".html"; "")
$tableName:=WCapi_GetParameter("TableName"; "")
TRACE:C157
Case of 
	: (voState.url="/B2B_PushRecords@")  //reverse of Record Passing window under File Menu
		$userName:=WCapi_GetParameter("Name"; "")
		$password:=WCapi_GetParameter("Password"; "")
		If (($userName#"") & ($password#""))
			QUERY:C277([SyncRelation:103]; [SyncRelation:103]partner1URL:2=vWCRemoteAddress; *)
			QUERY:C277([SyncRelation:103];  & [SyncRelation:103]remoteUserName:3=$userName; *)
			QUERY:C277([SyncRelation:103];  & [SyncRelation:103]remoteUserName:3=$password)
			If (Records in selection:C76([SyncRelation:103])=1)
				
				// reevaluate doing this
				// should a user be able to request an update or just ask the related machine to execute.
			End if 
		End if 
	: (voState.url="/B2B_SendCurrentd@")  //check and if needed send the lates version
		
	: (voState.url="/B2B_SyncRecord@")  //automated orders
		//zzz add for a procedure for popping one record in a WCC type format targeted at the senders machine.
		
		
	: (voState.url="/B2B_PO2Order@")
		//B2BPO2OrderIB($c; $2)
		//: ((voState.url="/B2B_P02Order@")|($2->="Post /B2B_P02Order@"))
		////automated orders
		//B2BPO2Order ($c;$2)
		//: ((voState.url="/B2B_P02Order@")|($2->="Post /B2B_P02Order@"))
		////automated orders
		//B2BPO2Order ($c;$2)
		//: ((voState.url="/B2B_P0Status@")|($2->="Post /B2B_P0Status@"))
		////automated orders
		//B2BPO2Order ($c;$2)
		////  
	Else 
		If ($tableName#"")
			C_POINTER:C301($ptTable)
			$ptTable:=STR_GetTablePointer($tableName)
			If (Not:C34(Is nil pointer:C315($ptTable)))
				$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
				$doPage:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageOne)
				CREATE RECORD:C68($ptTable->)
				pvTableName:=$tableName
				$thePrimary:=STR_GetProtectString($tableName)  //get a uniqueID
				SAVE RECORD:C53($ptTable->)
				pvRecordNum:=Record number:C243($ptTable->)
			End if 
		End if 
End case 
$err:=WC_PageSendWithTags($1; $doPage; 0)
//
TableName:=""
RecordNum:=""
C_TEXT:C284(TableName; RecordNum)