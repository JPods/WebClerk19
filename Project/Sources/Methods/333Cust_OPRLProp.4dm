//%attributes = {"publishedWeb":true}
//Procedure: Cust_OPRLProp
//Noah Dykoski  April 21, 1999 / 1:47 AM
C_LONGINT:C283($1; $PropRecNum)
$PropRecNum:=$1

GOTO RECORD:C242([Proposal:42]; $PropRecNum)
QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=[Proposal:42]idNum:5)

SELECTION TO ARRAY:C260([ProposalLine:43]; $aOPRLRecID; [ProposalLine:43]itemNum:2; $aOPRLItemNm; [ProposalLine:43]description:4; $aOPRLDesc; [ProposalLine:43]qty:3; $aOPRLQty)
SELECTION TO ARRAY:C260([ProposalLine:43]unitPrice:15; $aOPRLPrice; [ProposalLine:43]unitCost:7; $aOPRLCost; [ProposalLine:43]discount:17; $aOPRLDisc; [ProposalLine:43]altItemNum:34; $aOPRLAltItm)
SELECTION TO ARRAY:C260([ProposalLine:43]profile1:38; $aOPRLPro1; [ProposalLine:43]profile2:39; $aOPRLPro2; [ProposalLine:43]profile3:40; $aOPRLPro3)
C_LONGINT:C283($i; $k)
$k:=Size of array:C274($aOPRLRecID)

For ($i; 1; $k)
	aOPRLType{$i}:="ppl"
	aOPRLItemNm{$i}:=$aOPRLItemNm{$i}
	aOPRLDesc{$i}:=$aOPRLDesc{$i}
	aOPRLQty{$i}:=$aOPRLQty{$i}
	aOPRLPrice{$i}:=$aOPRLPrice{$i}
	aOPRLCost{$i}:=$aOPRLCost{$i}
	aOPRLDisc{$i}:=$aOPRLDisc{$i}
	If (aOPRLPrice{$i}>0)
		aOPRLMargin{$i}:=Round:C94(((aOPRLPrice{$i}-aOPRLCost{$i})/aOPRLPrice{$i})*100; 2)
	Else 
		aOPRLMargin{$i}:=0
	End if 
	aOPRLAltItm{$i}:=$aOPRLAltItm{$i}
	aOPRLCustmr{$i}:=[Proposal:42]bill2Company:57
	aOPRLPro1{$i}:=$aOPRLPro1{$i}
	aOPRLPro2{$i}:=$aOPRLPro2{$i}
	aOPRLPro3{$i}:=$aOPRLPro3{$i}
	aOPRLRecID{$i}:=$aOPRLRecID{$i}
End for 
UNLOAD RECORD:C212([Proposal:42])
UNLOAD RECORD:C212([ProposalLine:43])