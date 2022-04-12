//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/29/20, 22:28:55
// ----------------------------------------------------
// Method: WC_ProposalToOrder
// Description
// 
//
// Parameters
// ----------------------------------------------------

// you need to already have the [Proposal] record in memory

If (False:C215)
	QUERY:C277([Proposal:42]; [Proposal:42]proposalNum:5=1005)
End if 
allowAlerts_boo:=False:C215
ptCurTable:=(->[Proposal:42])
vHere:=2
ARRAY LONGINT:C221(aPpDeleteLines; 0)
NxPvProposals  // load the arrays and variables

C_TEXT:C284($vtStatus; $vtComplete)
$vtStatus:=WCapi_GetParameter("Status"; "")
$vtComplete:=WCapi_GetParameter("Complete"; "")
Case of 
	: ($vtStatus#"")  // if declared
		[Proposal:42]status:2:=$vtStatus
	: ([Proposal:42]status:2="")  // if field is empty
		[Proposal:42]status:2:="Webclerk converted"
End case 
If (($vtComplete="") | ($vtComplete="1@") | ($vtComplete="t@"))
	[Proposal:42]complete:56:=True:C214
End if 
booAccept:=True:C214
vMod:=True:C214
// acceptPropsl   // not needed

// must be set to select the lines to be transferred
//  $cntPPLns:=Size of array(aPPLnSelect)
// aPPLnSelect
C_LONGINT:C283($k; $i)
$k:=Size of array:C274(aPItemNum)
ARRAY LONGINT:C221(aPPLnSelect; $k)
For ($i; 1; $k)
	aPPLnSelect{$i}:=$i
End for 


//
myCycle:=4  // coming from a Proposal
CREATE RECORD:C68([Order:3])
[Order:3]customerID:1:=[Proposal:42]customerID:1
NxPvOrders
booAccept:=True:C214
vMod:=True:C214
acceptOrders

vHere:=0