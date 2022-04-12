//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/02/21, 22:47:22
// ----------------------------------------------------
// Method: WCapi_ParseProposalLines
// Description
// 
// Parameters
// ----------------------------------------------------


<>vbPriortyToDiscount:=True:C214
var $trackChange_b : Boolean
var $vtChangeFlag : Text
$vtChangeFlag:=String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178)

$vtUUIDKey:=WCapi_GetParameter("id")
C_OBJECT:C1216($voRecPrimary)
$voRecPrimary:=ds:C1482.Proposal.query("id= "+$vtUUIDKey).first()
If ($voRecPrimary=Null:C1517)
	vResponse:="Error: No Proposal Record for "+$vtUUIDKey
Else 
	C_REAL:C285($vrPriceOrig; $vrDiscountOrg; $vrPriceDiscounOrig)
	C_REAL:C285($vrQtyChange; $vrPriceChange; $vrDiscountChange)
	C_OBJECT:C1216($voExistingLine; $voSelLines; $obPayload)
	C_LONGINT:C283($cntLines; $viMatched)
	$obPayload:=voState.request.parameters
	$cntLines:=$obPayload.lines.length
	For each ($voIncomingLine; $obPayload.lines)
		$vrPriceChange:=0
		$vrQtyChange:=0
		$vrDiscountChange:=0
		
		If ($voIncomingLine.id=Null:C1517)  // new line
			
			$voExistingLine:=ds:C1482.ProposalLine.new()
			$voExistingLine.proposalNum:=$voRecPrimary.proposalNum
			$voExistingLine.customerID:=$voRecPrimary.customerID
			$voExistingLine.obGeneral:=New object:C1471
			$voExistingLine.obGeneral.change:=New object:C1471
			$voExistingLine.obGeneral.change[$vtChangeFlag]:=New object:C1471("source"; "Added from web"; "userName"; voState.user.wcc.userName)
			
			
			
			$voExistingLine.itemNum:=$voIncomingLine.itemNum
			$voExistingLine.description:=$voIncomingLine.description
			$itemRec_ent:=ds:C1482.Item.query("itemNum = 1:"; $voExistingLine.itemNum).first()
			If ($itemRec_ent#Null:C1517)
				/////  IvcLnLoadRec
				// Bug: Price should show in item list and come from
				$voExistingLine.unitPrice:=$itemRec_ent.priceA
				
				
				$voExistingLine.printNot:=$itemRec_ent.printNot
				$voExistingLine.altItem:=$itemRec_ent.mfrItemNum
				$voExistingLine.location:=$itemRec_ent.location
				$voExistingLine.unitofMeasure:=$itemRec_ent.unitOfMeasure
				$voExistingLine.unitCost:=$itemRec_ent.costAverage*Num:C11($itemRec_ent.type#"Bulk")*$d_rate
				$voExistingLine.unitWt:=$itemRec_ent.weightAverage
				$voExistingLine.qtyBackLogged:=$itemRec_ent.qtyOnHand-$itemRec_ent.qtyOnSalesOrder
				Case of 
					: (($itemRec_ent.taxID="NoTax") | ($itemRec_ent.taxID="No Tax"))
						$voExistingLine.taxJuris:="NoTax"  //|(Record number($itemRec_ent.)=-1))&doTax)
					: ($itemRec_ent.taxID="")
						$voExistingLine.taxJuris:="Tax"
					Else 
						$voExistingLine.taxJuris:=$itemRec_ent.taxID  //|(Record number($itemRec_ent.)=-1))&doTax)
				End case 
				//If ($itemRec_ent.useQtyPriceBrks>0)
				//aiPQDIR{$1}:=Record number($itemRec_ent.)  //record num if use price breaks
				//Else 
				//aiPQDIR{$1}:=-1
				//End if 
			End if 
			
			//   IvcLnLoadRec
			//  OrdLineCreateFromInvoice
			
			
			
			
			
		Else 
			$voExistingLine:=ds:C1482.ProposalLine.query("id = :1"; $voIncomingLine.id).first()
			// assure they are not null
			If ($voExistingLine.obGeneral=Null:C1517)
				$voExistingLine.obGeneral:=New object:C1471
			End if 
			If ($voExistingLine.obGeneral.change=Null:C1517)
				$voExistingLine.obGeneral.change:=New object:C1471
			End if 
			
			// id who is changing
			$voExistingLine.obGeneral.change[$vtChangeFlag]:=New object:C1471
			$voExistingLine.obGeneral.change[$vtChangeFlag].userName:=voState.user.wcc.userName
			
			// log $ changes
			$trackChange_b:=False:C215
			If ($voIncomingLine.discount#$voExistingLine.discount)
				$trackChange_b:=True:C214
			End if 
			If ($voIncomingLine.unitPrice#$voExistingLine.unitPrice)
				$trackChange_b:=True:C214
			End if 
			If ($voIncomingLine.qtyChange#Null:C1517)
				$trackChange_b:=True:C214
			End if 
			If ($trackChange_b)
				$voExistingLine.obGeneral.change[$vtChangeFlag].old:=New object:C1471("price"; $voExistingLine.discountedPrice; "qty"; $voExistingLine.qty; "discount"; $voExistingLine.discount)
				$voExistingLine.obGeneral.change[$vtChangeFlag].new:=New object:C1471("price"; $voIncomingLine.discountedPrice; "qty"; $voIncomingLine.qtyChange; "discount"; $voIncomingLine.discount)
				$voExistingLine.complete:=False:C215
			End if 
			
			
			// apply allowed changes
			For each ($value; $voIncomingLine)
				Case of 
					: ($value="ParentProposal")
						//do not allow relations to be automatic yet
						// sets the proposalNum to null
					: ($value="proposalNum")
						// restricted
					: (($value="id") | ($value="proposalNum") | ($value="idNum") | ($value="customerID"))
						// restricted
					: ($value="itemNum")
						// restricted
					Else 
						$voExistingLine[$value]:=$voIncomingLine[$value]
				End case 
			End for each 
			
			If ($voIncomingLine.qtyChange#Null:C1517)  // must change after update
				$voExistingLine.qty:=$voIncomingLine.qtyChange
			End if 
			
			If (False:C215)  // should already be done
				$voExistingLine.qty:=$voIncomingLine.qtyChange
				$voIncomingLine.unitPrice:=$voExistingLine.unitPrice
				$voExistingLine.discount:=$voExistingLine.discount
				
				// pricing should already be in place
				// Get Item data
				var $itemRec_ent : Object
				If ($voExistingLine.itemNum="zzz@")
					$vbDoLine:=True:C214
				Else 
					$itemRec_ent:=ds:C1482.Item.query("itemNum = 1:"; $voExistingLine.itemNum).first()
					If ($itemRec_ent#Null:C1517)
						// get the base price point
					End if 
				End if 
			End if 
			
			$voExistingLine.discountedPrice:=DiscountApply($voExistingLine.unitPrice; $voExistingLine.discount; 2)
			
			
		End if 
		
		// process qty and price changes
		// add commissions  full dORDA
		$voExistingLine.extendedPrice:=$voExistingLine.qty*$voExistingLine.discountedPrice
		$voExistingLine.extendedCost:=$voExistingLine.qty*$voExistingLine.unitCost
		$voExistingLine.save()
		
	End for each 
	
	$voRecPrimary.save()
	
	booAccept:=True:C214
	
	// handle calculations using existing method
	// dORDA
	ParseProposalRecord($voRecPrimary.proposalNum)
	
	// reload the entity
	$voRecPrimary:=ds:C1482.Proposal.query("id= "+$vtUUIDKey).first()
	
	//get the lines
	WCapiTask_GetLines
	
	// package the response of lines and primary
	C_OBJECT:C1216($obOutbound)
	$obOutbound:=New object:C1471
	$obOutbound.lines:=JSON Parse:C1218(vResponse)
	$obOutbound.primary:=New object:C1471
	// add more such as unpaid balance
	$obOutbound.primary.total:=$voRecPrimary.total
	$obOutbound.primary.amount:=$voRecPrimary.amount
	$obOutbound.primary.salesTax:=$voRecPrimary.salesTax
	$obOutbound.primary.shipTotal:=$voRecPrimary.shipTotal
	$obOutbound.primary.sendStatus:="Records saved"
	
	$obOutbound.errors:=voState.errors
	
	vResponse:=JSON Stringify:C1217($obOutbound)
	
	
End if 