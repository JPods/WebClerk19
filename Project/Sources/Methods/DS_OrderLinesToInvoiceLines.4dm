//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/16/21, 22:23:37
// ----------------------------------------------------
// Method: DS_OrderLinesToInvoiceLines
// Description
// 
//
// Parameters
// ----------------------------------------------------


#DECLARE($obOrderLine : Object)->$return : Object
$obInvoiceLine:=ds:C1482.InvoiceLine.new()
$obInvoiceLine.altItem:=$obOrderLine.altItem
$obInvoiceLine.comment:=$obOrderLine.comment
$obInvoiceLine.commRateRep:=$obOrderLine.commRateRep
$obInvoiceLine.commRateSales:=$obOrderLine.commRateSales
$obInvoiceLine.commRep:=$obOrderLine.commRep
$obInvoiceLine.commSales:=$obOrderLine.commSales
$obInvoiceLine.company:=$obOrderLine.company
$obInvoiceLine.customerID:=$obOrderLine.customerID
$obInvoiceLine.description:=$obOrderLine.description
$obInvoiceLine.discount:=$obOrderLine.discount
$obInvoiceLine.discountedPrice:=$obOrderLine.discountedPrice
$obInvoiceLine.divisionNum:=$obOrderLine.divisionNum
$obInvoiceLine.idNum:=$obOrderLine.idNum
$obInvoiceLine.idOrderLine:=$obOrderLine.id
$obInvoiceLine.itemNum:=$obOrderLine.itemNum
$obInvoiceLine.lineProfile1:=$obOrderLine.lineProfile1
$obInvoiceLine.lineProfile2:=$obOrderLine.lineProfile2
$obInvoiceLine.lineProfile3:=$obOrderLine.lineProfile3
$obInvoiceLine.location:=$obOrderLine.location
$obInvoiceLine.locationBin:=$obOrderLine.locationBin
$obInvoiceLine.orderLineNum:=$obOrderLine.lineNum
$obInvoiceLine.orderNum:=$obOrderLine.orderNum
$obInvoiceLine.printNot:=$obOrderLine.printNot
$obInvoiceLine.producedBy:=$obOrderLine.producedBy
$obInvoiceLine.profile1:=$obOrderLine.profile1
$obInvoiceLine.profile2:=$obOrderLine.profile2
$obInvoiceLine.profile3:=$obOrderLine.profile3
$obInvoiceLine.profile4:=$obOrderLine.profile4
$obInvoiceLine.profileReal1:=$obOrderLine.profileReal1
$obInvoiceLine.profileReal2:=$obOrderLine.profileReal2
$obInvoiceLine.qty:=$obOrderLine.qtyBackLogged
$obInvoiceLine.qtyOrderedAtInvoice:=$obOrderLine.qty
$obInvoiceLine.repID:=$obOrderLine.repID
$obInvoiceLine.salesNameID:=$obOrderLine.salesNameID
$obInvoiceLine.salesTax:=$obOrderLine.salesTax
$obInvoiceLine.salesTaxRate:=$obOrderLine.salesTaxRate
$obInvoiceLine.seq:=$obOrderLine.seq
$obInvoiceLine.serialNum:=$obOrderLine.serialNum
$obInvoiceLine.serialRc:=$obOrderLine.serialRc
$obInvoiceLine.shipOrderStatus:=$obOrderLine.status
$obInvoiceLine.siteID:=$obOrderLine.siteID
$obInvoiceLine.taxCost:=$obOrderLine.taxCost
$obInvoiceLine.taxJuris:=$obOrderLine.taxJuris
$obInvoiceLine.typeItem:=$obOrderLine.typeItem
$obInvoiceLine.typeSale:=$obOrderLine.typeSale
$obInvoiceLine.unitCost:=$obOrderLine.unitCost
$obInvoiceLine.unitofMeasure:=$obOrderLine.unitofMeasure
$obInvoiceLine.unitPrice:=$obOrderLine.unitPrice
$obInvoiceLine.unitWt:=$obOrderLine.unitWt
$obInvoiceLine.vendorID:=$obOrderLine.vendorID
$obInvoiceLine.save()
$0:=$obInvoiceLine
