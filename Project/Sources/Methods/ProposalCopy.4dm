//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 05/12/21, 14:20:26
// ----------------------------------------------------
// Method: ProposalCopy
// Description
// 
//  put this into an external list of field names to be loaded and manage from there.
// Parameters
// ----------------------------------------------------
var $1; $viParentNum : Integer
C_OBJECT:C1216($obRec; $obSel)
$obRec:=ds:C1482.Proposal.query("proposalNum = :1"; $1).first()


[Proposal:42]contractDetailTag:97:=$obRec.contractDetailTag
[Proposal:42]contractDetail:92:=$obRec.contractDetail

[Proposal:42]action:96:=$obRec.action
[Proposal:42]actionBy:94:=Current user:C182
[Proposal:42]actionDate:95:=Current date:C33
[Proposal:42]actionDuration:101:=$obRec.actionDuration
[Proposal:42]actionTime:58:=Current time:C178
//[Proposal]address1:=$obRec.address1
//[Proposal]address2:=$obRec.address2
//[Proposal]addressBillTo:=$obRec.addressBillTo
[Proposal:42]addressShipFrom:72:=$obRec.addressShipFrom
[Proposal:42]adSource:47:=$obRec.adSource
[Proposal:42]alertMessage:65:=$obRec.alertMessage
[Proposal:42]amount:26:=$obRec.amount
[Proposal:42]amountForceValue:81:=$obRec.amountForceValue
//[Proposal]attention:=$obRec.attention
[Proposal]shipAuto:=$obRec.autoFreight
//[Proposal]bill2Company:=$obRec.bill2Company
//[Proposal]city:=$obRec.city
[Proposal:42]comment:36:=$obRec.comment
vOrdComment:=$obRec.comment
[Proposal:42]commentProcess:64:=$obRec.commentProcess
//[Proposal]company:=$obRec.company
//[Proposal]complete:=$obRec.complete
//[Proposal]contactBillTo:=$obRec.contactBillTo
[Proposal:42]contractDetailTag:97:=$obRec.contactConditions
//[Proposal]contactShipTo:=$obRec.contactShipTo
[Proposal:42]countItems:84:=$obRec.countItems
[Proposal:42]countItemsBl:85:=$obRec.countItemsBl
//[Proposal]country:=$obRec.country
[Proposal:42]currency:55:=$obRec.currency
//[Proposal]customerID:=$obRec.customerID
//[Proposal]customerID2nd:=$obRec.customerID2nd
//[Proposal]dateExpected:=$obRec.dateExpected
//[Proposal]dateNeeded:=$obRec.dateNeeded
//[Proposal]dateOrdered:=$obRec.dateOrdered
//[Proposal]dateProposed:=$obRec.dateProposed
[Proposal:42]daysLeadTime:40:=$obRec.daysLeadTime
[Proposal:42]daysValidFor:39:=$obRec.daysValidFor
[Proposal:42]division:69:=$obRec.division
[Proposal:42]docReference:50:=$obRec.docReference
[Proposal:42]docType:49:=$obRec.docType
[Proposal:42]dtLastSync:87:=$obRec.dtLastSync
//[Proposal]email:=$obRec.email
//[Proposal]emailVerified:=$obRec.emailVerified
[Proposal:42]exchangePrec:59:=$obRec.exchangePrec
[Proposal:42]exchangeRate:54:=$obRec.exchangeRate
//[Proposal]fax:=$obRec.fax
//[Proposal]fob:=$obRec.fob
[Proposal:42]grossMargin:41:=$obRec.grossMargin
//[Proposal]id:=$obRec.id
//[Proposal]idContactBill:=$obRec.idContactBill
//[Proposal]idContactShip:=$obRec.idContactShip
//[Proposal]idCustomer:=$obRec.idCustomer
//[Proposal]idNumTask:=$obRec.idNumTask
//[Proposal]inquiryCode:=$obRec.inquiryCode
//[Proposal]lat:=$obRec.lat
[Proposal:42]lineCount:48:=$obRec.lineCount
//[Proposal]lng:=$obRec.lng
[Proposal:42]obGeneral:93:=New object:C1471
If ($obRec.obGeneral#Null:C1517)
	[Proposal:42]obGeneral:93:=$obRec.obGeneral
End if 

If ([Proposal:42]obGeneral:93.clone=Null:C1517)
	[Proposal:42]obGeneral:93.clone:=New object:C1471
End if 
[Proposal:42]obGeneral:93.clone.cloneType:=$obRec.profile2
[Proposal:42]obGeneral:93.clone.parent:=$viParentNum

[Proposal:42]objective:91:=New object:C1471
If ($obRec.objective#Null:C1517)
	[Proposal:42]objective:91:=$obRec.objective
End if 
[Proposal:42]obSync:44:=New object:C1471
If ($obRec.objective#Null:C1517)
	[Proposal:42]obSync:44:=$obRec.obSync
End if 
//[Proposal]orderNum:=$obRec.orderNum
//[Proposal]phone:=$obRec.phone
[Proposal:42]primaryForm:80:=$obRec.primaryForm
//[Proposal]probability:=$obRec.probability
[Proposal:42]profile1:51:=$obRec.profile1
[Proposal:42]profile2:52:=$obRec.profile2
[Proposal:42]profile3:53:=$obRec.profile3
[Proposal:42]profile4:74:=$obRec.profile4
[Proposal:42]profile5:75:=$obRec.profile5
[Proposal:42]profile6:76:=$obRec.profile6
[Proposal:42]idNumProject:22:=$obRec.idNumProject
//[Proposal]proposalNum:=$obRec.proposalNum
//[Proposal]repCommission:=$obRec.repCommission
[Proposal:42]repID:7:=$obRec.repID
//[Proposal]requestedBy:=$obRec.requestedBy
//[Proposal]rs1:=$obRec.rs1
//[Proposal]salesCommission:=$obRec.salesCommission
[Proposal:42]salesNameID:9:=Current user:C182
// [Proposal]salesTax:=$obRec.salesTax
[Proposal:42]sector:88:=$obRec.sector
[Proposal:42]shipAdjustments:28:=$obRec.shipAdjustments
//[Proposal]shipFreightCost:=$obRec.shipFreightCost
[Proposal:42]shipInstruct:35:=$obRec.shipInstruct
[Proposal:42]shipMiscCosts:29:=$obRec.shipMiscCosts
[Proposal:42]shipPartial:82:=$obRec.shipPartial
//[Proposal]shipTotal:=$obRec.shipTotal
[Proposal:42]shipVia:18:=$obRec.shipVia
[Proposal:42]siteID:77:=$obRec.siteID
//[Proposal]state:=$obRec.state
[Proposal:42]status:2:=""
[Proposal:42]takenBy:61:=Current user:C182
//[Proposal]taxCost:=$obRec.taxCost
//[Proposal]taxExemptid:=$obRec.taxExemptid
[Proposal:42]taxJuris:33:=$obRec.taxJuris
//[Proposal]taxOnCost:=$obRec.taxOnCost
[Proposal:42]terms:21:=$obRec.terms
//[Proposal]total:=$obRec.total
//[Proposal]totalCost:=$obRec.totalCost
[Proposal:42]typeSale:20:=$obRec.typeSale
//[Proposal]weightEstimate:=$obRec.weightEstimate
//[Proposal]zip:=$obRec.zip
//[Proposal]zone:=$obRec.zone

