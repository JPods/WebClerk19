//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/02/21, 23:27:47
// ----------------------------------------------------
// Method: ParseProposalRecord
// Description
// 
// Parameters
// ----------------------------------------------------


//  RRRR to Objects
C_LONGINT:C283($1)
If ($1#[Proposal:42]proposalNum:5)
	QUERY:C277([Proposal:42]; [Proposal:42]proposalNum:5=$1)
End if 
If (Locked:C147([Proposal:42]))
	WCapi_SetParameter("isLocked"; "true")
	vResponse:="Error: Proposals record locked: "+String:C10([Proposal:42]proposalNum:5)
Else 
	NxPvProposals
	// Modified by: Bill James (2015-03-21T00:00:00 added in case of no customer
	// booAccept would be set to false by NxPvOrders and lines would not calculate)
	booAccept:=True:C214
	vMod:=True:C214
	QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=[Proposal:42]proposalNum:5)
	$k:=Records in selection:C76([ProposalLine:43])
	PpLnFillRays
	vMod:=calcProposal(True:C214)
	acceptPropsl
	
	Execute_TallyMaster("ProposalsAfterParse"; "WebScript")
End if 
