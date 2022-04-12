//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $recordID; $recordNUM)
C_POINTER:C301($2)

C_TEXT:C284($doPage; $suffix; $strID; $strNum)
vResponse:=""
$suffix:=""
$doAction:=True:C214
$recordID:=-1
$recordNUM:=-1
$doPage:=WC_DoPage("Error.html"; "")
$strNum:=WCapi_GetParameter("RecordID"; "")
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
If ($strNum#"")
	$recordID:=Num:C11($strNum)
End if 
$strNum:=WCapi_GetParameter("RecordNUM"; "")
If ($strNum#"")
	$recordNum:=Num:C11($strNum)
End if 
Case of 
	: (vWccSecurity>4999)
		QUERY:C277([Contact:13]; [Contact:13]idNum:28=$recordID)
	: (vWccTableNum=(Table:C252(->[Rep:8])))
		GOTO RECORD:C242([Rep:8]; [EventLog:75]customerRecNum:8)
		QUERY:C277([Contact:13]; [Contact:13]idNum:28=$recordID; *)
		QUERY:C277([Contact:13];  & [Contact:13]repID:45=[Rep:8]repID:1)
	: (vWccTableNum=(Table:C252(->[Employee:19])))
		QUERY:C277([Contact:13]; [Contact:13]idNum:28=$recordID; *)
		GOTO RECORD:C242([Employee:19]; [EventLog:75]customerRecNum:8)
		QUERY:C277([Contact:13];  & [Contact:13]salesNameID:39=[Employee:19]nameID:1)
	Else 
		$doAction:=False:C215
End case 
If (($recordID>0) & ($doAction))
	If (Records in selection:C76([Contact:13])=1)
		$doPage:=WC_DoPage("WccContactsOne.html"; $jitPageOne)
		QUERY:C277([CallReport:34]; [CallReport:34]tableNum:2=13; *)
		QUERY:C277([CallReport:34];  & [CallReport:34]customerID:1=String:C10([Contact:13]idNum:28); *)
		QUERY:C277([CallReport:34];  & [CallReport:34]complete:7=False:C215)
		//
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
	Else 
		vResponse:="Contact Record does not exist or not assigned to you."+"\r"
	End if 
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)
//
