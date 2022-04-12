//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/16/21, 21:08:14
// ----------------------------------------------------
// Method: DS_ProposalLineToOrderLine
// Description
// 
//
// Parameters
// ----------------------------------------------------
#DECLARE($obProposalLine : Object)->$return : Object
$obOrderLine:=ds:C1482.OrderLine.new()
$obOrderLine.lineNum:=$obProposalLine.lineNum
$obOrderLine.altItem:=$obProposalLine.altItemNum
$obOrderLine.comment:=$obProposalLine.comment
$obOrderLine.commRateRep:=$obProposalLine.commRateRep
$obOrderLine.commRateSales:=$obProposalLine.commRateSales
$obOrderLine.commRep:=$obProposalLine.commRep
$obOrderLine.commSales:=$obProposalLine.commSales
$obOrderLine.costFreight:=$obProposalLine.costFreight
$obOrderLine.costTaxable:=$obProposalLine.costTaxable
$obOrderLine.costUnitOfMeasure:=$obProposalLine.costUnitofMeasure
$obOrderLine.costValueAddedTax:=$obProposalLine.costValueAddedTax
$obOrderLine.customerID:=$obProposalLine.customerID
$obOrderLine.description:=$obProposalLine.description
$obOrderLine.discount:=$obProposalLine.discount
$obOrderLine.discountedPrice:=$obProposalLine.discountedPrice
$obOrderLine.divisionNum:=$obProposalLine.divisionNum
$obOrderLine.extendedCost:=$obProposalLine.extendedCost
$obOrderLine.extendedPrice:=$obProposalLine.extendedPrice
$obOrderLine.extendedWt:=$obProposalLine.extendedWt
$obOrderLine.itemNum:=$obProposalLine.itemNum
$obOrderLine.lineProfile1:=$obProposalLine.itemProfile1
$obOrderLine.lineProfile2:=$obProposalLine.itemProfile2
$obOrderLine.lineProfile3:=$obProposalLine.itemProfile3
$obOrderLine.location:=$obProposalLine.location
$obOrderLine.locationBin:=$obProposalLine.locationBin
$obOrderLine.printNot:=$obProposalLine.printNot
$obOrderLine.producedBy:=$obProposalLine.producedBy
$obOrderLine.profile1:=$obProposalLine.profile1
$obOrderLine.profile2:=$obProposalLine.profile2
$obOrderLine.profile3:=$obProposalLine.profile3


$obOrderLine.qty:=$obProposalLine.qty
// Look at qtyOpen also for blanket Proposals

$obOrderLine.salesTax:=$obProposalLine.salesTax
$obOrderLine.salesTaxRate:=$obProposalLine.salesTaxRate
$obOrderLine.seq:=$obProposalLine.seq
$obOrderLine.serialRc:=$obProposalLine.serialized
$obOrderLine.status:=$obProposalLine.status
$obOrderLine.taxCost:=$obProposalLine.taxCost
$obOrderLine.taxJuris:=$obProposalLine.taxJuris
$obOrderLine.typeSale:=$obProposalLine.typeSale
$obOrderLine.unitCost:=$obProposalLine.unitCost
$obOrderLine.unitofMeasure:=$obProposalLine.unitofMeasure
$obOrderLine.unitPrice:=$obProposalLine.unitPrice
$obOrderLine.unitWt:=$obProposalLine.unitWeight
$obOrderLine.vendorID:=$obProposalLine.vendorID
$obOrderLine.save()
$0:=$obOrderLine