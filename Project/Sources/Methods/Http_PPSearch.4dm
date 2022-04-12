//%attributes = {"publishedWeb":true}
//Method: Http_PPSearch
C_LONGINT:C283($1; $err; $orderNum; $k)
C_POINTER:C301($2)
$suffix:=""
$doThis:=0

//zttp_UserGet 
C_TEXT:C284($pageDo)
$suffix:=""
$pageDo:=WC_DoPage("Error"+$suffix+".html"; "")
$orderNum:=Num:C11(WCapi_GetParameter("ProposalNum"; ""))
vResponse:="Must be a customer to check order status, remote user relates to :"+Table name:C256([EventLog:75]tableNum:9)
If (Record number:C243([Customer:2])>-1)
	If ($orderNum>0)
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		QUERY:C277([Proposal:42]; [Proposal:42]proposalNum:5=$orderNum; *)
		QUERY:C277([Proposal:42];  & [Proposal:42]customerid:1=[Customer:2]customerID:1)
		If (Records in selection:C76([Proposal:42])=0)
			vResponse:="No matching Proposal "+String:C10($orderNum)
		Else 
			QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=[Proposal:42]proposalNum:5)
			$pageDo:=WC_DoPage("ProposalsOne.html"; $jitPageOne)
		End if 
	Else 
		vResponse:="You must submit a valid Proposal Number."
	End if 
End if 
$err:=WC_PageSendWithTags($1; $pageDo; 0)
vItemRelated:=""