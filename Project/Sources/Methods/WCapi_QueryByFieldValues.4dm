//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/05/21, 10:37:47
// ----------------------------------------------------
// Method: WCapi_QueryByFieldValues
// Description
// 
//
// Parameters
// ----------------------------------------------------

vResponse:="Error: Invalid requrest: "+voState.request.URL.href
//
//
C_POINTER:C301(ptCurTable; $ptTable)
C_LONGINT:C283($viTableNum; $viFieldNum)
C_TEXT:C284($tableName; $vtTableNameLC; $vtFieldName; $value)
ptCurTable:=(->[Base:1])
//TRACE
C_OBJECT:C1216($obSel; $obRec)
$tableName:=WCapi_GetParameter("tableName"; "")
If ($tableName="")
	$tableName:=WCapi_GetParameter("Table"; "")
End if 
If ($tableName="")
	vResponse:="Error: No TableName"
Else 
	$obSel:=ds:C1482[$tableName].new()
	If ($obSel=Null:C1517)
		vResponse:="Error: No valid TableName, "+$tableName
	Else 
		Case of 
			: (voState.url="/ByObject@")
				WCapiTask_QueryByObject
			: (voState.url="/ByField@")  //WCC_QueryFieldValue@") | (voState.url="/WCC_QueryFields@"))
				$viTableNum:=WccQuery3Fields
			: (voState.url="/id@")
				C_TEXT:C284($vtUUIDkey)
				$vtUUIDkey:=WCapi_GetParameter("id"; "")
				If ($vtUUIDkey="")
					vResponse:="Error: id is empty"
				Else 
					C_OBJECT:C1216($voSel; $voRec)
					$voSel:=ds:C1482[$tableName].query("id = :1"; $vtUUIDkey)
					If ($voSel=Null:C1517)
						vResponse:="Error: "+$tableName+"id invalid "+$vtUUIDkey
					Else 
						$voRec:=$voSel.first()
					End if 
				End if 
			: (voState.url="/KeyTag@")
				If ($viTableNum>0)
					srKeyword:=WCapi_GetParameter("keyword@"; "")
					If (srKeyword="")
						vResponse:="Error: No keyword provided."
					Else 
						KeyWordByAlpha($viTableNum; srKeyword)
					End if 
				End if 
			: (voState.url="/Report@")
				$doPageHere:=False:C215
				WccReports($1; $2)
				
			: (voState.url="/ListAll@")
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="SEARCH"; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=vWccSecurity)
				
			: (voState.url="/OrderLinesByZip@")
				WccItemSalesByZip($1; $2)
				//
			: (voState.url="/Query_ListTable@")
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="SEARCH"; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]tableNum:1=$viTableNum; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=vWccSecurity)
			: (voState.url="/QueryRecordNum@")
				$recordStr:=WCapi_GetParameter("RecordNum"; "")
				$recordNum:=Num:C11($recordStr)
				If (($recordNum=0) & ($recordStr#"0"))
					$recordNum:=-1
					vResponse:="Error: Record Number must be declared and greater than -1"
				Else 
					GOTO RECORD:C242(Table:C252($viTableNum)->; $recordNum)
				End if 
			: (voState.url="/FieldRange@")
				$vtFieldName:=WCapi_GetParameter("FieldName"; "")
				$ptField:=STR_GetFieldPointer($tableName; $vtFieldName)
				$viFieldNum:=Field:C253($ptField)
				If (Is nil pointer:C315($ptField))
					Response:="Error: "+$vtFieldName+" is not a valid field in table "+$tableName
				Else 
					vResponse:="Executing: TallyMasters "+$reportName
					$strBeginValue:=WCapi_GetParameter("beginValue"; "")
					$strEndValue:=WCapi_GetParameter("endValue"; "")
					$theType:=Type:C295($ptField->)
					Case of 
						: (($theType=0) | ($theType=24))
							QUERY:C277($ptTable->; $ptField->>=$strBeginValue; *)
							QUERY:C277($ptTable->;  & $ptField-><=$strEndValue)
						: (($theType=1) | ($theType=8))
							QUERY:C277($ptTable->; $ptField->>=Num:C11($strBeginValue); *)
							QUERY:C277($ptTable->;  & $ptField-><=Num:C11($strEndValue))
						: ($theType=9)  //real, integer, longint
							If ($vtFieldName="DT@")
								QUERY:C277($ptTable->; $ptField->>=DateTime_DTTo(Date:C102($strBeginValue)); *)
								QUERY:C277($ptTable->;  & $ptField-><=DateTime_DTTo(Date:C102($strEndValue); ?23:59:59?))
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
					$recCount:=Records in selection:C76(Table:C252($viTableNum)->)
				End if 
				
				// 
			: (voState.url="/Execute@")
				$reportName:=WCapi_GetParameter("ReportName"; "")
				If ($reportName="")
					$reportName:=WCapi_GetParameter("reportName"; "")
					If ($reportName="")
						$reportName:=WCapi_GetParameter("reportname"; "")
						If ($reportName="")
							vResponse:="Error: Report Name must be declared."
						End if 
					End if 
				End if 
				If ($reportName#"")
					QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8=$reportName; *)
					QUERY:C277([TallyMaster:60];  & ; [TallyMaster:60]purpose:3="WCapi/QueryExecute"; *)
					QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>=0; *)
					QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=viSecureLvl)
					Case of 
						: (Records in selection:C76([TallyMaster:60])=0)
							vResponse:="Error: Report Name does not exist with Purpose WCapiQueryExecute: "+$reportName+" at UserLevel "+String:C10(viSecureLvl)
						: (Records in selection:C76([TallyMaster:60])>1)
							vResponse:="Error: Multiple report Name with Purpose WCapiQueryExecute: "+$reportName+" at UserLevel "+String:C10(viSecureLvl)
						Else 
							vResponse:="Executing: TallyMasters "+$reportName
							ExecuteText(0; [TallyMaster:60]script:9)
					End case 
				End if 
		End case 
		
		Case of 
			: (vResponse#"Error@")
				// send out text of message
			: ($vbReturnRecord)
				C_OBJECT:C1216($voDate)
				$voDate.data:=jsonFieldsToObject($tableName; $vtfieldList; $vtMapTF)
				vResponse:=JSON Stringify:C1217($voDate)
			Else 
				$vtRole:="Sales"
				$vtPurpose:="list"
				C_OBJECT:C1216($voSelection)
				$voSelection:=API_SelectionToObject($tableName)
				$vtFieldList:=API_GetFieldList($tableName; $vtRole; $vtPurpose)
				vResponse:=API_EntityToText($voSelection; $vtFieldList)
				voState.result:=$tableName+" records in selection: "+String:C10($voSelection.length)
		End case 
	End if 
End if 

