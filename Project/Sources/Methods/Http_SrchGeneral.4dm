//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/11/10, 12:41:08
// ----------------------------------------------------
// Method: Http_SrchGeneral
// Description
// voState.url="/Search_Source@"
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $err; $userRec)
C_POINTER:C301($2)

C_POINTER:C301($ptTable)
C_TEXT:C284($tableName; $jitPageOne; $jitPageError)
$returnValue:=WCapi_GetParameter("returnValue"; "")
$tableName:=WCapi_GetParameter("TableName"; "")
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
$jitPageError:=WCapi_GetParameter("jitPageError"; "")
$jitPageList:=WCapi_GetParameter("jitPageList"; "")
$recordNum:=WCapi_GetParameter("RecordNum"; "")
vResponse:=$tableName+" authorized "
C_TEXT:C284($thePage)
$thePage:=Storage:C1525.wc.webFolder
C_LONGINT:C283($tableNum; $tableReturnNum)
$tableNum:=STR_GetTableNumber($tableName)
$skipRecordCount:=False:C215
If ($tableNum>0)
	$ptTable:=Table:C252($tableNum)
	If (([Customer:2]customerID:1#"") | ([Contact:13]idNum:28>0) | ([Vendor:38]vendorID:1#"") | ([Employee:19]nameID:1#""))  // must be someone
		$theDate:=WCapi_GetParameter("GetDate"; "")
		$openAction:=WCapi_GetParameter("OpenAction"; "")
		Case of 
			: (($tableName="Scripts") | ($tableName="TallyMaster"))
				$queryName:=WCapi_GetParameter("QueryName"; "")
				If ($queryName="")
					vResponse:="QueryName not specified"
				Else 
					QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8=$queryName; *)
					QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="CustomerSearch"; *)
					QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)
					QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=viEndUserSecurityLevel)
					Case of 
						: (Records in selection:C76([TallyMaster:60])=0)
							vResponse:="No such Query Setup"
						: (Records in selection:C76([TallyMaster:60])>1)
							vResponse:="Multiple Query Setup"
						Else 
							$tableReturn:=WCapi_GetParameter("TableReturn"; "")
							$tableReturnNum:=STR_GetTableNumber($tableReturn)
							If ($tableReturnNum>0)
								$ptTable:=Table:C252($tableReturnNum)
								$tableName:=$tableReturn
							End if 
							If (($jitPageOne="") & ($jitPageList="") & ($tableReturnNum<1))
								vResponse:="Must specify: jitPageOne="+$jitPageOne+" or jitPageList "+$jitPageList+" or ReturnTable="+$tableReturn
							Else 
								WC_VariablesRead
								//
								ExecuteText(0; [TallyMaster:60]script:9)
								$skipRecordCount:=True:C214
								If ($tableReturnNum>0)
									$ptTable:=Table:C252($tableReturnNum)
									Case of 
										: (Records in selection:C76($ptTable->)=0)
											vResponse:="No Authorized Records in Table: "+$tableName
											$doPage:=WC_DoPage("Error.html"; $jitPageError)
										: (Records in selection:C76($ptTable->)=1)
											$doPage:=WC_DoPage($tableName+"One.html"; $jitPageOne)
										Else   //: (Records in selection($ptTable->)>1)
											$doPage:=WC_DoPage($tableName+"List.html"; $jitPageList)
									End case 
								Else 
									$doPage:=WC_DoPage($jitPageList; $jitPageOne)
								End if 
							End if 
					End case 
				End if 
			: ($tableName="Order")
				//QUERY([Order];[Order]customerID=[Customer]customerID;*)
				vURLQueryScript:=vURLQueryScript+"QUERY([Order];[Order]customerID="+Txt_Quoted([Customer:2]customerID:1)+";*)"+"\r"
				$testCnt:=1
				If ($theDate#"")
					$testCnt:=txtDateFrom($theDate; 1; $testCnt; ->[Order:3]dateDocument:4)
				End if 
				If ($openAction="Open")
					//QUERY([Order];&[Order]CompleteID<2;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Order];&[Order]CompleteID<2;*)"+"\r"
				End if 
				//QUERY([Order])
				vURLQueryScript:=vURLQueryScript+"QUERY([Order])"+"\r"
				
			: ($tableName="Service")
				$orderNum:=WCapi_GetParameter("OrderNum"; "")
				$invoiceNum:=WCapi_GetParameter("InvoiceNum"; "")
				C_LONGINT:C283($uniqueID)
				$uniqueID:=Num:C11(WCapi_GetParameter("RecordID"; ""))
				//QUERY([Service];[Service]Publish>=viEndUserSecurityLevel;*)
				vURLQueryScript:=vURLQueryScript+"QUERY([Service];[Service]Publish>="+String:C10(viEndUserSecurityLevel)+";*)"+"\r"
				$testCnt:=1
				If ($theDate#"")
					$testCnt:=txtDateFrom($theDate; 1; $testCnt; ->[Service:6]dtBegin:15)
				End if 
				If ($openAction="Open")
					//QUERY([Service];&[Service]Completed=0;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]Completed=0;*)"+"\r"
				End if 
				If ($invoiceNum#"")
					//QUERY([Service];&[Service]InvoiceNum=Num($invoiceNum);*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]InvoiceNum="+$invoiceNum+";*)"+"\r"
				End if 
				If ($uniqueID>0)
					//QUERY([Service];&[Service]UniqueID=$uniqueID;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]UniqueID="+String:C10($uniqueID)+";*)"+"\r"
				End if 
				//QUERY([Service])
				vURLQueryScript:=vURLQueryScript+"QUERY([Service])"+"\r"
				ExecuteText(0; vURLQueryScript)
			: ($tableName="Contact")
				//QUERY([Contact];[Contact]customerID=[Customer]customerID)
				//QUERY([Contact];&[Contact]Publish>=viEndUserSecurityLevel;*)
				//QUERY([Contact])
				vURLQueryScript:=vURLQueryScript+"QUERY([Contact];[Contact]customerID="+Txt_Quoted([Customer:2]customerID:1)+";*)"+"\r"
				vURLQueryScript:=vURLQueryScript+"QUERY([Contact];&[Contact]Publish>="+String:C10(viEndUserSecurityLevel)+")"+"\r"
				ExecuteText(0; vURLQueryScript)
			: ($tableName="Invoice")
				//QUERY([Invoice];[Invoice]customerID=[Customer]customerID;*)
				vURLQueryScript:=vURLQueryScript+"QUERY([Invoice];[Invoice]customerID="+Txt_Quoted([Customer:2]customerID:1)+";*)"+"\r"
				$testCnt:=1
				If ($theDate#"")
					$testCnt:=txtDateFrom($theDate; 1; $testCnt; ->[Invoice:26]dateDocument:35)
				End if 
				If ($openAction="Open")
					//QUERY([Invoice];&[Invoice]BalanceDue#0;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Invoice];&[Invoice]BalanceDue#0;*)"+"\r"
				End if 
				//QUERY([Invoice])
				vURLQueryScript:=vURLQueryScript+"QUERY([Invoice])"+"\r"
			: ($tableName="Payment")
				//QUERY([Payment];[Payment]customerID=[Customer]customerID;*)
				vURLQueryScript:=vURLQueryScript+"QUERY([Payment];[Payment]customerID="+Txt_Quoted([Customer:2]customerID:1)+";*)"+"\r"
				$testCnt:=1
				If ($theDate#"")
					$testCnt:=txtDateFrom($theDate; 1; $testCnt; ->[Payment:28]dateDocument:10)
				End if 
				If ($openAction="Open")
					//QUERY([Payment];&[Payment]AmountAvailable#0;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Payment];&[Payment]AmountAvailable#0;*)"+"\r"
				End if 
				//QUERY([Payment])
				vURLQueryScript:=vURLQueryScript+"QUERY([Payment])"+"\r"
			: ($tableName="Ledger")
				
				
			: ($tableName="CallReport")
				//QUERY([CallReport];[CallReport]customerID=[Customer]customerID;*)
				vURLQueryScript:=vURLQueryScript+"QUERY([CallReport];[CallReport]customerID="+Txt_Quoted([Customer:2]customerID:1)+";*)"+"\r"
				//QUERY([CallReport];&[CallReport]TableNum=2;*)
				vURLQueryScript:=vURLQueryScript+"QUERY([CallReport];&[CallReport]TableNum=2;*)"+"\r"
				//QUERY([CallReport];&[CallReport]Publish>=viEndUserSecurityLevel;*)
				vURLQueryScript:=vURLQueryScript+"QUERY([CallReport];&[CallReport]Publish>="+String:C10(viEndUserSecurityLevel)+";*)"+"\r"
				$testCnt:=1
				If ($theDate#"")
					$testCnt:=txtDateFrom($theDate; 1; $testCnt; ->[Call:34]dtAction:4)
				End if 
				If ($openAction="Open")
					//QUERY([CallReport];&[CallReport]Completed=False;*)
					vURLQueryScript:=vURLQueryScript+"QUERY(viEndUserSecurityLevel;&[CallReport]Completed=false;*)"+"\r"
				End if 
				//QUERY([CallReport])
				vURLQueryScript:=vURLQueryScript+"QUERY([CallReport])"+"\r"
			: ($tableName="WorkOrder")
				//QUERY([WorkOrder];[WorkOrder]customerID=[Customer]customerID;*)
				//QUERY([WorkOrder];&[WorkOrder]Publish>=viEndUserSecurityLevel;*)
				vURLQueryScript:=vURLQueryScript+"QUERY([WorkOrder];[WorkOrder]customerID="+Txt_Quoted([Customer:2]customerID:1)+";*)"+"\r"
				vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[WorkOrder]Publish>="+String:C10(viEndUserSecurityLevel)+";*)"+"\r"
				If ($theDate#"")
					$testCnt:=txtDateFrom($theDate; 1; 1; ->[WorkOrder:66]dtAction:5)
				End if 
				If ($openAction="Open")
					//QUERY([WorkOrder];&[WorkOrder]DTCompleted=0;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([WorkOrder];&[WorkOrder]DTCompleted=0;*)"+"\r"
				End if 
				//QUERY([WorkOrder])
				vURLQueryScript:=vURLQueryScript+"QUERY([WorkOrder])"+"\r"
				//  : ($tableName="QACust")
				
				
				
				//  : ($tableName="Reservation")
				
				
			: ($tableName="LoadTag")
				QUERY:C277([LoadTag:88]; [LoadTag:88]customerID:23=[Customer:2]customerID:1; *)
				If ($theDate#"")
					$testCnt:=txtDateFrom($theDate; 1; 1; ->[LoadTag:88]dtShipOn:10)
				Else 
					QUERY:C277([LoadTag:88];  & [LoadTag:88]dtShipOn:10>DateTime_DTTo(Current date:C33-60))
				End if 
		End case 
		Case of 
			: ($skipRecordCount)
				$doPage:=WC_DoPage($tableName+"List.html"; $jitPageList)
				//: (Records in selection($ptTable->)=0)
				//vResponse:="No Authorized Records in Table: "+$tableName
				//$doPage:=WC_DoPage ("Error.html";$jitPageError)
				
			: (Records in selection:C76($ptTable->)=1)
				$doPage:=WC_DoPage($tableName+"One.html"; $jitPageOne)
				
			Else   //: (Records in selection($ptTable->)>1)
				$doPage:=WC_DoPage($tableName+"List.html"; $jitPageList)
				HTTP_QuerySave($ptTable)
				// Modified by: williamjames (101226)
		End case 
	Else 
		vResponse:="Customer not signed in"
		$doPage:=WC_DoPage("Error.html"; "")
	End if 
Else 
	vResponse:="TableName not specified or specified incorrectly: "+$tableName
	$doPage:=WC_DoPage("Error.html"; "")
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)