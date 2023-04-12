//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/10/11, 09:42:55
// ----------------------------------------------------
// Method: WccMyPage
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1)
C_POINTER:C301($2)
//
$thePage:=""
vResponse:="Command:  MyPage:  Page is not available"
Case of 
	: (Not:C34((vWccTableNum=19) | (vWccTableNum=8)))  //drop if they are not a rep or employee     
		vResponse:="vWccTableNum not employee or rep"
		
	: (voState.url="/Wcc_MyPage_1@")
		If (Record number:C243([Employee:19])#[EventLog:75]wccPrimeUserRec:23)
			GOTO RECORD:C242([Employee:19]; [EventLog:75]wccPrimeUserRec:23)
		End if 
		$thePage:="WccE"+[Employee:19]nameID:1+"1.html"
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3=[Employee:19]nameID:1+"1"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=vWccSecurity)
		
		vResponse:="Wcc_MyPage_1 employee OK"
		//
	: (voState.url="/Wcc_MyPage_2@")
		If (Record number:C243([Employee:19])#[EventLog:75]wccPrimeUserRec:23)
			GOTO RECORD:C242([Employee:19]; [EventLog:75]wccPrimeUserRec:23)
		End if 
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3=[Employee:19]nameID:1+"2"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=vWccSecurity)
		$thePage:="WccE"+[Employee:19]nameID:1+"2.html"
		//		
		vResponse:="Wcc_MyPage_2 employee OK"
	: (voState.url="/Wcc_MyPage_3@")
		If (Record number:C243([Employee:19])#[EventLog:75]wccPrimeUserRec:23)
			GOTO RECORD:C242([Employee:19]; [EventLog:75]wccPrimeUserRec:23)
		End if 
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3=[Employee:19]nameID:1+"3"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=vWccSecurity)
		$thePage:="WccE"+[Employee:19]nameID:1+"3.html"
		//		
		vResponse:="Wcc_MyPage_3 employee OK"
	: (voState.url="/Wcc_MyPage@")
		vResponse:="Wcc_MyPage_Job no person"
		Case of 
			: (vWccTableNum=Table:C252(->[Rep:8]))
				If (Record number:C243([Rep:8])#[EventLog:75]wccPrimeUserRec:23)
					GOTO RECORD:C242([Rep:8]; [EventLog:75]wccPrimeUserRec:23)
				End if 
				$thePage:="WccJReps.html"
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="Sc_Rep@"; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=vWccSecurity)
				//
				QUERY:C277([Report:46]; [Report:46]why:9="Report_Rep@"; *)
				QUERY:C277([Report:46];  & [Report:46]active:1=True:C214; *)
				QUERY:C277([Report:46];  & [Report:46]securityLevel:24<=vWccSecurity)
				vResponse:="Wcc_MyPage_Job rep OK"
			: (vWccTableNum=Table:C252(->[Employee:19]))
				If (Record number:C243([Employee:19])#[EventLog:75]wccPrimeUserRec:23)
					GOTO RECORD:C242([Employee:19]; [EventLog:75]wccPrimeUserRec:23)
				End if 
				$thePage:="WccJ"+[Employee:19]role:7+".html"
				$pathname:=Storage:C1525.wc.webFolder+$thePage
				If (Test path name:C476($pathname)<1)
					$thePage:="EmployeesOne.html"
				End if 
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="Sc_"+[Employee:19]role:7+"@"; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=vWccSecurity)
				//
				QUERY:C277([Report:46]; [Report:46]why:9="Report_"+[Employee:19]role:7+"@"; *)
				QUERY:C277([Report:46];  & [Report:46]active:1=True:C214; *)
				QUERY:C277([Report:46];  & [Report:46]securityLevel:24<=vWccSecurity)
				vResponse:="Wcc_MyPage_Job employee OK"
		End case 
End case 
$thePage:=WC_DoPage("Comment.html"; $thePage)
$err:=WC_PageSendWithTags($1; $thePage; 0)