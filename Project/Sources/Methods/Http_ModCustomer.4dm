//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
C_POINTER:C301($2)

C_TEXT:C284($recordID)
C_TEXT:C284($doPage; $suffix)
vResponse:="No RecordID provided"
vInAsCustomer:=""
$suffix:=""
$doPage:=WC_DoPage("Error"+$suffix+".html"; "")
$recordID:=WCapi_GetParameter("RecordID"; "")
$jitpageone:=WCapi_GetParameter("jitpageone"; "")
If ($recordID#"")
	If (vWccTableNum>2)  //employee or rep
		Case of 
			: (vWccSecurity>4999)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=$recordID)
			: (vWccTableNum=(Table:C252(->[Rep:8])))
				GOTO RECORD:C242([Rep:8]; vWccPrimeRec)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=$recordID; *)
				QUERY:C277([Customer:2];  & [Customer:2]repID:58=[Rep:8]repID:1)
				$doRep:=True:C214
			: (vWccTableNum=(Table:C252(->[Employee:19])))
				GOTO RECORD:C242([Employee:19]; vWccPrimeRec)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=$recordID; *)
				QUERY:C277([Customer:2];  & [Customer:2]salesNameID:59=[Employee:19]nameID:1)
				$theAcct:=[Employee:19]nameID:1
				$doRep:=False:C215
		End case 
		If (Records in selection:C76([Customer:2])=1)
			If ([RemoteUser:57]securityLevel:4>4999)
				QUERY:C277([Service:6]; [Service:6]customerID:1=$recordID; *)
				QUERY:C277([Service:6];  & [Service:6]dtComplete:18#0)
			Else 
				QUERY:C277([Service:6]; [Service:6]actionBy:12=$theAcct; *)
				QUERY:C277([Service:6];  | [Service:6]actionCreatedBy:40=$theAcct; *)
				If ($doRep)
					QUERY:C277([Service:6];  | [Service:6]repID:2=$theAcct; *)
				End if 
				QUERY:C277([Service:6];  & [Service:6]customerID:1=$recordID; *)
				QUERY:C277([Service:6];  & [Service:6]dtComplete:18#0)
			End if 
			//
			QUERY:C277([CallReport:34]; [CallReport:34]tableNum:2=2; *)
			QUERY:C277([CallReport:34];  & [CallReport:34]customerID:1=[Customer:2]customerID:1; *)
			QUERY:C277([CallReport:34];  & [CallReport:34]complete:7=False:C215)
			//
			QUERY:C277([Ledger:30]; [Ledger:30]customerID:1=$recordID; *)
			QUERY:C277([Ledger:30];  & [Ledger:30]unAppliedValue:6#0)
			ORDER BY:C49([Ledger:30]; [Ledger:30]dateDue:5)
			
			
			//
			PUSH RECORD:C176([RemoteUser:57])
			QUERY:C277([RemoteUser:57]; [RemoteUser:57]customerID:10=[Customer:2]customerID:1; *)
			QUERY:C277([RemoteUser:57];  & [RemoteUser:57]tableNum:9=2)
			If (Records in selection:C76([RemoteUser:57])=0)
				RemoteUser_Create(->[Customer:2]; [Customer:2]customerID:1+Txt_RandomString(5; "a"; "z"); [Customer:2]zip:8; 1)
			Else 
				FIRST RECORD:C50([RemoteUser:57])
			End if 
			vInAsCustomer:="<A HREF="+Txt_Quoted("/search_user?userName="+[RemoteUser:57]userName:2+"&Password="+[RemoteUser:57]userPassword:3)+">Sign-in As Customer</A>"
			POP RECORD:C177([RemoteUser:57])
			C_TEXT:C284(vInAsCustomer)
			//
			$doPage:=WC_DoPage("CustomerMod.html"; $jitPageOne)
			
		End if 
	Else 
		vResponse:="Customer Record does not exist or not assigned to you."+"\r"
	End if 
Else 
	vResponse:="Not signed in as Employee or Rep."+"\r"
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)
vInAsCustomer:=""
vResponse:=""