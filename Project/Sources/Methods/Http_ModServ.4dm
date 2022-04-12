//%attributes = {"publishedWeb":true}
//Procedure: Http_ServGet

C_LONGINT:C283($1; $err; $orderNum; $recordID; $ppNum; $k)
C_POINTER:C301($2)
$suffix:=""
vResponse:=""
C_LONGINT:C283($recordID)
C_TEXT:C284($theAcct)
$recordID:=Num:C11(WCapi_GetParameter("RecordID"; ""))
$theAcct:=WCapi_GetParameter("salesNameID"; "")
C_TEXT:C284($doPage)
$doPage:=WC_DoPage("Error"+$suffix+".html"; "")
$jitPageOne:=WCapi_GetParameter("$jitPageOne"; "")
$doAction:=True:C214
Case of 
	: (vWccSecurity>4999)
		//the account is declared by the   
		
	: (vWccTableNum=(Table:C252(->[Rep:8])))
		GOTO RECORD:C242([Rep:8]; [EventLog:75]customerRecNum:8)
		$theAcct:=[Rep:8]repID:1
		$doRep:=True:C214
	: (vWccTableNum=(Table:C252(->[Employee:19])))
		GOTO RECORD:C242([Employee:19]; [EventLog:75]customerRecNum:8)
		$theAcct:=[Employee:19]nameID:1
		$doRep:=False:C215
	Else 
		$doAction:=False:C215
End case 
If (($recordID>0) & ($doAction))
	QUERY:C277([Service:6]; [Service:6]actionBy:12=$theAcct; *)
	QUERY:C277([Service:6];  | [Service:6]actionCreatedBy:40=$theAcct)
	
	QUERY:C277([Service:6];  | [Service:6]repID:2=$theAcct)
	QUERY:C277([Service:6];  & [Service:6]idNum:26=$recordID)
	If (Record number:C243([Service:6])=-1)
		vResponse:=vResponse+"Service Record does not exist."+"\r"
	Else 
		If ([Service:6]customerID:1#"")
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Service:6]customerID:1)
		End if 
		If ([Service:6]orderNum:22#0)
			QUERY:C277([Order:3]; [Order:3]orderNum:2=[Service:6]orderNum:22)
			QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Service:6]orderNum:22)
		End if 
		If ([Service:6]proposalNum:27#0)
			QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=[Service:6]proposalNum:27)
			QUERY:C277([Proposal:42]; [Proposal:42]proposalNum:5=[Service:6]proposalNum:27)
		End if 
		$doPage:=WC_DoPage("ServiceMod"+$suffix+".html"; $jitPageOne)
	End if 
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)