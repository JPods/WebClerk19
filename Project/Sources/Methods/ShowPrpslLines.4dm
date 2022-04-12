//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-10-06T00:00:00, 15:43:32
// ----------------------------------------------------
// Method: ShowPrpslLines
// Description
// Modified: 10/06/16
// 
// 
//
// Parameters
// ----------------------------------------------------


Case of 
	: ((vHere>1) & (ptCurTable=(->[Proposal:42])))
		QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=[Proposal:42]proposalNum:5)
		ProcessTableOpen(Table:C252(->[ProposalLine:43]))
	: ((vHere=1) & (ptCurTable=(->[Proposal:42])))
		C_BOOLEAN:C305($doJoin)
		$doJoin:=True:C214
		Case of 
			: (ptCurTable=(->[Customer:2]))
				//PROJECT SELECTION([PrpLine]AcctKey)      
				$doJoin:=False:C215
				BEEP:C151
				BEEP:C151
			: (ptCurTable=(->[Proposal:42]))
				RELATE MANY SELECTION:C340([ProposalLine:43]proposalNum:1)
			Else 
				DB_ShowByTableName("ProposalLine")
				$doJoin:=False:C215
		End case 
		If ($doJoin)
			If (Records in selection:C76([ProposalLine:43])>0)
				ProcessTableOpen(Table:C252(->[ProposalLine:43]))
			End if 
		End if 
	Else 
		DB_ShowByTableName("ProposalLine")
End case 