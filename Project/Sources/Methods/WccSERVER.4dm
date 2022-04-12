//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/27/11, 08:15:24
// ----------------------------------------------------
// Method: WccSERVER
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $3; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse; justMine)
C_POINTER:C301($2)
READ ONLY:C145([Employee:19])
READ ONLY:C145([Rep:8])
$c:=$1
$suffix:=""
$doThis:=0
$doPage:=WC_DoPage("Error.html"; "")
vResponse:="Access to this command is not available."
pvRecordNum:=-3

// ----------------------------------------------------
//  // User name (OS): williamjames
//  // Date and time: 09/27/11, 08:15:24
//  // ----------------------------------------------------
//  // Method: WccSERVER
//  // Description
//  // 
//  //
//  // Parameters
//  // ----------------------------------------------------
//  
//  C_LONGINT($1; $3; $c; $doThis; <>vbSaleLevel)
//  C_TEXT(vResponse; justMine)
//  C_POINTER($2)
//  READ ONLY([Employee])
//  READ ONLY([Rep])
//  $c:=$1
//  $suffix:=""
//  $doThis:=0
//  $doPage:=WC_DoPage("Error.html"; "")
//  vResponse:="Access to this command is not available."
//  pvRecordNum:=-3
//  
//  C_POINTER($ptTable; $ptUUIDKey)
//  C_TEXT($tableName; $vtUUIDKey; $jitPageOne)
//  C_LONGINT($tableNum)
//  $tableName:=WCapi_GetParameter("Table"; "")
//  If ($tableName="")
//  $tableName:=WCapi_GetParameter("Tablename"; "")
//  End if 
//  pvTableName:=$tableName
//  $tableNum:=STR_GetTableNumber($tableName)
//  $jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
//  
//  If (voState.url[[1]]#"/")
//  voState.url:="/"+voState.url
//  End if 
//  
//  
//  If (voState.url="/Wcc_PasswordAdminUpdate@")
//  WccPasswordCmdChange($1; $2)
//  Else 
//  If (Not((<>vbSaleLevel<1) | (<>vMakeSales<1)))
//  //333Http_UserGet 
//  If ((vWccPrimeRec>-1) & ((vWccTableNum=19) | (vWccTableNum=Table(->[Rep])) | (vWccTableNum=Table(->[ManufacturerTerm]))))
//  // Modified by: Bill James (2015-02-06T00:00:00  set return values for all WCC)
//  
//  //redundant from WC_Core on purpose. Need to clean up and have only one
//  
//  returnTable:=WCapi_GetParameter("ReturnTable"; "")
//  returnField:=WCapi_GetParameter("ReturnField"; "")
//  If (returnField="")
//  returnField:=WCapi_GetParameter("ReturnKeyField"; "")
//  End if 
//  returnValue:=WCapi_GetParameter("ReturnValue"; "")
//  If (returnValue="")
//  returnValue:=WCapi_GetParameter("ReturnID"; "")
//  End if 
//  returnPage:=WCapi_GetParameter("ReturnPage"; "")
//  
//  Case of 
//  : (voState.url="/Wcc_Clone@")  //
//  If ($tableNum>0)
//  $ptTable:=STR_GetTablePointer($tableName)
//  $ptUUIDKey:=STR_GetFieldPointer($tableName; "id")
//  $vtUUIDKey:=WCapi_GetParameter("id"; "")
//  If ($vtUUIDKey#"")
//  QUERY($ptTable->; $ptUUIDKey->=$vtUUIDKey)
//  If (Records in selection($ptTable->)=1)
//  ptCurTable:=$ptTable
//  vHere:=2
//  CloneRecord
//  
//  
//  
//  
//  
//  $doPage:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageOne)
//  vHere:=0
//  // ptCurTable:=
//  BOOACCEPT:=True
//  jAcceptButton
//  End if 
//  End if 
//  End if 
//  $err:=WC_PageSendWithTags($1; $doPage; 0)
//  : (voState.url="/Wcc_Reset@")  //Utilities
//  WccResetUser($1; $2)
//  : (voState.url="/Wcc_LoadCust@")  //Utilities
//  
//  $custID:=WCapi_GetParameter("RecordID"; "")
//  QUERY([Customer]; [Customer]customerID=$custID)
//  If (Records in selection([Customer])=1)
//  $doPage:=WC_DoPage("WccCustomersOne.html"; $jitPageOne)
//  Else 
//  vResponse:="Invalid customerID"
//  End if 
//  $err:=WC_PageSendWithTags($1; $doPage; 0)
//  : (voState.url="/WCC_Query@")
//  WccSearch($1; $2)
//  : (voState.url="/WCC_EmptyForm@")
//  WccNewRecordEmptyForm($1; $2)
//  : (voState.url="/WCC_NewRec@")
//  WccNewRecord($1; $2)
//  : (voState.url="/WCC_SaveRec@")
//  WccSaveRecord($1; $2)
//  : (voState.url="/WCC_SaveList@")
//  WccListSave($1; $2)
//  : (voState.url="/WCC_AddRec@")
//  
//  
//  If ($tableNum>0)
//  REDUCE SELECTION(Table($tableNum)->; 0)
//  $doPage:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageOne)
//  Else 
//  $jitPageError:=WCapi_GetParameter("jitPageError"; "")  //look for a missing quote if page does cannot be found
//  $doPage:=WC_DoPage("Error.html"; $jitPageError)
//  vresponse:=$tableName+" is not a valid table name."
//  End if 
//  
//  $err:=WC_PageSendWithTags($1; $doPage; 0)
//  
//  : (voState.url="/WCC_Execute@")
//  WccExecuteServ($1; $2)
//  //: ((voState.url="/WCC_QAQuestions@")
//  //WCCQAQuestions ($c;->vText11)
//  //: ((voState.url="/WCC_QAAnswers@")
//  //WCCQAAnswers ($c;->vText11)
//  ////: ((voState.url="/Search_QA@")
//  //       
//  : (voState.url="/WCC_Sales@")  //post Proposal
//  Wcc_SalesStatus($c; ->vText11)
//  // 
//  : (voState.url="/WCC_Print@")
//  WccPrint($1; $2)
//  
//  : (voState.url="/WCC_Service@")
//  WccServiceServ($1; $2)
//  //
//  : (voState.url="/WCC_Inship@")
//  WccInshipGoods($1; $2)
//  
//  : (voState.url="/WCC_WorkOrder@")
//  WccWoServ($1; $2)
//  : (voState.url="/Wcc_PagePass@")  //Utilities
//  WccPagePass($1; $2)
//  : ((voState.url="/Wcc_MyPage@") | (voState.url="/Wcc_Sales@"))  //Utilities"
//  WccMyPage($1; $2)
//  : (voState.url="/WCC_DeleteRec@")
//  WccDeleteRecord($1; $2)
//  
//  : (voState.url="/WCC_RemoteUsersEdit@")  //Editing a RemoteUsers  
//  
//  WccSaveRecord($1; $2)
//  If (False)  //Just stored here as reference. 
//  vi1:=Num(variable1)
//  vi6:=Num(variable6)
//  If ((vi1>-1) & (vi2>0) & (variable2#"") & (variable3#"") & (variable4#"") & (variable5#""))
//  If ([RemoteUser]userName#variable4)
//  PUSH RECORD([RemoteUser])
//  //GOTO RECORD([RemoteUser];vi1)
//  If (Records in selection([RemoteUser])=1)
//  PUSH RECORD([RemoteUser])
//  QUERY([RemoteUser]; [RemoteUser]userName=variable4)
//  If (Records in selection([RemoteUser])=0)
//  POP RECORD([RemoteUser])
//  [RemoteUser]company:=variable2
//  [RemoteUser]name:=variable3
//  [RemoteUser]userName:=variable4
//  [RemoteUser]userPassword:=variable5
//  [RemoteUser]securityLevel:=vi6
//  [RemoteUser]keyText:=variable7
//  SAVE RECORD([RemoteUser])
//  Else 
//  POP RECORD([RemoteUser])
//  End if 
//  End if 
//  //POP RECORD([RemoteUser])
//  End if 
//  End if 
//  End if 
//  //
//  : (voState.url="/Wcc_Lead2Customer@")  //Utilities
//  TRACE
//  
//  $recordNum:=Num(WCapi_GetParameter("RecordNum"; ""))
//  If (($tableName#"Lead") & ($recordNum<0))
//  vResponse:="This is not a lead record"
//  Else 
//  READ WRITE([Lead])
//  GOTO RECORD([Lead]; $recordNum)
//  If (Records in selection([Lead])=1)
//  Temp2Customer
//  PVars_AddressFull(->[Customer]; ->CustAddress)
//  If (Records in selection([RemoteUser])>0)
//  [RemoteUser]tableNum:="Customer"
//  [RemoteUser]customerID:=[Customer]customerID
//  End if 
//  [EventLog]tableName:="Customer"
//  [EventLog]customerRecNum:=Record number([Customer])
//  READ WRITE([RemoteUser])
//  GOTO RECORD([RemoteUser]; [EventLog]remoteUserRec)  //unloaded in the Temp2Customer method
//  If ([EventLog]id#"")
//  SAVE RECORD([EventLog])
//  End if 
//  $doPage:=WC_DoPage("WccCustomersOne.html"; $jitPageOne)
//  End if 
//  End if 
//  $err:=WC_PageSendWithTags($1; $doPage; 0)
//  : (voState.url="/Wcc_SynIn@")  //Utilities
//  SyncWebIn($1; $2)
//  //
//  : (voState.url="/Wcc_SynOut@")  //Utilities
//  //SyncWebOut ($1;$2)
//  //
//  : (voState.url="/WCC_All@")
//  $doPage:=WC_DoPage("Error"+$suffix+".html"; "")
//  vResponse:="No records available in table: "+$tableName
//  If ($tableNum>0)
//  ALL RECORDS(Table($tableNum)->)
//  REDUCE SELECTION(Table($tableNum)->; 100)
//  $jitPageList:=WCapi_GetParameter("jitPageList"; "")
//  $doPage:=WC_DoPage("Wcc"+$tableName+"List.html"; $jitPageList)
//  End if 
//  $err:=WC_PageSendWithTags($1; $doPage; 0)
//  //    
//  : (voState.url="/WCC_Order@")  //Complex Transactions
//  WccOrderServ($1; $2)
//  
//  : (voState.url="/WCC_Invoice@")
//  WccInvoiceServ($1; $2)
//  
//  : (voState.url="/WCC_Items@")
//  WccItemServ($1; $2)
//  : (voState.url="/WCC_Customer@")
//  WccCustomerServ($1; $2)
//  Else 
//  vResponse:="No valid Wcc Command: "+Substring(vText11; 1; 50)
//  $err:=WC_PageSendWithTags($1; $doPage; 0)
//  End case 
//  Else 
//  vResponse:="vWccPrimeRec: "+String(vWccPrimeRec)+" vWccTableNum: "+String(vWccTableNum)
//  $err:=WC_PageSendWithTags($1; $doPage; 0)
//  End if 
//  Else 
//  vResponse:="Preferences: <>vbSaleLevel: "+String(<>vbSaleLevel)+" <>vMakeSales: "+String(<>vMakeSales)+" vWccPrimeRec: "+String(vWccPrimeRec)
//  $err:=WC_PageSendWithTags($1; $doPage; 0)
//  End if 
//  End if 