//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/01/19, 15:49:06
// ----------------------------------------------------
// Method: WC_AjaxItemOrder
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305(<>vbItemAdds)
C_LONGINT:C283($1; $socket)
C_POINTER:C301($2)

C_LONGINT:C283($err; $pTest; $vlBeenHere; vlBeenHere)
C_TEXT:C284($itemExtend1; $itemExtend2; $itemExtend3; $itemExtend4; $itemExtend5)
C_TEXT:C284($itemExtend6; $itemExtend7; $itemExtend8; $itemExtend9; $itemExtend10)
C_TEXT:C284($pageDo)
//
C_LONGINT:C283($p; $theFile; $theField; $testFile; $setUseBasePrice)
READ ONLY:C145([Customer:2])
READ ONLY:C145([Rep:8])
READ ONLY:C145([Contact:13])
READ ONLY:C145([zzzLead:48])
READ ONLY:C145([Vendor:38])
//
vResponse:=""  // clear response



If ([EventLog:75]typeSale:47="")
	[EventLog:75]typeSale:47:=[Customer:2]typeSale:18
	SAVE RECORD:C53([EventLog:75])
End if 
$typeSaleDoc:=[EventLog:75]typeSale:47
vUseBase:=SetPricePoint($typeSaleDoc)
If (vWccSecurity>0)
	$typeSaleDoc:=WCapi_GetParameter("TypeSaleDoc"; "")
	If ($typeSaleDoc#"")
		vUseBase:=SetPricePoint($typeSaleDoc)
	End if 
End if 
$setUseBasePrice:=vUseBase

If (False:C215)  // ### bj ### 20190101_1557 not needed
	[EventLog:75]qty:6:=0
	[EventLog:75]value:7:=0
	[EventLog:75]beenHere:13:=DateTime_Enter
	vBeenHere:=[EventLog:75]beenHere:13
	vlBeenHere:=[EventLog:75]beenHere:13
End if 
$err:=0
// $mySort:=""   // ### bj ### 20190101_1557 all sorting should be done on pages
//  REDUCE SELECTION([WebTempRec];0)    // ### bj ### 20190101_1600 should already be empty
//  REDUCE SELECTION([Item];0)
C_TEXT:C284($itemNum; $strWebTempRec; $itemNum; $specialDiscount; $typeSale)
$itemNum:=WCapi_GetParameter("ItemNum"; "")

$strWebTempRec:=WCapi_GetParameter("LineRecordNum"; "")
C_LONGINT:C283($lineRecNum)
$lineRecNum:=Num:C11($strWebTempRec)

pvQtyOrd:=WCapi_GetParameter("qtyOrdered"; "")
pQtyOrdered:=Num:C11(pvQtyOrd)

C_TEXT:C284($lnComment)
$lnComment:=WCapi_GetParameter("LnComment"; "")

If ($lineRecNum>0)  // ignor the zeroth record, to hard to sort a ""
	GOTO RECORD:C242([WebTempRec:101]; $lineRecNum)
Else   // check to see if there is such a webTempRec for this item in this shopping cart
	QUERY:C277([WebTempRec:101]; [WebTempRec:101]itemNum:3=$itemNum; *)
	QUERY:C277([WebTempRec:101];  & ; [WebTempRec:101]idEventLog:1=[EventLog:75]idNum:5; *)
	QUERY:C277([WebTempRec:101];  & ; [WebTempRec:101]posted:5=False:C215)
End if 

C_REAL:C285($qtyWT; $bonusWT; $valueWT)
C_REAL:C285($qtyEL; $countEL; $valueEL; $valueBonusEL)
$qtyEL:=[EventLog:75]qty:6
$valueEL:=[EventLog:75]value:7
$valueBonusEL:=[EventLog:75]valueBonus:17

// will be zero if there is not existing record
$qtyWT:=[WebTempRec:101]qtyOrdered:4
$valueWT:=[WebTempRec:101]extendedPrice:12
$bonusWT:=[WebTempRec:101]bonus:18


If (pQtyOrdered<=0)  // release the WebTempRecs
	[EventLog:75]qty:6:=$qtyEL-$qtyWT
	[EventLog:75]value:7:=$valueEL-$valueWT
	[EventLog:75]valueBonus:17:=$valueBonusEL-$bonusWT
	If (Record number:C243([WebTempRec:101])>-1)
		[WebTempRec:101]qtyOrdered:4:=0
		[WebTempRec:101]extendedPrice:12:=0
		[WebTempRec:101]bonus:18:=0
		[WebTempRec:101]posted:5:=True:C214
		[WebTempRec:101]dtUpdated:17:=DateTime_Enter
		[WebTempRec:101]comment:13:=[WebTempRec:101]comment:13+"\r"+"ItemZeroed from "+String:C10($qtyWT)
		SAVE RECORD:C53([WebTempRec:101])
	End if 
	pQtyOrdered:=0
Else 
	
	// need to check how this works
	If (<>vbItemExtender=1)
		C_TEXT:C284($extend1; $extend2; $extend3; $extend4; $extend5; $extend6; $itemExtender)
		$itemExtender:=""
		$extend1:=WCapi_GetParameter("extend1"; "")
		If ($extend1#"")
			$itemExtender:=$itemExtender+$extend1
			$extend2:=WCapi_GetParameter("extend2"; "")
			If ($extend2#"")
				$itemExtender:=$itemExtender+$extend2
				$extend3:=WCapi_GetParameter("extend3"; "")
				If ($extend3#"")
					$itemExtender:=$itemExtender+$extend3
					$extend4:=WCapi_GetParameter("extend4"; "")
					If ($extend4#"")
						$itemExtender:=$itemExtender+$extend4
						$extend5:=WCapi_GetParameter("extend5"; "")
						If ($extend5#"")
							$itemExtender:=$itemExtender+$extend5
							$extend6:=WCapi_GetParameter("extend6"; "")
							If ($extend6#"")
								$itemExtender:=$itemExtender+$extend6
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
		$itemNum:=$itemNum+$itemExtender
	End if 
	// need to check how this works
	If (<>vbItemAdds)  // need to check how this works
		// ### bj ### 20190101_1855
		C_TEXT:C284($add1; $add2; $add3; $add4)
		$add1:=WCapi_GetParameter("add1"; "")
		If ($add1#"")
			$add2:=WCapi_GetParameter("add2"; "")
			If ($add2#"")
				$add3:=WCapi_GetParameter("add3"; "")
				If ($add3#"")
					$add4:=WCapi_GetParameter("add4"; "")
				End if 
			End if 
			// ### bj ### 20190101_1818  cannot take time to sort this out at this time
			// this is antiquated
			Http_ItemAdds(pvItemNum; "Read Arrays"; pQtyOrdered; vUseBase+9)  //-1)
		End if 
	End if 
	
	// final $itemNum
	QUERY:C277([Item:4]; [Item:4]itemNum:1=$itemNum)  // should not be able to send in a non-existing item (risk with Extends)
	If (Records in selection:C76([Item:4])#1)
		vResponse:="Error: Item not found: "+$itemNum
	Else 
		
		// there is a valid item number
		If (Records in selection:C76([WebTempRec:101])=0)
			WebTempRecCreate
		End if 
		pvItemNum:=[WebTempRec:101]itemNum:3
		$specialDiscount:=""
		$typeSale:=""
		$discountString:="0"
		If (vWccSecurity>0)  // only valid if employee or rep
			//  $specialDiscount:=WCapi_GetParameter ("SpecialDiscount";"") not used
			$typeSale:=WCapi_GetParameter("TypeSaleLine"; "")
			$discountString:=WCapi_GetParameter("Discount"; "")
		End if 
		C_LONGINT:C283($pMore; $lenFound; $noPricing)
		$noPricing:=Num:C11(WCapi_GetParameter("noPricing"; ""; 1))
		
		If ($typeSale#"")
			If ([WebTempRec:101]typeSale:29#"")
				$typeSale:=[WebTempRec:101]typeSale:29
			Else 
				$typeSale:=[EventLog:75]typeSale:47
			End if 
		End if 
		$typeSaleLine:=$typeSale
		
		C_REAL:C285(pDiscnt)
		C_REAL:C285(vUseBase)
		vUseBase:=SetPricePoint($typeSale)
		pDiscnt:=Num:C11($discountString)
		
		If (<>viMatrixPricing>0)  // Modified by: williamjames (110328)
			QUERY:C277([PriceMatrix:105]; [PriceMatrix:105]typeSale:3=[WebTempRec:101]typeSale:29; *)
			QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]itemNum:11=[Item:4]itemNum:1; *)
			QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]quantityMin:4<=pQtyOrdered; *)  //finding a record where Min is less than qty
			QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]quantityMax:5>=pQtyOrdered)  //finding a record where Max is greater than qty
			Case of 
				: (Records in selection:C76([PriceMatrix:105])=1)
					pUnitPrice:=[PriceMatrix:105]price:6
					pBasePrice:=pUnitPrice
					pDiscnt:=0
				: ((vWccPrimeRec>-1) & ($typeSaleLine="") & ($typeSaleDoc=""))
					pBasePrice:=[WebTempRec:101]unitPrice:11
					pUnitPrice:=[WebTempRec:101]discountedPrice:10
					pDiscnt:=[WebTempRec:101]discount:34
				Else 
					vUseBase:=SetPricePoint(vUsePricePoint)
					pBasePrice:=Field:C253(4; vUseBase)->
					pUnitPrice:=DiscountApply(pBasePrice; pDiscnt; <>tcDecimalUP)+addDiscount
			End case 
		Else 
			vUseBase:=SetPricePoint(vUsePricePoint)
			// ### jwm ### 20150720_1847 QQQQQQQQ
			pDiscnt:=OrdSetDiscount(pQtyOrdered; [WebTempRec:101]typeSale:29; [WebTempRec:101]itemNum:3)  // ### jwm ### 20150414_1233
			pBasePrice:=Field:C253(4; vUseBase)->
			pUnitPrice:=DiscountApply(pBasePrice; pDiscnt; <>tcDecimalUP)+addDiscount
			//pUnitCost:=
		End if 
		pExtPrice:=Round:C94(pUnitPrice*pQtyOrdered; <>tcDecimalTt)
		pvQtyOrd:=String:C10(pQtyOrdered)
		pvItemNum:=[WebTempRec:101]itemNum:3
		[WebTempRec:101]typeSale:29:=$typeSaleLine
		vUsePricePoint:=[WebTempRec:101]typeSale:29  //leave it unchanged if no new instructions       
		[WebTempRec:101]qtyOrdered:4:=pQtyOrdered
		[WebTempRec:101]unitPrice:11:=pBasePrice
		[WebTempRec:101]discount:34:=pDiscnt
		[WebTempRec:101]discountedPrice:10:=pUnitPrice
		[WebTempRec:101]extendedPrice:12:=pExtPrice
		[WebTempRec:101]dtUpdated:17:=DateTime_Enter
		[WebTempRec:101]comment:13:=$lnComment
		// define at some point
		// [WebTempRec]Bonus:=0  
		
		SAVE RECORD:C53([WebTempRec:101])
		
		[EventLog:75]qty:6:=[EventLog:75]qty:6-$qtyWT+[WebTempRec:101]qtyOrdered:4
		[EventLog:75]value:7:=[EventLog:75]value:7-$valueWT+pExtPrice
		[EventLog:75]valueBonus:17:=[EventLog:75]valueBonus:17-$bonusWT+[WebTempRec:101]bonus:18
		SAVE RECORD:C53([EventLog:75])
		
		C_TEXT:C284(pvWarning)
		UNLOAD RECORD:C212([Item:4])
		
		pSumBalance:=-([Customer:2]balanceTotalExposure:104+[EventLog:75]value:7)
		//
		pvSumQuantity:=String:C10(Round:C94([EventLog:75]qty:6; 4); "###,###,##0.###,###")
		//pvSumPrice:=String(Round(Sum([WebTempRec]ExtendedPrice);<>tcDecimalTt);<>tcFormatTt)
		vText1:=pvSumQuantity
		vText2:=pvSumPrice
		pvSumBonus:=String:C10(Round:C94([EventLog:75]valueBonus:17; <>tcDecimalTt); <>tcFormatTt)
		
		
		
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		If ($jitPageOne="")
			$jitPageOne:="ShoppingCartOnerAjax.json"
		End if 
	End if 
	C_TEXT:C284($text2Send)
	If (False:C215)  // (Test path name(<>WebFolder+$jitPageOne)=1)
		$text2Send:=Document to text:C1236(<>WebFolder+$jitPageOne)
		$textFinal:=TagsToText($text2Send)
	Else 
		C_OBJECT:C1216($obSend)
		OB SET:C1220($obSend; "qtyOrdered"; 444)  // pQtyOrdered)
		OB SET:C1220($obSend; "pExtPrice"; pExtPrice)
		OB SET:C1220($obSend; "LineRecordNum"; Record number:C243([WebTempRec:101]))
		OB SET:C1220($obSend; "comment"; [WebTempRec:101]comment:13)
		$textFinal:=JSON Stringify:C1217($obSend)
		$textFinal:=JSON Stringify:C1217($textFinal)
		// $textFinal:="444"
	End if 
	//$0:=WC_SendServerResponse ($textFinal;<>WebFolder+$jitPageOne)  // ### AZM ### 20180914 USE NEW SINGLE OUTPUT METHOD
	$0:=WC_SendServerResponse($textFinal; WC_GetContentTypeFor(SuffixGet(<>WebFolder+$jitPageOne)))  // ### AZM ### 20190520 Switch to sending Content Type directly.
	//Else 
	//$jitPageOne:=""
End if 


READ WRITE:C146([Customer:2])
READ WRITE:C146([Rep:8])
READ WRITE:C146([Contact:13])
READ WRITE:C146([zzzLead:48])
READ WRITE:C146([Vendor:38])
ARRAY TEXT:C222(aMinOrderMfgID; 0)
ARRAY REAL:C219(aMinOrderValue; 0)



