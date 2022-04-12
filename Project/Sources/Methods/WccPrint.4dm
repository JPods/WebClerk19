//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: WccReportServ
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
	
	C_LONGINT:C283($1)
	C_POINTER:C301($2)
	//Method: WccExecuteServ
End if 
C_LONGINT:C283($1)
C_POINTER:C301($2)
//  /Wcc_Print?TableName=Orders&FieldName=OrderNum&Value=_jit_3_2jj&ReportName=Primary
vResponse:="Missing Report or Report Parameters"
C_POINTER:C301($ptField; $ptTable)
C_TEXT:C284($reportName; $tableName; $fieldName; $value; $jitPageOne)
C_LONGINT:C283($fieldNum; $tableNum; $theType)
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
$tableName:=WCapi_GetParameter("tableName"; "")
//TRACE
$tableNum:=STR_GetTableNumber($tableName)
If ($tableNum>0)
	$ptTable:=Table:C252($tableNum)
	$fieldName:=WCapi_GetParameter("FieldName"; "")
	$fieldNum:=STR_GetFieldNumber($tableName; $fieldName)
	If ($fieldNum>0)
		$ptField:=Field:C253($tableNum; $fieldNum)
		$theType:=Type:C295($ptField->)
		$value:=WCapi_GetParameter("value"; "")
		If (($value#"") & ($value#"0"))
			If ($theType=Is longint:K8:6)
				QUERY:C277($ptTable->; $ptField->=Num:C11($value))
			Else 
				QUERY:C277($ptTable->; $ptField->=$value)
			End if 
			If (Records in selection:C76($ptTable->)=1)
				$reportName:=WCapi_GetParameter("ReportName"; "")
				If (($reportName="") | ($reportName="primary"))
					GOTO RECORD:C242([UserReport:46]; <>aPrimeRpts{Table:C252($ptTable)})
				Else 
					QUERY:C277([UserReport:46]; [UserReport:46]name:2=$reportName)
					Case of 
						: (Records in selection:C76([UserReport:46])>1)
							REDUCE SELECTION:C351([UserReport:46]; 1)
							LOAD RECORD:C52([UserReport:46])
						: (Records in selection:C76([UserReport:46])=1)
							GOTO RECORD:C242([UserReport:46]; <>aPrimeRpts{Table:C252($ptTable)})
					End case 
				End if 
				If (Records in selection:C76([UserReport:46])=1)
					vHere:=2
					C_BOOLEAN:C305(noDialog)
					noDialog:=True:C214
					P_vHereBegin
					// Prnt_ReportOpts (vHere)
					SRE_Print
					P_vHereEnd
					$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
					$thePage:=WC_DoPage("Error.html"; $jitPageOne)
				End if 
			End if 
		End if 
	End if 
End if 
$doPage:=WC_DoPage("Error.html"; $jitPageOne)
$err:=WC_PageSendWithTags($1; $doPage; 0)