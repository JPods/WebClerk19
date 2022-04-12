//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-02-06T00:00:00, 11:19:17
// ----------------------------------------------------
// Method: WccSearch
// Description
// Modified: 02/06/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1)
C_POINTER:C301($2)
vResponse:="Page invalid."
//
$doPageHere:=True:C214
$doPage:=WC_DoPage("Error.html"; "")
$jitPageList:=WCapi_GetParameter("jitPageList"; "")
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
//
C_POINTER:C301(ptCurTable; $ptTable)
C_LONGINT:C283($tableNum)
C_TEXT:C284($tableName; $fieldName; $value)
ptCurTable:=(->[Control:1])
//TRACE

$tableName:=WCapi_GetParameter("TableName"; "")
If ($tableName="")
	$tableName:=WCapi_GetParameter("Table"; "")
End if 
$tableNum:=-1
If ($tableName#"")
	$tableNum:=STR_GetTableNumber($tableName)
End if 
If ($tableNum<1)
	vResponse:="No valid TableName, "+$tableName
Else 
	$ptTable:=Table:C252($tableNum)
End if 

Case of 
	: (voState.url="/Wcc_QueryUUIDKey@")
		If ($tableNum>0)
			C_TEXT:C284($vtUUIDkey)
			$vtUUIDkey:=WCapi_GetParameter("id"; "")
			If ($vtUUIDkey="")
				vResponse:="id is empty"
			Else 
				C_POINTER:C301($ptUUIDkey)
				$ptUUIDkey:=STR_GetFieldPointer($tableName; "id")
				READ WRITE:C146($ptTable->)
				QUERY:C277($ptTable->; $ptUUIDkey->=$vtUUIDkey)
				If (Records in selection:C76(Table:C252($tableNum)->)=1)
					$doPage:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageOne)
				Else 
					vResponse:=$tableName+"id invalid "+$vtUUIDkey
				End if 
			End if 
		End if 
		
	: (voState.url="/Wcc_QueryKeyWord@")
		
		
		If ($tableNum>0)
			// switch to this at some time
			//C_OBJECT($objTable)
			//$objTable:=STR_GetTableDefinition ($tableName)
			
			srKeyword:=WCapi_GetParameter("keyword@"; "")
			If (srKeyword="")
				vResponse:="No keyword provided."
			Else 
				KeyWordByAlpha($tableNum; srKeyword)
				$doPage:=WC_DoPage("Wcc"+$tableName+"List.html"; $jitPageList)
			End if 
		End if 
	: (voState.url="/Wcc_QueryLoad@")
		vResponse:="Not released."
	: (voState.url="/Wcc_QueryReport@")
		$doPageHere:=False:C215
		WccReports($1; $2)
		
	: (voState.url="/WCC_QueryListAll@")
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="SEARCH"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=vWccSecurity)
		$doPage:=WC_DoPage("WccAdmQueryList.html"; $jitPageList)
		
	: (voState.url="/WCC_QueryOrderLinesByZip@")
		WccItemSalesByZip($1; $2)
		$doPage:=WC_DoPage("WccCustomersList.html"; $jitPageList)
		//		
	: (voState.url="/WCC_Query_ListTable@")
		If ($tableNum>0)
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="SEARCH"; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]tableNum:1=$tableNum; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=vWccSecurity)
			$doPage:=WC_DoPage("WccAdmQueryList.html"; $jitPageList)
		End if 
	: (voState.url="/WCC_QueryRecordNum@")
		$recordStr:=WCapi_GetParameter("RecordNum"; "")
		$recordNum:=Num:C11($recordStr)
		If (($recordNum=0) & ($recordStr#"0"))
			$recordNum:=-1
		End if 
		
		//TRACE
		$doPage:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageOne)  // ### jwm ### 20170928_1031 moved outside of IF statement
		$tableNum:=STR_GetTableNumber($tableName)
		If (($tableNum>0) & ($recordNum>=0))
			//      
			pvOrderNum:=WCapi_GetParameter("OrderNum"; "")
			ptCurTable:=Table:C252($tableNum)
			GOTO RECORD:C242(Table:C252($tableNum)->; $recordNum)
			pvRecordNum:=Record number:C243(Table:C252($tableNum)->)
			If (pvRecordNum>-1)
				Case of 
					: (($tableNum=73) & ([TallyResult:73]purpose:2="events"))
						pvEvent:=[TallyResult:73]name:1
						jDateTimeRecov([TallyResult:73]dtReport:12; ->vDate1; ->vTime1)
						pvEventDate:=String:C10(vDate1; 1)
					: ($tableNum=Table:C252(->[Document:100]))
						C_TEXT:C284(pvImagePath)
						$p:=Position:C15("images"; [Document:100]path:4)
						pvImagePath:="/"+Substring:C12([Document:100]path:4; $p)
						pvImagePath:=Replace string:C233(pvImagePath; "\\"; "/")
						pvImagePath:=Replace string:C233(pvImagePath; ":"; "/")
						pvImageName:=[Document:100]imageName:2
				End case 
				// put scripts on the page
				//  WccRelateRecords (ptCurTable;$2)
				$actionComment:=WCapi_GetParameter("ActionComment"; "")
				If ($actionComment="")
					vResponse:="Record for Table "+$tableName
				Else 
					vResponse:=$actionComment
				End if 
			End if 
		End if 
	: (voState.url="/@")  //WCC_QueryFieldValue@") | (voState.url="/WCC_QueryFields@"))
		$tableNum:=WccQuery3Fields
		If ($tableNum>0)
			$tableName:=Table name:C256($tableNum)
			$recCount:=Records in selection:C76(Table:C252($tableNum)->)
			If ($recCount=1)
				pvRecordNum:=Record number:C243(Table:C252($tableNum)->)
				$doPage:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageOne)
			Else 
				$jitPageList:=WCapi_GetParameter("jitPageList"; "")
				$doPage:=WC_DoPage("Wcc"+$tableName+"List.html"; $jitPageList)
			End if 
		End if 
	: (voState.url="/WCC_QueryFieldRange@")
		
		If ($tableName#"")
			$tableNum:=STR_GetTableNumber($tableName)
			If ($tableNum>0)
				$fieldName:=WCapi_GetParameter("FieldName"; "")
				
				C_POINTER:C301($ptFieldRay; $ptField; $ptTable)
				$ptTable:=Table:C252($tableNum)
				$fieldNum:=STR_GetFieldNumber($tableName; $fieldName)
				If ($fieldNum>0)
					//
					$strBeginValue:=WCapi_GetParameter("beginValue"; "")
					$strEndValue:=WCapi_GetParameter("endValue"; "")
					C_LONGINT:C283($theType)
					TRACE:C157
					$ptField:=Field:C253($tableNum; $fieldNum)
					$theType:=Type:C295($ptField->)
					Case of 
						: (($theType=0) | ($theType=24))
							QUERY:C277($ptTable->; $ptField->>=$strBeginValue; *)
							QUERY:C277($ptTable->;  & $ptField-><=$strEndValue)
						: (($theType=1) | ($theType=8))
							
							QUERY:C277($ptTable->; $ptField->>=Num:C11($strBeginValue); *)
							QUERY:C277($ptTable->;  & $ptField-><=Num:C11($strEndValue))
						: ($theType=9)  //real, integer, longint
							If ($fieldName="DT@")
								QUERY:C277($ptTable->; $ptField->>=DateTime_Enter(Date:C102($strBeginValue)); *)
								QUERY:C277($ptTable->;  & $ptField-><=DateTime_Enter(Date:C102($strEndValue); ?23:59:59?))
							Else 
								QUERY:C277($ptTable->; $ptField->>=Num:C11($strBeginValue); *)
								QUERY:C277($ptTable->;  & $ptField-><=Num:C11($strEndValue))
							End if 
						: ($theType=11)  //time
							QUERY:C277($ptTable->; $ptField->>=Time:C179($strBeginValue); *)
							QUERY:C277($ptTable->;  & $ptField-><=Time:C179($strEndValue))
						: ($theType=4)  //date
							QUERY:C277($ptTable->; $ptField->>=Date:C102($strBeginValue); *)
							QUERY:C277($ptTable->;  & $ptField-><=Date:C102($strEndValue))
					End case 
					$recCount:=Records in selection:C76(Table:C252($tableNum)->)
					If ($recCount=1)
						WccRelateRecords(Table:C252($tableNum); $2)
						pvRecordNum:=Record number:C243(Table:C252($tableNum)->)
						$doPage:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageOne)
					Else 
						$jitPageList:=WCapi_GetParameter("jitPageList"; "")
						$doPage:=WC_DoPage("Wcc"+$tableName+"List.html"; $jitPageList)
					End if 
				End if 
			End if 
		End if 
		// 
	: (voState.url="/WCC_QueryExecute@")
		$RecordID:=Num:C11(WCapi_GetParameter("recordID"; ""))
		$RecordNUM:=Num:C11(WCapi_GetParameter("recordNUM"; ""))
		$reportName:=WCapi_GetParameter("ReportName"; "")
		If ((($RecordID>0) | ($RecordNUM>0)) & ($reportName#""))
			vResponse:="RecordID must be >=0; "+String:C10($RecordID)+"\r"+"or RecordNum must be >=0 "+String:C10($RecordNUM)+"\r"+"and Report Name needed: "+$reportName
		Else 
			
			Case of 
				: ($RecordID>0)
					QUERY:C277([TallyMaster:60]; [TallyMaster:60]idNum:4=$RecordID)
					QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=$reportName; *)
					QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25=vWccSecurity)
				: ($RecordNUM>-1)
					GOTO RECORD:C242([TallyMaster:60]; $RecordNUM)
					If (([TallyMaster:60]name:8#$reportName) | (vWccSecurity#[TallyMaster:60]publish:25))
						REDUCE SELECTION:C351([TallyMaster:60]; 0)
					End if 
			End case 
			Case of 
				: (Records in selection:C76([TallyMaster:60])=0)
					vResponse:="RecordID must be >=0; "+String:C10($RecordID)+"\r"+"or RecordNum must be >=0 "+String:C10($RecordNUM)+"\r"+"and Report Name needed: "+$reportName+"\r"+"UserLevel must match report publsh level"
				: (Records in selection:C76([TallyMaster:60])>1)
					vResponse:="Multiple Query Setup"
				Else 
					WC_VariablesRead
					//$tableName:=WCapi_GetParameter("tableName";"")
					//$tableNum:=STR_GetTableNumber ($tableName)
					//If ($tableNum>0)
					
					$doPage:=WC_DoPage([TallyMaster:60]profile1:23; "")
					ExecuteText(0; [TallyMaster:60]script:9)
			End case 
		End if 
End case 
//



If ($doPageHere)
	$err:=WC_PageSendWithTags($1; $doPage; 0)
End if 
pvOrderNum:=""