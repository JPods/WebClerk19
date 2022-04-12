//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 04/28/20, 06:29:18
// ----------------------------------------------------
// Method: PpLn_AddAsRecord
// Description
// SEE: PpLn_RaySize for line management via arrays
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($1; $vObLine)

$vObLine:=$1

CREATE RECORD:C68([ProposalLine:43])
//[ProposalLine]UniqueID
[ProposalLine:43]lineNum:43:=[ProposalLine:43]idNum:52
[ProposalLine:43]seq:33:=[ProposalLine:43]idNum:52
//
[ProposalLine:43]proposalNum:1:=[Proposal:42]proposalNum:5
[ProposalLine:43]status:30:=[Proposal:42]status:2
[ProposalLine:43]probability:9:=[Proposal:42]probability:43
[ProposalLine:43]customerID:42:=[Proposal:42]customerID:1
[ProposalLine:43]cateExpected:41:=[Proposal:42]dateExpected:42
[ProposalLine:43]producedBy:36:=[RemoteUser:57]name:20

// change this to allow
If (OB Is defined:C1231($vObLine; "TypeSale"))
	[ProposalLine:43]typeSale:32:=OB Get:C1224($vObLine; "ItemNum")
Else 
	[ProposalLine:43]typeSale:32:=[Proposal:42]typeSale:20
End if 

[ProposalLine:43]complete:35:=False:C215
[ProposalLine:43]calculateLine:20:=True:C214
//

//  Item basics
[ProposalLine:43]itemNum:2:=[Item:4]itemNum:1
[ProposalLine:43]altItemNum:34:=[Item:4]mfrItemNum:39
[ProposalLine:43]taxid:14:=[Item:4]taxid:17
[ProposalLine:43]description:4:=[Item:4]description:7

[ProposalLine:43]location:12:=[Item:4]location:9
[ProposalLine:43]locationBin:55:=[Item:4]locationBin:113
[ProposalLine:43]saleUnitofMeas:13:=[Item:4]unitofMeasure:11
[ProposalLine:43]leadTime:26:=[Item:4]leadTimeSales:12
[ProposalLine:43]printNot:54:=0
[ProposalLine:43]serialized:31:=Num:C11([Item:4]serialized:41)
[ProposalLine:43]comment:37:=[Item:4]liComment:66
[ProposalLine:43]profile1:38:=[Item:4]profile1:35
[ProposalLine:43]profile2:39:=[Item:4]profile2:36
[ProposalLine:43]profile3:40:=[Item:4]profile3:37
[ProposalLine:43]unitWeight:22:=[Item:4]weightAverage:8




// test which
// [ProposalLine]QtyOpen:=aPQtyOrder{$i}-aPQtyOriginal{$i}
[ProposalLine:43]qtyOpen:51:=0

[ProposalLine:43]qty:3:=aPQtyOrder{$i}
[ProposalLine:43]unitPrice:15:=aPUnitPrice{$i}
[ProposalLine:43]discount:17:=aPDiscnt{$i}
[ProposalLine:43]discountedPrice:56:=aPDscntUP{$i}
[ProposalLine:43]unitCost:7:=aPUnitCost{$i}

[ProposalLine:43]taxCost:53:=0
[ProposalLine:43]salesTax:18:=aPSaleTax{$i}

[ProposalLine:43]extendedCost:8:=aPExtCost{$i}
[ProposalLine:43]extendedPrice:16:=aPExtPrice{$i}
[ProposalLine:43]extendedWt:19:=aPExtWt{$i}
[ProposalLine:43]commRateRep:27:=aPRepRate{$i}
[ProposalLine:43]commRep:28:=aPRepComm{$i}
[ProposalLine:43]commRateSales:21:=aPSalesRate{$i}
[ProposalLine:43]commSales:29:=aPSaleComm{$i}

SAVE RECORD:C53([ProposalLine:43])