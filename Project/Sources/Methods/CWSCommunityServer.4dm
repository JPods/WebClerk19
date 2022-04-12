//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-01-01T00:00:00, 11:06:47
// ----------------------------------------------------
// Method: CWSCommunityServer
// Description
// Modified: 01/01/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $3; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse)
C_POINTER:C301($2)
READ ONLY:C145([Employee:19])
READ ONLY:C145([Rep:8])
$c:=$1
$suffix:=""
$doThis:=0

//RemoteUsers_SetVars (1)  Set in WC_eventID
$sendPage:=True:C214
vResponse:="Access to this command is not available."
$doPage:=WC_DoPage("Error.html"; "")
If (vWccSecurity<1)  //WCC procudures use vWccSecurity to test.
	//force them to allow wider use by non-employees.    
	vWccSecurity:=viEndUserSecurityLevel
End if 
$notFinished:=True:C214
$tableName:=WCapi_GetParameter("TableName"; "")
$tableNum:=STR_GetTableNumber($tableName)
$recordnum:=Num:C11(WCapi_GetParameter("RecordNum"; ""))
$recordID:=WCapi_GetParameter("RecordID"; "")
$reportName:=WCapi_GetParameter("ReportName"; "")
If (((viEndUserSecurityLevel>1) | (vWccSecurity>1)) & (<>vCommunitySite=1))
	Case of 
		: (voState.url="/CWS_LoadCust@")  //Utilities
			$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=$recordID; *)
			QUERY:C277([Customer:2];  & [Customer:2]publish:91>0; *)
			QUERY:C277([Customer:2];  & [Customer:2]publish:91<=viEndUserSecurityLevel)
			vResponse:="Invalid customerID or not published at current level: "+String:C10(viEndUserSecurityLevel)
			If (Records in selection:C76([Customer:2])=1)
				$doPage:=WC_DoPage("CWSCustomersOne.html"; $jitPageOne)
			Else 
				vResponse:="No customer record in selection."
			End if 
			$err:=WC_PageSendWithTags($c; $doPage; 0)
			$notFinished:=False:C215
			$sendPage:=False:C215
		: (voState.url="/CWS_Query@")
			voState.url:="WCC_"+Substring:C12(voState.url; 5)
			WccSearch($1; $2)
			$notFinished:=False:C215
			$sendPage:=False:C215
		: (voState.url="/CWS_ImageQuery@")
			//voState.url:="WCC_"+Substring(voState.url;5)
			// Wcc_ImageServer ($1;$2)
			$notFinished:=False:C215
			$sendPage:=False:C215
		: (voState.url="/CWS_NewRecord@")
			$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
			$doPage:=WC_DoPage("CWS"+$tableName+"One.html"; $jitPageOne)
			
		: (voState.url="/CWS_SaveRec@")
			$thePurpose:=WCapi_GetParameter("Purpose"; "")
			WccSaveRecord($1; $2; $madeBy; $thePurpose)
			$sendPage:=False:C215
		: (voState.url="/CWS_Execute@")
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]idNum:4=$RecordID; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=$reportName)
			
			If (([TallyMaster:60]script:9#"") & (Records in selection:C76([TallyMaster:60])=1))
				//$jitPageOne:=WCapi_GetParameter("jitPageOne";"")
				$doPage:=WC_DoPage([TallyMaster:60]profile1:23; $jitPageOne)
				WC_VariablesRead
				ExecuteText(0; [TallyMaster:60]script:9)
			End if 
	End case 
	If ((vlUserRec>-1) & ($notFinished))
		//
		If (($tableName="Customer") | ($tableName="TallyMaster") | ($tableName="Document"))
			//zttp_UserGet 
			GOTO RECORD:C242([RemoteUser:57]; vlUserRec)
			$madeBy:=[RemoteUser:57]customerID:10
			C_LONGINT:C283($madeByTable)
			$madeByTable:=[RemoteUser:57]tableNum:9
			
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]idNum:4=$recordID)
			
			$doOK:=0
			
			Case of 
				: (voState.url="/CWS_Upload@")
					pvEvent:=WCapi_GetParameter("jitEvent"; "")
					pvEventDate:=WCapi_GetParameter("jitEventDate"; "")
					$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
					$doPage:=WC_DoPage("CWSUploadComplete.html"; $jitPageOne)
					
				: (viEndUserSecurityLevel>4999)
					$doOK:=1
				: (($tableName="Customer") & ([Customer:2]customerID:1=$madeBy))
					$doOK:=1
				: (($tableName="TallyResult") & ([TallyResult:73]customerID:30=$madeBy))
					$doOK:=1
				: (($tableName="Document") & ([Document:100]customerID:7=$madeBy))
					$doOK:=1
			End case 
			If ($doOK=1)
				vResponse:="Access allowed"
				$sendPage:=False:C215
				Case of 
					: (voState.url="/CWS_EditRec@")
						voState.url:="WCC_"+Substring:C12(voState.url; 5)
						WccSearch($1; $2)
					: (voState.url="/CWS_SaveRec@")
						C_TEXT:C284($madeBy; $thePurpose)
						$thePurpose:=WCapi_GetParameter("Purpose"; "")
						WccSaveRecord($1; $2; $madeBy; $thePurpose)
					: (voState.url="/CWS_SaveList@")
						C_TEXT:C284($madeBy; $thePurpose)
						WccListSave($1; $2; $tableName; $tableNum)
					: (voState.url="/CWS_Execute@")
						WccExecuteServ($1; $2)
					: (voState.url="/CWS_DeleteRec@")
						WccDeleteRecord($1; $2)
					Else 
						vResponse:="Access to this command is not available or you did not create this record."
						$sendPage:=True:C214
				End case 
			End if 
		End if 
	End if 
End if 
If ($sendPage)
	$err:=WC_PageSendWithTags($c; $doPage; 0)
End if 