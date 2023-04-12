//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: WccSaveRecord 
	//Date: 07/01/02
	//Who: Bill
	//Save records from a WebClerk client
End if 
//
C_LONGINT:C283($1; $returnRecNum; $recordNum)
C_POINTER:C301($2)
C_BOOLEAN:C305($newRec)
C_TEXT:C284($3; $initiatedBy; $4; $typeRecord)
$initiatedBy:=""
$typeRecord:=""
If (Count parameters:C259>2)
	$initiatedBy:=$3
	If (Count parameters:C259>3)
		$typeRecord:=$4
	End if 
End if 

SavedRecordNum:=-1  // ### jwm ### 20171214_2209 default value -1 = No Record
//
vResponse:="Table name not correctly stated."
$errorPage:=WCapi_GetParameter("jitPageError"; "")  // ### AZM ### 20180208 USE HTTP PARAMETER
$pageDo:=WC_DoPage($errorPage; "Error.html")  // ### AZM ### 20180208 USE LOCAL VARIABLE BASED ON jitPageError HTTP PARAMETER
$tableName:=WCapi_GetParameter("TableName"; "")
C_LONGINT:C283($tableNum; $fieldNum)
C_POINTER:C301($ptfield; $ptTable)
$tableNum:=STR_GetTableNumber($tableName)
If ($tableNum>0)
	$fieldName:=WCapi_GetParameter("FieldName"; "")
	$fieldNum:=STR_GetFieldNumber($tableName; $fieldName)
	$recordStr:=WCapi_GetParameter("RecordNum"; "")
	If ($recordStr="")  // double checking to assure no value is not equated to a zeroth record value
		$recordNum:=-1
	Else 
		$recordNum:=Num:C11($recordStr)
	End if 
	$ptTable:=Table:C252($tableNum)
	If ($fieldNum>0)
		$ptfield:=Field:C253($tableNum; $fieldNum)
	End if 
	$recordID:=WCapi_GetParameter("RecordID"; "")
	
	C_TEXT:C284(returnTable; returnField; $returnID; returnPage)
	returnTable:=WCapi_GetParameter("ReturnTable"; "")
	
	// Modified by: William James (2014-02-04T00:00:00 Subrecord eliminated)
	// making the return items uniform with ItemNarrow
	
	returnField:=WCapi_GetParameter("ReturnField"; "")
	If (returnField="")
		returnField:=WCapi_GetParameter("ReturnKeyField"; "")
	End if 
	//$errorPage:=WCapi_GetParameter ("jitPageError";"") // ### AZM ### 20180208 MOVED OUTSIDE CURRENT IF STATEMENT
	returnValue:=WCapi_GetParameter("ReturnValue"; "")
	If (returnValue="")
		returnValue:=WCapi_GetParameter("ReturnID"; "")
	End if 
	$returnRecNum:=Num:C11(WCapi_GetParameter("ReturnRecordNum"; ""))
	//
	returnPage:=WCapi_GetParameter("ReturnPage"; "")
	If (returnPage="")
		returnPage:=WCapi_GetParameter("jitPageReturn"; "")
		If (returnPage="")
			returnPage:=WCapi_GetParameter("PageReturn"; "")
		End if 
	End if 
	
	$returnAutoRelate:=WCapi_GetParameter("ReturnAutoRelate"; "")  // needed to keep WccRelateRecords (line 125) from displacing new customer information
	
	If (($returnAutoRelate="f@") | ($returnAutoRelate="n@") | ($returnAutoRelate="0@"))
		$returnAutoRelate:="false"
	Else   //  (($returnAutoRelate="") | ($returnAutoRelate="y@") | ($returnAutoRelate="t@") | ($returnAutoRelate="1@"))
		$returnAutoRelate:="true"
	End if 
	If (returnPage="")
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
	Else 
		$jitPageOne:=returnPage
	End if 
	$pageDo:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageOne)
	//
	READ WRITE:C146(Table:C252($tableNum)->)
	If (($recordStr#"0") & ($recordNum=0))  // set to no record if the first record is not intentionally called
		$recordNum:=-1
	End if 
	Case of 
		: ($recordNum>-1)  //must have at least one record
			GOTO RECORD:C242(Table:C252($tableNum)->; $recordNum)
			$newRec:=False:C215
			
		: (($recordID#"") & ($recordID#"-1") & ($fieldNum>0))
			If (Type:C295($ptfield->)=Is longint:K8:6)
				QUERY:C277($ptTable->; $ptfield->=Num:C11($recordID))
			Else 
				QUERY:C277($ptTable->; $ptfield->=$recordID)
			End if 
		Else 
			CREATE RECORD:C68($ptTable->)
			$newRec:=True:C214
	End case 
	//TRACE
	If (Locked:C147(Table:C252($tableNum)->))
		vResponse:="Record was locked by another process.  Change was not saved."
	Else 
		vResponse:="Changes Posted."
		WC_Parse($tableNum; $2; True:C214)
		Case of 
			: ($tableNum=2)
				WC_AddChangeLog($tableNum; ->[Customer:2]comment:15; $newRec)
			: ($tableNum=13)
				WC_AddChangeLog($tableNum; ->[Contact:13]comment:29; $newRec)
		End case 
		$jitPageReturn:=WCapi_GetParameter("ReturnPage"; "")
		If ($jitPageReturn="")
			$jitPageReturn:=WCapi_GetParameter("PageReturn"; "")
			If ($jitPageReturn="")
				$jitPageReturn:=WCapi_GetParameter("jitPageReturn"; "")
			End if 
		End if 
		Case of 
			: (($errorPage#"") & ($jitPageReturn=$errorPage))
				pvRecordNum:=Record number:C243(Table:C252($tableNum)->)
				pvTableName:=$tableName
				vResponse:="Record posted."
				$pageDo:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageReturn)
				If (Records in selection:C76(Table:C252($tableNum)->)=1)
					WccRelateRecords(Table:C252($tableNum); $2)
				End if 
			: (($jitPageOne="") & ((returnTable=$tableName) | (returnTable="SameTable") | (returnTable="")))
				pvRecordNum:=Record number:C243(Table:C252($tableNum)->)
				pvTableName:=$tableName
				vResponse:="Record posted."
				If ($jitPageOne="")
					$jitPageReturn:=WCapi_GetParameter("jitPageReturn"; "")
				Else 
					$jitPageReturn:=$jitPageOne
				End if 
				$pageDo:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageReturn)
				If ((Records in selection:C76(Table:C252($tableNum)->)=1) & ($returnAutoRelate="true"))
					WccRelateRecords(Table:C252($tableNum); $2)
				End if 
			: (($jitPageOne="") & ((returnTable=$tableName) | (returnTable="SameTable") | (returnTable="")))
				pvRecordNum:=Record number:C243(Table:C252($tableNum)->)
				pvTableName:=$tableName
				vResponse:="Record posted."
				If ($jitPageReturn="")
					$jitPageReturn:=$jitPageOne
				End if 
				$pageDo:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageReturn)
				If ((Records in selection:C76(Table:C252($tableNum)->)=1) & ($returnAutoRelate="true"))
					WccRelateRecords(Table:C252($tableNum); $2)
				End if 
			: ((returnTable#"") & (((returnField#"") & (returnValue#"")) | ($returnRecNum>0)))
				vResponse:=vResponse+" Return Field/values not correctly stated."
				$tableNumReturn:=STR_GetTableNumber(returnTable)
				//$returnNum:=0//
				pvTableName:=returnTable
				If ($tableNumReturn>0)
					C_LONGINT:C283($tableNumReturn; $tableNum; $theReturnFldType)
					If ($returnRecNum>0)
						GOTO RECORD:C242(Table:C252($tableNumReturn)->; $returnRecNum)
						pvRecordNum:=$returnRecNum
					Else 
						$fieldNumReturn:=STR_GetFieldNumber(returnTable; returnField)
						If ($fieldNumReturn>0)
							vResponse:="Return values not correctly stated."
							//
							$theReturnFldType:=Type:C295(Field:C253($tableNumReturn; $fieldNumReturn)->)
							Case of 
								: ($theReturnFldType=2)
									QUERY:C277(Table:C252($tableNumReturn)->; Field:C253($tableNumReturn; $fieldNumReturn)->=returnValue)
								: ($theReturnFldType=9)
									C_LONGINT:C283($returnLong)
									$returnLong:=Num:C11(returnValue)
									QUERY:C277(Table:C252($tableNumReturn)->; Field:C253($tableNumReturn; $fieldNumReturn)->=$returnLong)
								Else 
									$doSkip:=True:C214
							End case 
						End if 
					End if 
					
					If ((Records in selection:C76(Table:C252($tableNum)->)=1) & ($returnAutoRelate="true"))
						WccRelateRecords(Table:C252($tableNumReturn); $2)
						If ($jitPageOne="")
							$jitPageReturn:=WCapi_GetParameter("jitPageReturn"; "")
						Else 
							$jitPageReturn:=$jitPageOne
						End if 
						$pageDo:=WC_DoPage("Wcc"+returnTable+"One.html"; $jitPageReturn)
						vResponse:=vResponse+"Return from Table "+$tableName+"."
					End if 
				End if 
		End case 
	End if 
	// ### jwm ### 20171214_2203 moved inside if $tablenum > 0 to protect from pointer Error
	SavedRecordNum:=Record number:C243(Table:C252($tableNum)->)  // ### azm ### 20171006_1330
Else 
	ConsoleLog("Method: WccSaveRecord \rERROR: "+$tableName+"does not resolve to valid Table Number ["+String:C10($tableNum)+"] \r\rFull Request = "+voState.request.headers.Referer)
End if 

Case of 
	: ((returnTable="Order") & ($tableName="Customer"))
		QUERY:C277([Order:3]; [Order:3]idNum:2=$returnLong)
		LoadCustOrder
		SAVE RECORD:C53([Order:3])
	: ((returnTable="Invoice") & ($tableName="Customer"))
		QUERY:C277([Invoice:26]; [Invoice:26]idNum:2=$returnLong)
		LoadCustomersInvoices
		SAVE RECORD:C53([Invoice:26])
	: ((returnTable="Proposal") & ($tableName="Customer"))
		QUERY:C277([Proposal:42]; [Proposal:42]idNum:5=$returnLong)
		ProposalLoadCus
		SAVE RECORD:C53([Proposal:42])
	: ((returnTable="PO") & ($tableName="Vendor"))
		QUERY:C277([PO:39]; [PO:39]idNum:5=$returnLong)
		loadVendor2PO
		SAVE RECORD:C53([PO:39])
End case 


$err:=WC_PageSendWithTags($1; $pageDo; 0)
//
