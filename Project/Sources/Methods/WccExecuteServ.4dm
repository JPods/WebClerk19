//%attributes = {"publishedWeb":true}
If (False:C215)
	C_LONGINT:C283($1)
	C_POINTER:C301($2)
	//Method: WccExecuteServ
End if 
C_TEXT:C284($thePage; $reportPurpose; $reportName; $TableName)
C_TEXT:C284($relatedTable; $jitPageOne)
vResponse:="No Matching Action"

$thePage:=WC_DoPage("Error.html"; "")
$reportPurpose:=WCapi_GetParameter("Purpose"; "")

$reportName:=WCapi_GetParameter("ReportName"; "")
If ($reportName="")
	$reportName:=WCapi_GetParameter("Name"; "")
End if 
$TableName:=WCapi_GetParameter("TableName"; "")

$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
// $relatedTable:=WCapi_GetParameter ("TableReturn";"")
// needs a Process variable

If (($reportName#"") & ($reportPurpose#"") & ($TableName#""))
	WC_VariablesRead
	
	vResponse:="[UserReport]Name = "+$reportName
	
	Case of 
		: ($TableName="UserReports")
			
			vResponse:="[UserReport]Name = "+$reportName
			
			QUERY:C277([UserReport:46]; [UserReport:46]name:2=$reportName)
			If ((Records in selection:C76([UserReport:46])=1) & ([UserReport:46]active:1=True:C214) & ([UserReport:46]securityLevel:24>0) & ([UserReport:46]securityLevel:24<=vWccSecurity))
				vResponse:=vResponse+"\r"+"found"
				$thePage:=WC_DoPage([UserReport:46]template:7; "")
				If ([UserReport:46]scriptBegin:5#"")
					vResponse:=vResponse+"\r"+"execute script"
					ExecuteText(0; [UserReport:46]scriptBegin:5)
				End if 
			Else 
				vResponse:=vResponse+"\r"+"No active UserReport record with appropriate name and authority."
			End if 
		: ($TableName="TallyMaster")
			If (($reportPurpose#"") & ($reportName#""))
				vResponse:="[TallyMaster]Name = "+$reportName
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3=$reportPurpose; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=$reportName)
				Case of 
					: (Records in selection:C76([TallyMaster:60])=0)
						vResponse:=vResponse+"\r"+"No TallyMasters"
					: (Records in selection:C76([TallyMaster:60])>1)
						vResponse:=vResponse+"\r"+"Multiple TallyMasters"
						REDUCE SELECTION:C351([TallyMaster:60]; 0)
					: ([TallyMaster:60]publish:25=0)
						vResponse:=vResponse+"\r"+"Not published"
						REDUCE SELECTION:C351([TallyMaster:60]; 0)
					: (([TallyMaster:60]profile2:24=">=@") & (vWccSecurity>=[TallyMaster:60]publish:25))
						// ### bj ### 20181218_1941  WHY
						vResponse:=vResponse+"\r"+"[TallyMaster]Profile2=\">=@\""  //OK to pass
					: ((viEndUserSecurityLevel>1) & ([TallyMaster:60]publish:25<=viEndUserSecurityLevel) & (<>vCommunitySite=1))
						vResponse:=vResponse+"\r"+"Found and valid"
					: (vWccSecurity<[TallyMaster:60]publish:25)
						vResponse:=vResponse+"\r"+"vWccSecurity below [TallyMaster]Publish"
						//vResponse:="User security level does not match report publish level"
						//REDUCE SELECTION([TallyMaster];0)
						//: (vWccSecurity>[TallyMaster]Publish)
						//vResponse:="UserLevel specific.  TallyMaster exceeds user authority, add >= to Profile 2"+" or change user level in report."
						//REDUCE SELECTION([TallyMaster];0)
					Else 
						vResponse:="No Name and Purpose"
				End case 
				
				
				If (Record number:C243([TallyMaster:60])>-1)
					If (([TallyMaster:60]publish:25>0) & (([TallyMaster:60]publish:25<=vWccSecurity) | ((viEndUserSecurityLevel>1) & ([TallyMaster:60]publish:25<=viEndUserSecurityLevel) & (<>vCommunitySite=1))))
						
						$thePage:=WC_DoPage(""; $jitPageOne)
						//TRACE
						Case of 
							: ($reportName="SalesByArticle")  //(False)//    
								WccRptSaleByItem(2)
							: ($reportName="ArticleByCustomer")  //(False)
								WccRptItemsByCustomer
							: ($reportName="SalesByCustomer")  //(False)              
								WccRptSaleByCustomer
							: ([TallyMaster:60]script:9#"")  //(False)
								ExecuteText(0; [TallyMaster:60]script:9)
						End case 
					End if 
				End if 
			End if 
	End case 
End if 
$err:=WC_PageSendWithTags($1; $thePage; 0)
vText1:=""
vText2:=""
vText3:=""
vText4:=""
vText5:=""
vText6:=""
vText7:=""



