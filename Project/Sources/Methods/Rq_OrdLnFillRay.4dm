//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/08/11, 09:08:17
// ----------------------------------------------------
// Method: Rq_OrdLnFillRay
// Description
// 
//
// Parameters
// ----------------------------------------------------

//Procedure: RqOrdLnFillRays  check this before changing
C_LONGINT:C283($lnTest; $i; $1; $k)  //$1 number of lines
//If ($1<0)
//Case of 
//: ($2=File([Order]))
//QUERY([OrderLine];[OrderLine]OrderNum=[Order]OrderNum)
//$1:=Records in selection([OrderLine])
//: ($2=File([InvLine]))

//: ($2=File([PO]))
//SEARCH([POLine];[POLine]PONum=[PO]PONum)
//$1:=Records in selection([POLine])
//: ($2=File([Proposal]))
//SEARCH([PrpLine];[PrpLine]ProposalNum=[Proposal]ProposalNum)
//$1:=Records in selection([PrpLine])
//Else 
//$1:=0
//End case 
//End if 
//

OrdLnRays(0)
QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
FIRST RECORD:C50([Order:3])
$k:=Records in selection:C76([OrderLine:49])
FIRST RECORD:C50([OrderLine:49])
For ($i; 1; $k)
	$w:=Find in array:C230(<>aItemLines; [OrderLine:49]lineNum:3)
	If ($w>0)
		$w:=Size of array:C274(aOLineNum)+1
		OrdLn_RaySize(1; $w; 1)
		aOPricePt{$w}:="Or"
		aOSerialRc{$w}:=[Order:3]orderNum:2
		aOLineNum{$w}:=[OrderLine:49]lineNum:3
		aOItemNum{$w}:=[OrderLine:49]itemNum:4
		aODescpt{$w}:=[OrderLine:49]description:5
		aOQtyOrder{$w}:=[OrderLine:49]qtyOrdered:6
		aODscntUP{$w}:=DiscountApply([OrderLine:49]unitPrice:9; [OrderLine:49]discount:10; <>tcDecimalUP)
		aOExtPrice{$w}:=[OrderLine:49]extendedPrice:11
		aOExtCost{$w}:=[OrderLine:49]extendedCost:13
		//
		aOUnitMeas{$w}:=[OrderLine:49]unitofMeasure:19
		aOUnitWt{$w}:=[OrderLine:49]unitWt:20
		aOExtWt{$w}:=[OrderLine:49]extendedWt:21
		aOLocation{$w}:=[OrderLine:49]location:22
		//    
		aOSeq{$w}:=[OrderLine:49]sequence:30
		aODateReq{$w}:=[OrderLine:49]dateRequired:23
		aoDateShipOn{$w}:=[OrderLine:49]dateShipOn:38
		aoDateShipped{$w}:=[OrderLine:49]dateShipped:39
		aoProdBy{$w}:=[OrderLine:49]producedBy:43
	End if 
	NEXT RECORD:C51([OrderLine:49])
End for 