//%attributes = {"publishedWeb":true}

//Procedure: RqOrdLnFillRays  check this before changing
C_LONGINT:C283($lnTest; $i; $1; $w; $k)  //$1 number of lines
TRACE:C157
OrdLnRays(0)
$k:=Size of array:C274(<>aItemLnRec)
For ($i; 1; $k)
	If (<>aItemLnRec{$i}>-1)
		$w:=Size of array:C274(aOLineNum)+1
		OrdLn_RaySize(1; $w; 1)
		GOTO RECORD:C242([ProposalLine:43]; <>aItemLnRec{$i})
		aOPricePt{$w}:="PP"
		aOSerialRc{$w}:=[ProposalLine:43]proposalNum:1
		aOLineNum{$w}:=[ProposalLine:43]lineNum:43
		aOItemNum{$w}:=[ProposalLine:43]itemNum:2
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[ProposalLine:43]itemNum:2)
		aODescpt{$w}:=[ProposalLine:43]description:4
		aOQtyOrder{$w}:=[ProposalLine:43]qty:3
		aODscntUP{$w}:=DiscountApply([ProposalLine:43]unitPrice:15; [ProposalLine:43]discount:17; <>tcDecimalUC)
		aOExtPrice{$w}:=[ProposalLine:43]extendedPrice:16
		aOExtCost{$w}:=[ProposalLine:43]extendedCost:8
		
		aOUnitMeas{$w}:=[ProposalLine:43]saleUnitofMeas:13
		aOUnitWt{$w}:=[ProposalLine:43]unitWeight:22
		aOExtWt{$w}:=[ProposalLine:43]unitWeight:22*[ProposalLine:43]qty:3
		aOLocation{$w}:=<>aItemLnRec{$i}
		aOSeq{$w}:=[ProposalLine:43]sequence:33
		aODateReq{$w}:=[ProposalLine:43]cateExpected:41
		aoDateShipOn{$w}:=[ProposalLine:43]cateExpected:41
		aoDateShipped{$w}:=!00-00-00!
		aoProdBy{$w}:=[ProposalLine:43]producedBy:36
	End if 
End for 
UNLOAD RECORD:C212([ProposalLine:43])
UNLOAD RECORD:C212([Item:4])