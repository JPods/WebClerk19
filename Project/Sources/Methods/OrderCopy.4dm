//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 05/13/21, 08:11:07
// ----------------------------------------------------
// Method: OrderCopy
// Description
// 
//  put this into an external list of field names to be loaded and manage from there.
// Parameters
// ----------------------------------------------------
var $1; $viParentNum : Integer
C_OBJECT:C1216($obRec; $obSel)
C_OBJECT:C1216($obRec; $obSel)
$obRec:=ds:C1482.Order.query("orderNum = :1"; $1).first()


// MustFixQQQZZZ: Bill James (2021-12-02T06:00:00Z)
// do as loop while protecting key fields
// orderNum; id; 



[Order:3]action:150:="Cloned New"
[Order:3]actionBy:55:=Current user:C182
[Order:3]actionDate:149:=Current date:C33
[Order:3]actionDuration:152:=$obRec.actionDuration
[Order:3]actionTime:37:=Current time:C178
[Order:3]contractDetailTag:151:=$obRec.contractDetailTag
[Order:3]contractDetail:157:=$obRec.contractDetail

//[Order]address1:=$obRec.address1
//[Order]address2:=$obRec.address2
//[Order]addressBillTo:=$obRec.addressBillTo
//[Order]addressShipFrom:=$obRec.addressShipFrom
[Order:3]adSource:41:=$obRec.adSource
[Order:3]alertMessage:80:=$obRec.alertMessage
//[Order]amount:=$obRec.amount
//[Order]amountBackLog:=$obRec.amountBackLog
//[Order]amountCancel:=$obRec.amountCancel
//[Order]amountForceValue:=$obRec.amountForceValue
//[Order]approvedBy:=$obRec.approvedBy
//[Order]attention:=$obRec.attention
[Order:3]autoFreight:40:=$obRec.autoFreight
//[Order]balanceDueEstimated:=$obRec.balanceDueEstimated
//[Order]billToAddress1:=$obRec.billToAddress1
//[Order]billToAddress2:=$obRec.billToAddress2
//[Order]billToAttention:=$obRec.billToAttention
//[Order]billToCity:=$obRec.billToCity
//[Order]billToCompany:=$obRec.billToCompany
//[Order]billToCountry:=$obRec.billToCountry
//[Order]billToEmail:=$obRec.billToEmail
///[Order]billToFAX:=$obRec.billToFAX
//[Order]billToPhone:=$obRec.billToPhone
//[Order]billToState:=$obRec.billToState
//[Order]billToZip:=$obRec.billToZip
//[Order]ccCVS:=$obRec.ccCVS
//[Order]ccExpire:=$obRec.ccExpire
//[Order]ccNameOnCard:=$obRec.ccNameOnCard
//[Order]ccNum:=$obRec.ccNum
//[Order]ccZip:=$obRec.ccZip
//[Order]city:=$obRec.city
[Order:3]comment:33:=$obRec.comment
vOrdComment:=$obRec.comment
[Order:3]commentProcess:12:=$obRec.commentProcess
//[Order]company:=$obRec.company
//[Order]complete:=$obRec.complete
[Order:3]consignment:70:=$obRec.consignment
//[Order]contactBillTo:=$obRec.contactBillTo
//[Order]contactShipTo:=$obRec.contactShipTo
[Order:3]contractDetailTag:151:=$obRec.contractDetail
[Order:3]countItems:124:=$obRec.countItems
//[Order]countItemsBl:=$obRec.countItemsBl
//[Order]country:=$obRec.country
[Order:3]currency:69:=$obRec.currency
//[Order]customerID:=$obRec.customerID
//[Order]customerID2nd:=$obRec.customerID2nd
//[Order]customerPO:=$obRec.customerPO
//[Order]dateCancel:=$obRec.dateCancel
//[Order]dateInvoiceComp:=$obRec.dateInvoiceComp
////[Order]dateNeeded:=$obRec.dateNeeded
//[Order]dateOrdered:=$obRec.dateOrdered
//[Order]datePrinted:=$obRec.datePrinted
//[Order]dateReceived:=$obRec.dateReceived
//[Order]dateShipOn:=$obRec.dateShipOn
//[Order]dateVerified:=$obRec.dateVerified
[Order:3]discountPerCent:135:=$obRec.discountPerCent
[Order:3]divisionMfr:84:=$obRec.division
[Order:3]division:48:=$obRec.division
[Order:3]docReference:65:=$obRec.docReference
[Order:3]docType:64:=$obRec.docType
//[Order]dtProdCompl:=$obRec.dtProdCompl
//[Order]dtProdRelease:=$obRec.dtProdRelease
//[Order]email:=$obRec.email
//[Order]emailVerified:=$obRec.emailVerified
//[Order]eventLogid:=$obRec.eventLogid
[Order:3]exchangePrec:77:=$obRec.exchangePrec
[Order:3]exchangeRate:68:=$obRec.exchangeRate
//[Order]fax:=$obRec.fax
[Order:3]phoneCell:156:=$obRec.Field_156
[Order:3]flow:134:=$obRec.flow
[Order:3]fob:45:=$obRec.fob
//[Order]grossMargin:=$obRec.grossMargin
//[Order]id:=$obRec.id
//[Order]idContactBill:=$obRec.idContactBill
//[Order]idContactShip:=$obRec.idContactShip
//[Order]idCustomer:=$obRec.idCustomer
//[Order]ideSyncRecord:=$obRec.ideSyncRecord
//[Order]idNameAlt:=$obRec.idNameAlt
//[Order]idNumTask:=$obRec.idNumTask
[Order:3]deleteText:145:=$obRec.keyText
//[Order]labelCount:=$obRec.labelCount
//[Order]lat:=$obRec.lat
[Order:3]lineCount:35:=$obRec.lineCount
//[Order]lng:=$obRec.lng
[Order:3]metrics:146:=New object:C1471
If ($obRec.metrics#Null:C1517)
	[Order:3]metrics:146:=$obRec.metrics
End if 
[Order:3]mfrID:52:=$obRec.mfrID
[Order:3]mfrName:91:=$obRec.mfrName
//[Order]mfrOrdNum:=$obRec.mfrOrdNum
[Order:3]obCustomer:102:=New object:C1471
If ($obRec.obCustomer#Null:C1517)
	[Order:3]obCustomer:102:=$obRec.obCustomer
End if 
[Order:3]obExchange:148:=New object:C1471
If ($obRec.obForeign#Null:C1517)
	[Order:3]obExchange:148:=$obRec.obForeign
End if 
[Order:3]obForeign:143:=New object:C1471
If ($obRec.obForeign#Null:C1517)
	[Order:3]obForeign:143:=$obRec.obForeign
End if 
[Order:3]obGeneral:147:=New object:C1471
If ($obRec.obGeneral#Null:C1517)
	[Order:3]obGeneral:147:=$obRec.obGeneral
End if 
If ([Order:3]obGeneral:147.clone=Null:C1517)
	[Order:3]obGeneral:147.clone:=New object:C1471
End if 
[Order:3]obGeneral:147.clone.cloneType:=$obRec.profile2
[Order:3]obGeneral:147.clone.parent:=$viParentNum


[Order:3]objective:142:=New object:C1471
If ($obRec.objective#Null:C1517)
	[Order:3]objective:142:=$obRec.objective
End if 
[Order:3]obSync:137:=New object:C1471
If ($obRec.obSync#Null:C1517)
	[Order:3]obSync:137:=$obRec.obSync
End if 
//[Order]orderedBy:=$obRec.orderedBy
//[Order]orderNum:=$obRec.orderNum
//[Order]phone:=$obRec.phone
[Order:3]primaryForm:111:=$obRec.primaryForm
[Order:3]priority:129:=$obRec.priority
[Order:3]profile1:61:=$obRec.profile1
[Order:3]profile2:62:=$obRec.profile2
[Order:3]profile3:63:=$obRec.profile3
[Order:3]profile4:103:=$obRec.profile4
[Order:3]profile5:104:=$obRec.profile5
[Order:3]profile6:105:=$obRec.profile6
[Order:3]projectNum:50:=$obRec.idNumProject
//[Order]proposalNum:=$obRec.proposalNum
//[Order]remotecustomerID:=$obRec.remotecustomerID
//[Order]remoteid:=$obRec.remoteid
//[Order]remoteRecordID:=$obRec.remoteRecordID
//[Order]repCommission:=$obRec.repCommission
[Order:3]repID:8:=$obRec.repID
//[Order]salesCommission:=$obRec.salesCommission
[Order:3]salesNameID:10:=Current user:C182
//[Order]salesTax:=$obRec.salesTax
[Order:3]sector:138:=$obRec.sector
//[Order]shipAdjustments:=$obRec.shipAdjustments
//[Order]shipFreightCost:=$obRec.shipFreightCost
[Order:3]shipInstruct:46:=$obRec.shipInstruct
//[Order]shipMiscCosts:=$obRec.shipMiscCosts
//[Order]shipPartial:=$obRec.shipPartial
//[Order]shipTotal:=$obRec.shipTotal
[Order:3]shipVia:13:=$obRec.shipVia
[Order:3]siteID:106:=$obRec.siteID
//[Order]state:=$obRec.state
[Order:3]status:59:=""
[Order:3]takenBy:36:=Current user:C182
//[Order]taxExemptid:=$obRec.taxExemptid
[Order:3]taxJuris:43:=$obRec.taxJuris
//[Order]taxOnCost:=$obRec.taxOnCost
[Order:3]taxRate:29:=$obRec.taxRate
//[Order]taxTotal:=$obRec.taxTotal
//[Order]tendered:=$obRec.tendered
//[Order]tenderedChange:=$obRec.tenderedChange
[Order:3]terms:23:=$obRec.terms
//[Order]timeOrdered:=$obRec.timeOrdered
//[Order]timesPrinted:=$obRec.timesPrinted
//[Order]total:=$obRec.total
//[Order]totalCost:=$obRec.totalCost
//[Order]totalMaterials:=$obRec.totalMaterials
//[Order]totalTime:=$obRec.totalTime
//[Order]totalWkOrds:=$obRec.totalWkOrds
[Order:3]typeSale:22:=$obRec.typeSale
[Order:3]upsBillingOption:89:=$obRec.upsBillingOption
[Order:3]upsInsureShipping:128:=$obRec.upsInsureShipping
//[Order]upsReceiverAcct:=$obRec.upsReceiverAcct
//[Order]upsResidential:=$obRec.upsResidential
//[Order]weightEstimate:=$obRec.weightEstimate
[Order:3]workOrderClass:110:=$obRec.workOrderClass
//[Order]zip:=$obRec.zip
//[Order]zone:=$obRec.zone