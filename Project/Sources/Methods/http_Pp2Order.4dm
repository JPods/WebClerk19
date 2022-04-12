//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/15/21, 13:33:58
// ----------------------------------------------------
// Method: http_Pp2Order
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (True:C214)  // currently using record
	C_LONGINT:C283($1; $3; $recordID)
	C_POINTER:C301($2)
	READ ONLY:C145([Proposal:42])
	READ ONLY:C145([Customer:2])
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[RemoteUser:57]customerID:10)
	[Order:3]orderNum:2:=CounterNew(->[Order:3])
	[Order:3]labelCount:32:=1
	[Order:3]takenBy:36:="WebClerk"
	QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=[Proposal:42]proposalNum:5)
	PpLnFillRays(Records in selection:C76([ProposalLine:43]))
	Ord_FromProposal
	[Order:3]dateOrdered:4:=Current date:C33
	[Order:3]timeOrdered:58:=Current time:C178
	If (<>tcCancelBy>0)
		[Order:3]dateCancel:53:=[Order:3]dateNeeded:5+<>tcCancelBy
	End if 
	booAccept:=True:C214
	acceptOrders
	UNLOAD RECORD:C212([ProposalLine:43])
	UNLOAD RECORD:C212([Proposal:42])
Else 
	
End if 