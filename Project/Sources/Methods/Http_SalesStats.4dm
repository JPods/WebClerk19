//%attributes = {"publishedWeb":true}
If (False:C215)
	Version_0602
	//Method: Http_SalesStats  
	//Date: 07/01/02
	//Who: Bill
	//Description: Sales status
End if 
//
C_LONGINT:C283($1; $err; $orderNum; $trackNum; $ppNum; $k; $ServiceNum)
C_POINTER:C301($2)
C_BOOLEAN:C305($doError; $doRep)
C_TEXT:C284($strDate)
$doError:=True:C214
$suffix:=""
$recNum:=-1
vResponse:="Not signed in as Employee or Rep"
$doPage:=WC_DoPage("Error.html"; "")
Case of 
	: (vWccTableNum=(Table:C252(->[Rep:8])))
		$theAcct:=[Rep:8]repID:1
		$recNum:=Record number:C243([Rep:8])
		$doRep:=True:C214
	: (vWccTableNum=(Table:C252(->[Employee:19])))
		$theAcct:=[Employee:19]nameID:1
		$recNum:=Record number:C243([Employee:19])
		$doRep:=False:C215
End case 
If ($recNum>-1)
	$suffix:=""
	$doError:=False:C215
	//      
	$orderNum:=Num:C11(WCapi_GetParameter("orderNum"; ""))
	$ppNum:=Num:C11(WCapi_GetParameter("proposalNum"; ""))
	$woNum:=Num:C11(WCapi_GetParameter("WONum"; ""))
	$ServiceNum:=Num:C11(WCapi_GetParameter("ServiceNum"; ""))
	$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
	$suffix:=""
	$doError:=False:C215
	READ ONLY:C145([OrderLine:49])
	READ ONLY:C145([Order:3])
	READ ONLY:C145([Proposal:42])
	READ ONLY:C145([ProposalLine:43])
	READ ONLY:C145([TallySummary:77])
	Case of 
		: ($orderNum>0)
			QUERY:C277([Order:3]; [Order:3]orderNum:2=$orderNum; *)
			If ($doRep)
				QUERY:C277([Order:3];  & [Order:3]repID:8=$theAcct)
			Else 
				QUERY:C277([Order:3];  & [Order:3]salesNameID:10=$theAcct)
			End if 
			//
			If (Records in selection:C76([Order:3])=1)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
				QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=$orderNum)
				QUERY:C277([Service:6]; [Service:6]orderNum:22=$orderNum)
				QUERY:C277([WorkOrder:66]; [WorkOrder:66]taskid:22=$orderNum)
				$doPage:=WC_DoPage("WccOrdersOne.html"; "")
			Else 
				vResponse:="No matching Order record"
			End if 
		: ($ppNum>0)
			QUERY:C277([Proposal:42]; [Proposal:42]proposalNum:5=$ppNum; *)
			If ($doRep)
				QUERY:C277([Proposal:42];  & [Proposal:42]repID:7=$theAcct)
			Else 
				QUERY:C277([Proposal:42];  & [Proposal:42]salesNameID:9=$theAcct)
			End if 
			//
			If (Records in selection:C76([Proposal:42])=1)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Proposal:42]customerID:1)
				QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=$ppNum)
				QUERY:C277([Service:6]; [Service:6]proposalNum:27=$ppNum; *)
				QUERY:C277([Service:6];  & [Service:6]customerID:1=[Proposal:42]customerID:1)
				$doPage:=WC_DoPage("WccProposalsOne.html"; "")
			Else 
				vResponse:="No matching Proposal record"
			End if 
		: ($woNum>0)
			QUERY:C277([WorkOrder:66]; [WorkOrder:66]woNum:29=$woNum; *)
			QUERY:C277([WorkOrder:66];  & [WorkOrder:66]actionBy:8=$theAcct)
			
			//
			If (Records in selection:C76([WorkOrder:66])=1)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[WorkOrder:66]customerID:28)
				QUERY:C277([Order:3]; [Order:3]orderNum:2=[WorkOrder:66]taskid:22)
				QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[WorkOrder:66]taskid:22)
				$doPage:=WC_DoPage("WccWorkOrdersOne.html"; $jitPageOne)
			Else 
				vResponse:="No matching Workorder record"
			End if 
		: ($serviceNum>0)
			QUERY:C277([Service:6]; [Service:6]actionCreatedBy:40=$theAcct; *)
			QUERY:C277([Service:6];  | [Service:6]actionBy:12=$theAcct; *)
			QUERY:C277([Service:6];  & [Service:6]idNum:26=$serviceNum)
			//
			If (Records in selection:C76([Service:6])=1)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Service:6]customerID:1)
				QUERY:C277([Order:3]; [Order:3]orderNum:2=[Service:6]orderNum:22)
				$doPage:=WC_DoPage("WccServiceOne.html"; "")
			Else 
				vResponse:="No matching Service record"
			End if 
		Else 
			TRACE:C157
			QUERY:C277([Order:3]; [Order:3]completeid:83<2; *)
			//SEARCH([Order];|[Order]DateInvoiceComp>=(Current date-14);*)
			If ($doRep)
				QUERY:C277([Order:3];  & [Order:3]repID:8=$theAcct)
			Else 
				QUERY:C277([Order:3];  & [Order:3]salesNameID:10=$theAcct)
			End if 
			//
			QUERY:C277([Proposal:42]; [Proposal:42]complete:56=False:C215; *)
			If ($doRep)
				QUERY:C277([Proposal:42];  & [Proposal:42]repID:7=$theAcct)
			Else 
				QUERY:C277([Proposal:42];  & [Proposal:42]salesNameID:9=$theAcct)
			End if 
			//
			If (Not:C34($doRep))
				QUERY:C277([WorkOrder:66]; [WorkOrder:66]dtComplete:6=0; *)
				QUERY:C277([WorkOrder:66];  & [WorkOrder:66]actionBy:8=$theAcct)
			End if 
			//
			QUERY:C277([Quota:9]; [Quota:9]salesRepID:1=$theAcct; *)
			QUERY:C277([Quota:9];  & [Quota:9]tableNum:17=[RemoteUser:57]tableNum:9; *)
			QUERY:C277([Quota:9];  & [Quota:9]publish:2>0; *)
			QUERY:C277([Quota:9];  & [Quota:9]publish:2<=[EventLog:75]securityLevel:16)
			//
			$k:=Records in selection:C76([Order:3])+Records in selection:C76([Proposal:42])+Records in selection:C76([Quota:9])
			//
			Case of 
				: ($k=0)
					vResponse:="No matching [Proposal], [Order] or [Quota] record."
					$doPage:=WC_DoPage("Error.html"; "")
				: ((Records in selection:C76([Order:3])=1) & ($k=1))
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
					QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
					QUERY:C277([WorkOrder:66]; [WorkOrder:66]taskid:22=[Order:3]orderNum:2)
					$doPage:=WC_DoPage("WccOrdersOne.html"; "")
				: ((Records in selection:C76([Proposal:42])=1) & ($k=1))
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Proposal:42]customerID:1)
					QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=[Proposal:42]proposalNum:5)
					$doPage:=WC_DoPage("WccProposalsOne.html"; "")
				Else 
					If (Records in selection:C76([Order:3])>1)
						If (Records in selection:C76([Order:3])><>viMaxShow)
							REDUCE SELECTION:C351([Order:3]; <>viMaxShow)
							//$num:=Records in selection([Order])
						End if 
						ORDER BY:C49([Order:3]; [Order:3]orderNum:2)
					End if 
					If (Records in selection:C76([Proposal:42])>1)
						If (Records in selection:C76([Proposal:42])><>viMaxShow)
							REDUCE SELECTION:C351([Proposal:42]; <>viMaxShow)
							//$num:=Records in selection([Proposal])
						End if 
						ORDER BY:C49([Proposal:42]; [Proposal:42]proposalNum:5)
					End if 
					If (Records in selection:C76([Quota:9])>1)
						ORDER BY:C49([Quota:9]; [Quota:9]period:3; [Quota:9]catagory:19)
					End if 
					$doPage:=WC_DoPage("WccStatus.html"; "")
			End case 
	End case 
	READ WRITE:C146([Order:3])
	$doError:=False:C215
End if 
READ WRITE:C146([RemoteUser:57])
$err:=WC_PageSendWithTags($1; $doPage; 0)
//
READ WRITE:C146([Customer:2])
READ WRITE:C146([RemoteUser:57])