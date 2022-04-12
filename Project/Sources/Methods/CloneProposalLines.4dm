//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/09/21, 00:38:45
// ----------------------------------------------------
// Method: CloneProposalLines
// Description
// 
//
// Parameters
// ----------------------------------------------------
#DECLARE($viProposalNum : Real)
C_OBJECT:C1216($obRec; $obSel)

ProposalCopy($viProposalNum)
READ ONLY:C145([ProposalLine:43])
// get the proposal lines from the cloned record
QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=$viProposalNum)
PpLnFillRays(Records in selection:C76([ProposalLine:43]))
// reset the line to new lines
REDUCE SELECTION:C351([ProposalLine:43]; 0)
READ WRITE:C146([ProposalLine:43])
$k:=Size of array:C274(aPUniqueID)
For ($i; 1; $k)
	aPUniqueID{$i}:=-3
	aPLineNum{$i}:=$i
End for 
viOrdLnCnt:=$k



C_OBJECT:C1216($obRec; $obSel)
$obSel:=ds:C1482.Proposal.query("proposalNum = :1"; $viProposalNum)
$obRec:=$obSel.first()

PpLnReCalc(1)

vMod:=calcProposal(True:C214)
If (ePropList>0)
	//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)
End if 

