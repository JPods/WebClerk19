//%attributes = {"publishedWeb":true}
//Procedure: http_CallRpt
C_LONGINT:C283($1; $err; $orderNum; $recordID; $ppNum; $k)
C_POINTER:C301($2)
C_LONGINT:C283($recordID)

C_TEXT:C284($doPage; $suffix)
vResponse:=""
$suffix:=""
$doPage:=WC_DoPage("Error"+$suffix+".html"; "")
$recordID:=Num:C11(WCapi_GetParameter("RecordID"; ""))
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")

If (vWccTableNum>2)
	$doSteps:=True:C214
	Case of 
		: (vWccTableNum=(Table:C252(->[Rep:8])))
			GOTO RECORD:C242([Rep:8]; vWccPrimeRec)
			$theAcct:=[Rep:8]repID:1
			$doRep:=True:C214
		: (vWccTableNum=(Table:C252(->[Employee:19])))
			GOTO RECORD:C242([Employee:19]; vWccPrimeRec)
			$theAcct:=[Employee:19]nameID:1
			$doRep:=False:C215
	End case 
	If (Records in selection:C76([Employee:19])+Records in selection:C76([Rep:8])#1)
		vResponse:="No matching Employee or Rep"
	Else 
		QUERY:C277([CallReport:34]; [CallReport:34]idNum:22=$recordID; *)
		If (vWccSecurity<5000)
			QUERY:C277([CallReport:34];  & [CallReport:34]actionBy:3=$theAcct)
		End if 
		QUERY:C277([CallReport:34])
		If (Record number:C243([CallReport:34])>-1)
			Case of 
				: ([CallReport:34]tableNum:2=0)
					$doPage:=WC_DoPage("CallReport"+$suffix+".html"; "")
				: ([CallReport:34]tableNum:2=2)
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[CallReport:34]customerID:1)
					$doPage:=WC_DoPage("CallCustomer"+$suffix+".html"; $jitPageOne)
				: ([CallReport:34]tableNum:2=Table:C252(->[Contact:13]))
					QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11([CallReport:34]customerID:1))
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[CallReport:34]customerID:1)
					$doPage:=WC_DoPage("CallContact"+$suffix+".html"; $jitPageOne)
				: ([CallReport:34]tableNum:2=Table:C252(->[Vendor:38]))
					QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[CallReport:34]customerID:1)
					$doPage:=WC_DoPage("CallVendor"+$suffix+".html"; $jitPageOne)
				: ([CallReport:34]tableNum:2=Table:C252(->[Lead:48]))
					QUERY:C277([Lead:48]; [Lead:48]idNum:32=Num:C11([CallReport:34]customerID:1))
					$doPage:=WC_DoPage("CallLead"+$suffix+".html"; $jitPageOne)
				: ([CallReport:34]tableNum:2=Table:C252(->[Rep:8]))
					QUERY:C277([Rep:8]; [Rep:8]repID:1=[CallReport:34]customerID:1)
					$doPage:=WC_DoPage("CallRep"+$suffix+".html"; $jitPageOne)
			End case 
		Else 
			vResponse:=vResponse+"CallReport Record does not exist."+"\r"
		End if 
	End if 
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)