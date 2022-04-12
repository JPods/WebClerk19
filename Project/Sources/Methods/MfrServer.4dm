//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/13/09, 16:59:30
// ----------------------------------------------------
// Method: MfrServer
// Description
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
TRACE:C157

//RemoteUsers_SetVars (1)  Set in WC_eventID
$sendPage:=True:C214
vResponse:="Access to this command is not available."
$doPage:=WC_DoPage("Error.html"; "")
//zttp_UserGet 
If (((vlUserRec>0) & ([RemoteUser:57]tableNum:9=111)) | (vWccPrimeRec>-1))
	If (vWccSecurity<1)  //WCC procudures use vWccSecurity to test.
		//force them to allow wider use by non-employees.    
	End if 
	QUERY:C277([ManufacturerTerm:111]; [ManufacturerTerm:111]customerID:1=[Customer:2]customerID:1)
	//push past Wcc Restrictions
	vWccSecurity:=viEndUserSecurityLevel
	$notFinished:=True:C214
	$tableName:=WCapi_GetParameter("TableName"; "")
	$theRecordNum:=Num:C11(WCapi_GetParameter("RecordNum"; ""))
	$tableNum:=STR_GetTableNumber($tableName)
	
	$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
	$jitPageList:=WCapi_GetParameter("jitPageList"; "")
	$skipClone:=False:C215
	Case of 
		: (voState.url="/Mfr_CreateDealer@")
			MfrXRefCreate(variable1; variable2; variable3; variable4)
			$doPage:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageOne)
		: (voState.url="/Mfr_Item@")
			$tableName:="Item"
			Case of 
				: ($theRecordNum=-3)
					CREATE RECORD:C68([Item:4])
					[Item:4]itemNum:1:=String:C10(CounterNew(->[Item:4]))
					WC_Parse(Table:C252(->[Item:4]); $2; True:C214)
					If (Record number:C243([Item:4])>-1)
						[Item:4]mfrID:53:=[ManufacturerTerm:111]customerID:1
						SAVE RECORD:C53([Item:4])
					End if 
				: ($theRecordNum>0)
					$saveAction:=WCapi_GetParameter("SaveAction"; "")
					GOTO RECORD:C242([Item:4]; $theRecordNum)
					If (([Item:4]mfrID:53=[ManufacturerTerm:111]customerID:1) | (vWccPrimeRec>-1))
						Case of 
							: ($saveAction="Clone")
								$itemNum:=WCapi_GetParameter("ItemNum"; "")
								If ($itemNum#"")
									QUERY:C277([Item:4]; [Item:4]itemNum:1=$itemNum)
									$skipClone:=(Records in selection:C76([Item:4])=1)
									vResponse:="ItemNum already exists:  "+$itemNum
								End if 
								If ($skipClone=False:C215)
									GOTO RECORD:C242([Item:4]; $theRecordNum)
									DUPLICATE RECORD:C225([Item:4])
									If ($itemNum="")
										[Item:4]itemNum:1:=String:C10(CounterNew(->[Item:4]))
									Else 
										[Item:4]itemNum:1:=$itemNum
									End if 
									WC_Parse(Table:C252(->[Item:4]); $2; True:C214)
									vResponse:="[Item] matched and saved"
								End if 
							: ($saveAction="Save")
								WC_Parse(Table:C252(->[Item:4]); $2; True:C214)
								vResponse:="[Item] matched and saved"
							Else 
								vResponse:="[Item] matched, display record"
						End case 
					Else 
						REDUCE SELECTION:C351([Item:4]; 0)
						vResponse:="[Item] and manufactureID not matched"
					End if 
				Else 
					Http_ItemsNar($1; $2; [ManufacturerTerm:111]customerID:1)
					$sendPage:=False:C215
			End case 
			Case of 
				: (Records in selection:C76([Item:4])=1)
					$doPage:=WC_DoPage("Mfr"+$tableName+"One.html"; $jitPageOne)
				: (Records in selection:C76([Item:4])>1)
					$doPage:=WC_DoPage("Mfr"+$tableName+"List.html"; $jitPageList)
			End case 
		: (voState.url="/Mfr_Stores@")
			$tableName:="MfrsCarried"
			Case of 
				: ($theRecordNum=-3)
					$storeRecordNum:=Num:C11(WCapi_GetParameter("StoreRecordNum"; ""))
					If ($storeRecordNum>0)
						CREATE RECORD:C68([MfrCustomerXRef:110])
						
						[MfrCustomerXRef:110]mfrID:3:=[RemoteUser:57]customerID:10
						[MfrCustomerXRef:110]manufacturerName:5:=[RemoteUser:57]company:16
						[MfrCustomerXRef:110]dateLastUpdate:7:=Current date:C33
						[MfrCustomerXRef:110]comment:10:=WCapi_GetParameter("Comment"; "")
						[MfrCustomerXRef:110]publishStatus:11:=WCapi_GetParameter("Status"; "")
						PUSH RECORD:C176([Customer:2])  //already in selection, pulled by RemoterUser
						GOTO RECORD:C242([Customer:2]; $storeRecordNum)
						[MfrCustomerXRef:110]customerID:2:=[Customer:2]customerID:1
						[MfrCustomerXRef:110]customerName:6:=[Customer:2]company:2
						POP RECORD:C177([Customer:2])
						SAVE RECORD:C53([MfrCustomerXRef:110])
					End if 
				: ($theRecordNum>0)
					GOTO RECORD:C242([MfrCustomerXRef:110]; $theRecordNum)
					If (([MfrCustomerXRef:110]mfrID:3=[ManufacturerTerm:111]customerID:1) | (vWccPrimeRec>-1))
						$saveAction:=WCapi_GetParameter("SaveAction"; "")
						If ($saveAction="save")
							WC_Parse(Table:C252(->[MfrCustomerXRef:110]); $2; True:C214)
							vResponse:="[MfrsCarried] matched, saved"
						Else 
							vResponse:="[MfrsCarried] matched, no save command"
						End if 
					Else 
						vResponse:="[MfrsCarried] matched"
					End if 
				Else 
					QUERY:C277([MfrCustomerXRef:110]; [MfrCustomerXRef:110]mfrID:3=[ManufacturerTerm:111]customerID:1)
			End case 
			Case of 
				: (Records in selection:C76([MfrCustomerXRef:110])=1)
					$doPage:=WC_DoPage("Mfr"+$tableName+"One.html"; $jitPageOne)
				: (Records in selection:C76([MfrCustomerXRef:110])>1)
					$doPage:=WC_DoPage("Mfr"+$tableName+"List.html"; $jitPageList)
			End case 
		: (voState.url="/Mfr_LoadCust@")  //Utilities
			//$jitPageOne:=WCapi_GetParameter("jitPageOne";"")
			If (Records in selection:C76([Customer:2])=1)
				$doPage:=WC_DoPage("Mfr"+$tableName+"One.html"; $jitPageOne)
				vResponse:=""
			Else 
				vResponse:="No manufacturer found"
			End if 
			$sendPage:=True:C214
			
		: (voState.url="/WCC_QueryFieldValue@")
			$tableNum:=WccQuery3Fields
			If (($tableNum=2) | ($tableNum=Table:C252(->[MfrCustomerXRef:110])) | ($tableNum=Table:C252(->[Order:3])))
				//
			End if 
			
		: (voState.url="/WCC_QueryOrderLinesByZip@")
			WccItemSalesByZip($1; $2; [RemoteUser:57]customerID:10)
			$doPage:=WC_DoPage("MfrCustomersList.html"; $jitPageList)
			//
		: (voState.url="/Mfr_Execute@")
			$reportName:=WCapi_GetParameter("ReportName"; "")
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8=$reportName; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="MfrExecute"; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=[RemoteUser:57]securityLevel:4)
			If ($reportName="Mfr@")
				vWccSecurity:=[RemoteUser:57]securityLevel:4
				WccExecuteServ($1; $2)
				$sendPage:=False:C215
				vWccSecurity:=-1
			Else 
				vResponse:="Access to this command is not available or you did not create this record."
				$sendPage:=True:C214
			End if 
	End case 
End if 
If ($sendPage)
	$err:=WC_PageSendWithTags($c; $doPage; 0)
End if 




If (False:C215)
	ARRAY LONGINT:C221(aTmpLong1; 0)
	SELECTION TO ARRAY:C260([Customer:2]; aTmpLong1)
	QUERY:C277([RemoteUser:57]; [RemoteUser:57]customerID:10="002001")
	QUERY:C277([Customer:2]; [Customer:2]customerID:1="002001")
	vi2:=Size of array:C274(aTmpLong1)
	For (vi1; 1; vi2)
		CREATE RECORD:C68([MfrCustomerXRef:110])
		
		[MfrCustomerXRef:110]mfrID:3:=[RemoteUser:57]customerID:10
		[MfrCustomerXRef:110]manufacturerName:5:=[RemoteUser:57]company:16
		[MfrCustomerXRef:110]dateLastUpdate:7:=Current date:C33
		[MfrCustomerXRef:110]comment:10:="WCapi_GetParameter comment"
		[MfrCustomerXRef:110]publishStatus:11:="WCapi_GetParameter Status"
		PUSH RECORD:C176([Customer:2])  //already in selection, pulled by RemoterUser
		
		vi5:=aTmpLong1{vi1}
		
		GOTO RECORD:C242([Customer:2]; vi5)
		[MfrCustomerXRef:110]customerID:2:=[Customer:2]customerID:1
		[MfrCustomerXRef:110]customerName:6:=[Customer:2]company:2
		POP RECORD:C177([Customer:2])
		SAVE RECORD:C53([MfrCustomerXRef:110])
	End for 
End if 
