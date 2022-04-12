//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/08/11, 02:26:15
// ----------------------------------------------------
// Method: Pp_FixOrderedQty
// Description
// 
//
// Parameters
// ----------------------------------------------------

CONFIRM:C162("Reset Proposal to Order Counts.")
If (OK=1)
	FIRST RECORD:C50([ProposalLine:43])
	vi6:=Records in selection:C76([ProposalLine:43])
	vR1:=0  //initialize
	For (vi5; 1; vi6)
		MESSAGE:C88(String:C10(vi5))
		QUERY:C277([Order:3]; [Order:3]proposalNum:79=[ProposalLine:43]proposalNum:1)
		vi2:=Records in selection:C76([Order:3])
		FIRST RECORD:C50([Order:3])
		For (vi1; 1; vi2)
			QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
			vi4:=Records in selection:C76([OrderLine:49])
			FIRST RECORD:C50([OrderLine:49])
			For (vi3; 1; vi4)
				If (([OrderLine:49]itemNum:4=[ProposalLine:43]itemNum:2) & ([ProposalLine:43]lineNum:43=[OrderLine:49]lineNum:3))
					vR1:=vR1+[OrderLine:49]qtyOrdered:6
				End if 
				NEXT RECORD:C51([OrderLine:49])
			End for 
			NEXT RECORD:C51([Order:3])
		End for 
		[ProposalLine:43]qtyOpen:51:=[ProposalLine:43]qty:3-vR1
		If ([ProposalLine:43]qtyOpen:51<0)
			[ProposalLine:43]qtyOpen:51:=0
		End if 
		SAVE RECORD:C53([ProposalLine:43])
		NEXT RECORD:C51([ProposalLine:43])
	End for 
End if 

REDRAW WINDOW:C456
