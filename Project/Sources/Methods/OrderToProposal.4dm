//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/22/18, 14:45:39
// ----------------------------------------------------
// Method: OrderToProposal
// Description
// 
//
// Parameters
// ----------------------------------------------------

CONFIRM:C162("Create a Proposal based on Order "+String:C10([Order:3]idNum:2))

If (OK=1)
	
	CREATE RECORD:C68([Proposal:42])
	
	[Proposal:42]idNum:5:=CounterNew(->[Proposal:42])
	//
	//Proposal_FillAddress("Order")
	//
	[Proposal:42]addressBillTo:71:=[Order:3]addressBillTo:71
	[Proposal:42]addressShipFrom:72:=[Order:3]addressShipFrom:72
	[Proposal:42]adSource:47:=[Order:3]adSource:41
	[Proposal:42]alertMessage:65:=[Order:3]alertMessage:80
	[Proposal:42]amount:26:=[Order:3]amount:24
	[Proposal:42]amountForceValue:81:=[Order:3]amountForceValue:112
	[Proposal:42]attention:37:=[Order:3]attention:44
	[Proposal:42]shipAuto:38:=[Order:3]shipAuto:40
	[Proposal:42]bill2Company:57:=[Order:3]billToCompany:76
	
	[Proposal:42]comment:36:=[Order:3]comment:33
	[Proposal:42]commentProcess:64:=[Order:3]commentProcess:12
	
	[Proposal:42]complete:56:=False:C215
	[Proposal:42]contactBillTo:73:=[Order:3]contactBillTo:87
	[Proposal:42]contactShipTo:63:=[Order:3]contactShipTo:78
	[Proposal:42]countItems:84:=[Order:3]countItems:124
	[Proposal:42]countItemsBl:85:=[Order:3]countItemsBl:123
	
	[Proposal:42]currency:55:=[Order:3]currency:69
	[Proposal:42]customerID:1:=[Order:3]customerID:1
	[Proposal:42]dateExpected:42:=Current date:C33+3
	[Proposal:42]dateNeeded:4:=[Order:3]dateNeeded:5
	[Proposal:42]dateOrdered:66:=[Order:3]dateDocument:4
	[Proposal:42]dateDocument:3:=Current date:C33
	//[Proposal]DaysLeadTime:=[Order]DaysLeadTime
	//[Proposal]DaysValidFor:=[Order]DaysValidFor
	[Proposal:42]division:69:=[Order:3]division:48
	[Proposal:42]docReference:50:=[Order:3]docReference:65
	[Proposal:42]docType:49:=[Order:3]docType:64
	[Proposal:42]lat:46:=[Order:3]lat:144
	[Proposal:42]lng:78:=[Order:3]lng:34
	[Proposal:42]email:68:=[Order:3]email:82
	[Proposal:42]emailVerified:86:=[Order:3]emailVerified:127
	[Proposal:42]exchangePrec:59:=[Order:3]exchangePrec:77
	[Proposal:42]exchangeRate:54:=[Order:3]exchangeRate:68
	[Proposal:42]fax:67:=[Order:3]fax:81
	[Proposal:42]fob:34:=[Order:3]fob:45
	[Proposal:42]grossMargin:41:=[Order:3]grossMargin:47
	[Proposal:42]inquiryCode:6:=[Order:3]customerPO:3
	[Proposal:42]lineCount:48:=[Order:3]lineCount:35
	[Proposal:42]phone:24:=[Order:3]phone:67
	//[Proposal]Picture1:=[Order]Picture1
	[Proposal:42]primaryForm:80:=[Order:3]primaryForm:111
	[Proposal:42]probability:43:=100
	[Proposal:42]profile1:51:=[Order:3]profile1:61
	[Proposal:42]profile2:52:=[Order:3]profile2:62
	[Proposal:42]profile3:53:=[Order:3]profile3:63
	[Proposal:42]profile4:74:=[Order:3]profile4:103
	[Proposal:42]profile5:75:=[Order:3]profile5:104
	[Proposal:42]profile6:76:=[Order:3]profile6:105
	[Proposal:42]idNumProject:22:=[Order:3]projectNum:50
	[Proposal:42]repCommission:8:=[Order:3]repCommission:9
	[Proposal:42]repID:7:=[Order:3]repID:8
	[Proposal:42]requestedBy:62:=[Order:3]orderedBy:66
	[Proposal:42]salesCommission:10:=[Order:3]salesCommission:11
	[Proposal:42]salesNameID:9:=[Order:3]salesNameID:10
	[Proposal:42]idNumOrder:60:=[Order:3]idNum:2
	[Proposal:42]salesTax:27:=[Order:3]salesTax:28
	[Proposal:42]sector:88:=[Order:3]sector:138
	[Proposal:42]shipAdjustments:28:=[Order:3]shipAdjustments:26
	[Proposal:42]shipFreightCost:30:=[Order:3]shipFreightCost:38
	[Proposal:42]shipInstruct:35:=[Order:3]shipInstruct:46
	[Proposal:42]shipMiscCosts:29:=[Order:3]shipMiscCosts:25
	[Proposal:42]shipPartial:82:=[Order:3]shipPartial:121
	[Proposal:42]shipTotal:31:=[Order:3]shipTotal:30
	[Proposal:42]shipVia:18:=[Order:3]shipVia:13
	[Proposal:42]siteID:77:=[Order:3]siteID:106
	[Proposal:42]status:2:=[Order:3]status:59
	[Proposal:42]takenBy:61:=[Order:3]takenBy:36
	[Proposal:42]idNumTask:70:=[Order:3]idNumTask:85
	[Proposal:42]taxCost:25:=[Order:3]taxOnCost:109
	[Proposal:42]taxExemptid:83:=[Order:3]taxExemptid:122
	[Proposal:42]taxJuris:33:=[Order:3]taxJuris:43
	[Proposal:42]taxOnCost:79:=[Order:3]taxOnCost:109
	[Proposal:42]terms:21:=[Order:3]terms:23
	[Proposal:42]total:32:=[Order:3]total:27
	[Proposal:42]totalCost:23:=[Order:3]totalCost:42
	[Proposal:42]typeSale:20:=[Order:3]typeSale:22
	//[Proposal]id:=[Order]id  // auto assign
	[Proposal:42]weightEstimate:45:=[Order:3]weightEstimate:49
	
	[Proposal:42]zone:19:=[Order:3]zone:14
	SAVE RECORD:C53([Proposal:42])
	
	QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
	FIRST RECORD:C50([OrderLine:49])
	For ($vi1; 1; Records in selection:C76([OrderLine:49]))
		
		CREATE RECORD:C68([ProposalLine:43])
		
		[ProposalLine:43]itemNumAlt:34:=[OrderLine:49]itemNumAlt:31
		[ProposalLine:43]calculateLine:20:=True:C214
		[ProposalLine:43]comment:37:=[OrderLine:49]comment:44
		[ProposalLine:43]commRateRep:27:=[OrderLine:49]commRateRep:18
		[ProposalLine:43]commRateSales:21:=[OrderLine:49]commRateSales:29
		[ProposalLine:43]commRep:28:=[OrderLine:49]commRep:16
		[ProposalLine:43]commSales:29:=[OrderLine:49]commSales:17
		[ProposalLine:43]complete:35:=False:C215
		[ProposalLine:43]costFreight:11:=0
		[ProposalLine:43]costTaxable:6:=False:C215
		[ProposalLine:43]customerID:42:=[OrderLine:49]customerID:2
		[ProposalLine:43]dateExpected:41:=Current date:C33+3
		[ProposalLine:43]description:4:=[OrderLine:49]description:5
		[ProposalLine:43]discount:17:=[OrderLine:49]discount:10
		[ProposalLine:43]discountedPrice:56:=[OrderLine:49]discountedPrice:64
		[ProposalLine:43]divisionNum:50:=[OrderLine:49]divisionNum:49
		[ProposalLine:43]dtLastSync:57:=[OrderLine:49]dtLastSync:66
		[ProposalLine:43]extendedCost:8:=[OrderLine:49]extendedCost:13
		[ProposalLine:43]extendedPrice:16:=[OrderLine:49]extendedPrice:11
		[ProposalLine:43]extendedWt:19:=[OrderLine:49]extendedWt:21
		[ProposalLine:43]flag1:23:=""
		[ProposalLine:43]flag2:24:=""
		[ProposalLine:43]itemNum:2:=[OrderLine:49]itemNum:4
		[ProposalLine:43]itemProfile1:46:=[OrderLine:49]profile1:32
		[ProposalLine:43]itemProfile2:47:=[OrderLine:49]profile2:33
		//[ProposalLine]obHistory:=[OrderLine]profile3
		//[ProposalLine]obItem:=[OrderLine]profile4
		[ProposalLine:43]itemType:45:=[OrderLine:49]typeItem:24
		//[ProposalLine]Leadtime:=[OrderLine]Leadtime
		[ProposalLine:43]lineNum:43:=[OrderLine:49]lineNum:3
		[ProposalLine:43]location:12:=[OrderLine:49]location:22
		[ProposalLine:43]locationBin:55:=[OrderLine:49]locationBin:57
		//[ProposalLine]Note:=[OrderLine]Note
		[ProposalLine:43]printNot:54:=[OrderLine:49]printNot:56
		[ProposalLine:43]probability:9:=100
		[ProposalLine:43]producedBy:36:=[OrderLine:49]producedBy:43
		[ProposalLine:43]profile1:38:=[OrderLine:49]profile1:32
		[ProposalLine:43]profile2:39:=[OrderLine:49]profile2:33
		[ProposalLine:43]profile3:40:=[OrderLine:49]profile3:34
		[ProposalLine:43]idNumProposal:1:=[Proposal:42]idNum:5
		[ProposalLine:43]qty:3:=[OrderLine:49]qty:6
		[ProposalLine:43]qtyOpen:51:=[OrderLine:49]qty:6  // new proposal full amount is open 
		[ProposalLine:43]salesTax:18:=[OrderLine:49]salesTax:15
		[ProposalLine:43]unitofMeasure:13:=[OrderLine:49]unitofMeasure:19
		[ProposalLine:43]seq:33:=[OrderLine:49]seq:30
		[ProposalLine:43]serialized:31:=[OrderLine:49]serialRc:27  // not suer if these are the same
		[ProposalLine:43]status:30:=[OrderLine:49]status:58
		[ProposalLine:43]taxCost:53:=[OrderLine:49]taxCost:55
		[ProposalLine:43]taxJuris:14:=[OrderLine:49]taxJuris:14
		[ProposalLine:43]typeSale:32:=[OrderLine:49]typeSale:28
		//[ProposalLine]UniqueID:=[OrderLine]UniqueID // Auto Increment
		[ProposalLine:43]unitCost:7:=[OrderLine:49]unitCost:12
		[ProposalLine:43]unitPrice:15:=[OrderLine:49]unitPrice:9
		[ProposalLine:43]unitWeight:22:=[OrderLine:49]unitWt:20
		//[ProposalLine]id:=[OrderLine]id  // auto assigned
		//[ProposalLine]ValueAddedTax:=[OrderLine]
		[ProposalLine:43]vendorID:44:=[OrderLine:49]vendorID:42
		SAVE RECORD:C53([ProposalLine:43])
		NEXT RECORD:C51([OrderLine:49])
	End for 
	UNLOAD RECORD:C212([ProposalLine:43])
	
	If ([Order:3]proposalNum:79=0)
		[Order:3]proposalNum:79:=[Proposal:42]idNum:5
	End if 
	
	ProcessTableOpen(Table:C252(->[Proposal:42]); ""; "")
	
End if 
