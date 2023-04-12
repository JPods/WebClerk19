//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/05/20, 13:12:17
// ----------------------------------------------------
// Method: CloneResetKey
// Description
// 
//
// Parameters
// ----------------------------------------------------
CONFIRM:C162("Reset CloneAllowed to less than 1000")
If (OK=1)
	QUERY:C277([Proposal:42]; [Proposal:42]salesNameID:9="CloneAllowed@"; *)
	QUERY:C277([Proposal:42];  & ; [Proposal:42]idNum:5<1000)
	//QUERY([Proposal];[Proposal]salesNameID="cloneallowed@";*)
	//QUERY([Proposal]; & ;[Proposal]ProposalNum>1000)
	ORDER BY:C49([Proposal:42]; [Proposal:42]idNum:5; <)
	FIRST RECORD:C50([Proposal:42])
	vi11:=[Proposal:42]idNum:5
	CONFIRM:C162("Reset CloneAllowed starting from: "+String:C10(vi11))
	If (OK=1)
		QUERY:C277([Proposal:42]; [Proposal:42]salesNameID:9="CloneAllowed"; *)
		QUERY:C277([Proposal:42];  & ; [Proposal:42]idNum:5>999)
		SELECTION TO ARRAY:C260([Proposal:42]; aLong1)
		vi2:=Size of array:C274(aLong1)
		CONFIRM:C162("Records to reset: "+String:C10(vi2))
		If (OK=1)
			For (vi1; 1; vi2)
				GOTO RECORD:C242([Proposal:42]; aLong1{vi1})
				QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=[Proposal:42]idNum:5)
				vi4:=Records in selection:C76([ProposalLine:43])
				CONFIRM:C162("Reset: "+String:C10([Proposal:42]idNum:5)+", Lines: "+String:C10(vi4))
				If (OK=1)
					If (vi4=0)
						[Proposal:42]inquiryCode:6:="NoLines"
					End if 
					vi11:=vi11+1
					srPp:=vi11
					
					FIRST RECORD:C50([ProposalLine:43])
					For (vi3; 1; vi4)
						[ProposalLine:43]idNumProposal:1:=vi11
						SAVE RECORD:C53([ProposalLine:43])
						NEXT RECORD:C51([ProposalLine:43])
					End for 
					[Proposal:42]idNum:5:=vi11
					SAVE RECORD:C53([Proposal:42])
					//Unique_Reset (->[Proposal];->[Proposal]ProposalNum;->srPp)
				End if 
			End for 
		End if 
	End if 
End if 

vi2:=Records in selection:C76([Proposal:42])
CONFIRM:C162("Records to reset: "+String:C10(vi2))
If (OK=1)
	FIRST RECORD:C50([Proposal:42])
	For (vi1; 1; vi2)
		QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=[Proposal:42]idNum:5)
		vi4:=Records in selection:C76([ProposalLine:43])
		If (vi4=0)
			[Proposal:42]inquiryCode:6:="NoLines"
		End if 
		SAVE RECORD:C53([Proposal:42])
		NEXT RECORD:C51([Proposal:42])
	End for 
End if 



