//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/19/21, 01:36:26
// ----------------------------------------------------
// Method: WCapi_ParseInvoiceLines
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (False:C215)
	Repeat 
		TRACE:C157
		C_BOOLEAN:C305($vbEnd)
		$vbEnd:=MyWorking
	Until ($vbEnd)
End if 

<>vbPriortyToDiscount:=True:C214
var $trackChange_b : Boolean
var $vtChangeFlag : Text
$vtChangeFlag:=String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178)

$vtUUIDKey:=WCapi_GetParameter("id")
C_OBJECT:C1216($voRecPrimary)
$voRecPrimary:=ds:C1482.Invoice.query("id= "+$vtUUIDKey).first()
Case of 
	: ($voRecPrimary=Null:C1517)
		vResponse:="Error: No Invoice Record for "+$vtUUIDKey
		
	: ($voRecPrimary.jrnlComplete=True:C214)
		vResponse:="Error: Invoice has been Journalized and cannot be changed, "+String:C10($voRecPrimary.invoiceNum)
	Else 
		
		C_REAL:C285($vrPriceChange; $vrPriceOrig; $vrDiscountOrg; $vrPriceDiscounOrig)
		C_REAL:C285($vrQtyChange)
		C_OBJECT:C1216($voExistingLine; $voSelLines; $obPayload)
		C_LONGINT:C283($cntLines; $viMatched)
		$obPayload:=voState.request.parameters
		$cntLines:=$obPayload.lines.length
		For each ($voIncomingLine; $obPayload.lines)
			$vrIncomingDiscount:=-3.1415
			$vrIncomingDiscountPrice:=-3.1415
			$vrPrice:=$voIncomingLine.unitPrice
			
			If ($voIncomingLine.id=Null:C1517)
				$vrQtyChange:=0
				$vrPriceChange:=0
				$voExistingLine:=ds:C1482.InvoiceLine.new()
				$voExistingLine.uniqueId:=$voRecPrimary.uniqueId
				$voExistingLine.customerID:=$voRecPrimary.customerID
				$voExistingLine.obGeneral:=New object:C1471
				$voExistingLine.obGeneral.change:=New object:C1471("price"; 0; "qty"; 0)
				$voExistingLine.obGeneral.change.price:=0
				$voExistingLine.obGeneral.change.qty:=$voIncomingLine.Qty
				$voExistingLine.obGeneral.change.source:="Added from web"
				$voExistingLine.itemNum:=$vtItemNum
			Else 
				$voExistingLine:=ds:C1482.InvoiceLine.query("id = :1"; $voIncomingLine.id).first()
				$vrDiscountOrg:=$voExistingLine.discount
				$vrPriceDiscounOrig:=$voExistingLine.discountedPrice
			End if 
			
			// log the changes
			$trackChange_b:=False:C215
			If ($voIncomingLine.discount#$voExistingLine.discount)
				$vrIncomingDiscount:=$voIncomingLine.discount
				$trackChange_b:=True:C214
			End if 
			If ($voIncomingLine.discountedPrice#$voExistingLine.discountedPrice)
				$vrIncomingDiscountPrice:=$voIncomingLine.discountedPrice
				$trackChange_b:=True:C214
			End if 
			If ($voIncomingLine.qtyChange#Null:C1517)
				$trackChange_b:=True:C214
				$vrQtyChange:=$voIncomingLine.qtyChange-$voIncomingLine.qty
				
				// create a dInventory
				
			End if 
			
			// log the changes
			
			If ($voExistingLine.obGeneral=Null:C1517)
				$voExistingLine.obGeneral:=New object:C1471
			End if 
			If ($voExistingLine.obGeneral.change=Null:C1517)
				$voExistingLine.obGeneral.change:=New object:C1471
			End if 
			If ($trackChange_b)
				$voExistingLine.obGeneral.change[$vtChangeFlag]:=New object:C1471
				//$voExistingLine.obGeneral.change[$vtChangeFlag]:=New object("old"; New object; "new"; New object)
				$voExistingLine.obGeneral.change[$vtChangeFlag].old:=New object:C1471("price"; $voExistingLine.discountedPrice; "qty"; $voExistingLine.qty; "discount"; $voExistingLine.discount)
				$voExistingLine.obGeneral.change[$vtChangeFlag].new:=New object:C1471("price"; $voIncomingLine.discountedPrice; "qty"; $voIncomingLine.qtyChange; "discount"; $voIncomingLine.discount)
				// $voExistingLine.obGeneral.change[$vtChangeFlag].userName:=
			End if 
			
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
			
			
			
			// ### bj ### 20211001_1536 CC19
			For each ($value; $voIncomingLine)
				Case of 
					: ($value="ParentInvoice")
						//do not allow relations to be automatic yet
						// sets the orderNum to null
					: ($value="invoiceNum")
						// restricted
					: (($value="id") | ($value="invoiceNum") | ($value="idNum") | ($value="customerID"))
						// restricted
					: ($value="itemNum")
						// restricted
					Else 
						$voExistingLine[$value]:=$voIncomingLine[$value]
				End case 
			End for each 
			
			// process qty and price changes
			
			$voExistingLine.qty:=$voExistingLine.qty+$vrQtyChange
			
			Case of   // add price changing and catalog restrictions
				: (($vrIncomingDiscount=-3.1415) & ($vrIncomingDiscountPrice=-3.1415))
					$voExistingLine.discountedPrice:=$voExistingLine.UnitPrice
					$voExistingLine.discount:=0
				: (($vrIncomingDiscount=-3.1415) & ($vrIncomingDiscountPrice#-3.1415))
					$voExistingLine.discount:=Discount_SetDiscount($vrPrice; $vrIncomingDiscountPrice)
				: (($vrDiscount#-3.1415) & ($vrDiscountPrice#-3.1415))
					$vrIncomingDiscountPrice:=DiscountApply($vrPrice; $vrDiscount; 2)
				Else 
					
			End case 
			
			$voExistingLine.extendedPrice:=$voExistingLine.qty*$voExistingLine.discountedPrice
			$voExistingLine.extendedCost:=$voExistingLine.qty*$voExistingLine.unitCost
			$voExistingLine.save()
			
		End for each 
		
		
		booAccept:=True:C214
		// handle calculations using existing method
		// dORDA
		ParseInvoiceRecord($voRecPrimary.invoiceNum)
		$voRecPrimary:=ds:C1482.Invoice.query("id= "+$vtUUIDKey).first()
		
		//get the lines
		// tableName and UUID are already in voState
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
		
		
End case 