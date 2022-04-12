//%attributes = {}
//// ----------------------------------------------------
//// User name (OS): Bill James
//// Date and time: 2015-07-20T00:00:00, 12:22:05
//// ----------------------------------------------------
//// Method: Http_PostOrd2
//// Description
//// Modified: 07/20/15
//// Structure: CEv13_131005
//// 
////
//// Parameters
//// ----------------------------------------------------
//// ### jwm ### 20180822_1713 viEndUserSecurityLevel


//C_TEXT($txtPage; $txtPart; $typeSaleDoc; $typeSaleLine; $discountString; $specialDiscount)
//C_REAL($runQty; pQtyOrdered; $runPrice; pUnitPrice; pExtPrice; addDiscount; pQtyOrdered)
//C_REAL(<>vMinOrders)
//C_TEXT(vText1; vText2; vText3; vText4; vText5; vText6; vText7; vText8; vText9; vText10)
//C_LONGINT($err; $pTest; $vlBeenHere; vlBeenHere)
//C_LONGINT($1)
//C_POINTER($2)
//C_LONGINT($3)
//C_TEXT($itemExtend1; $itemExtend2; $itemExtend3; $itemExtend4; $itemExtend5)
//C_TEXT($itemExtend6; $itemExtend7; $itemExtend8; $itemExtend9; $itemExtend10)
//C_TEXT($pageDo)
////
//C_LONGINT($p; $theFile; $theField; $testFile; $setUseBasePrice)
//READ ONLY([Customer])
//READ ONLY([Rep])
//READ ONLY([Contact])
//READ ONLY([Lead])
//READ ONLY([Vendor])
////
//vResponse:=""  // clear response

//$vlBeenHere:=Num(WCapi_GetParameter("beenHere"; ""))
//If (([EventLog]beenHere=$vlBeenHere) & ($vlBeenHere#0))
//$skipNewAdd:=False
//Else 
//$skipNewAdd:=True
//End if 
//$reverseWebTemp:=WCapi_GetParameter("CartOrder"; "")

//C_BOOLEAN($createZZZ)
//C_TEXT($createZZZText)
//$reverseWebTemp:=WCapi_GetParameter("ZZZItemNums"; "")
//$createZZZ:=(($reverseWebTemp="1") | ($reverseWebTemp="t@"))
//vText9:=""

//// Modified by: William James (2014-06-16T00:00:00)
//// Contacts were not accessing the Special Discounts
//// Modified by: Bill James (2015-02-15T00:00:00 [EventLog]TypeSale not set by WCCSetEventLog2Cust or will return Aprice)
////added protection
//If ([EventLog]typeSale="")
//[EventLog]typeSale:=[Customer]typeSale
//SAVE RECORD([EventLog])
//End if 
//$typeSaleDoc:=[EventLog]typeSale
//vUseBase:=SetPricePoint($typeSaleDoc)
//If (vWccSecurity>0)
//$typeSaleDoc:=WCapi_GetParameter("TypeSaleDoc"; "")
//If ($typeSaleDoc#"")
//vUseBase:=SetPricePoint($typeSaleDoc)
//End if 
//End if 
//$setUseBasePrice:=vUseBase
////TRACE
//// ### bj ### 20181214_0724
//// [EventLog]Message:=""
//[EventLog]qty:=0
//[EventLog]value:=0
//[EventLog]beenHere:=DateTime_Enter
//vBeenHere:=[EventLog]beenHere
//vlBeenHere:=[EventLog]beenHere
//$err:=0
////

////
//ARRAY TEXT(aOItemNum; 0)
//ARRAY TEXT(aODescpt; 0)
//ARRAY REAL(aOQtyOrder; 0)
//$mySort:=""
//$mySort:=WCapi_GetParameter("_jitSort"; "")
//If ($mySort#"")
//$showLast:=Http_DoSort($mySort)
//$mySort:="&"+$mySort+"&"
//Else 
//$p:=Position("_jitSort"; $2->)
//If ($p>0)
//$showLast:=0
//$mySort:=Substring($2->; $p; 80)  //clip the sort command, get enough 
//$p:=Position(<>endTag; $mySort)  //find the end
//$mySort:=Substring($mySort; 1; $p+1)
//$showLast:=Http_DoSort($mySort)
//$mySort:="&"+$mySort+"&"
//End if 
//End if 
////TRACE
//C_LONGINT($p; $pEqual; $pEnd; $pCR; $pEndSeg)
//$endLoop:=False
////
//$sizeOfList:=Size of array(aParameterName)
////
//C_LONGINT($doitemZZZ)
//$doitemZZZ:=0
//$itemNum:=""
//$workingElement:=1
//Repeat 
//REDUCE SELECTION([WebTempRec]; 0)
//REDUCE SELECTION([Item]; 0)
//$discountString:="noUsed"  // over ride if signed in as an employee
//pDiscnt:=0
//pvAltItem:=""
//$foundLine:=Find in array(aParameterName; "LineRecordNum"; $workingElement)
//If ($foundLine<1)
//$endLoop:=True
//Else 
//$workingElement:=$foundLine+1
//$typeSaleLine:=""
//$foundNext:=Find in array(aParameterName; "LineRecordNum"; $workingElement)
//If ($foundNext=-1)
//$foundNext:=$sizeOfList
//$endLoop:=True
//End if 
////If ($foundLine+2>$sizeOfList)//not both a quantity and itemnum
////$endLoop:=True
////Else 
//vUseBase:=$setUseBasePrice  //reset in each loop
//$baseQty:=0
//$lineRecNum:=Num(aParameterValue{$foundLine})
//If ($lineRecNum>0)  //ignor the zeroeth item
//// ### bj ### 20190213_1755
//// line 281
//GOTO RECORD([WebTempRec]; $lineRecNum)
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "ItemNum"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//$itemNum:=aParameterValue{$nextValueElement}
//Else 
//$itemNum:="-1zaq"
//End if 
//pQtyOrdered:=0
//pvQtyOrd:=""
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "QtyOrdered"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//pvQtyOrd:=aParameterValue{$nextValueElement}
//End if 
//pQtyOrdered:=Num(pvQtyOrd)

//// Modified by: Bill James (2015-04-06T00:00:00 Added capabilities to have a SpecialDiscount defined for customers
//// even when not signed in as an employee

//If (pQtyOrdered>0)
//If (vWccSecurity>0)
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "TypeSaleLine"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//$typeSaleLine:=aParameterValue{$nextValueElement}
//If ($typeSaleLine#"")
//vUseBase:=SetPricePoint($typeSaleLine)
//End if 
//End if 
//Else 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "SpecialDiscount"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//$typeSaleLine:=aParameterValue{$nextValueElement}
//If ($typeSaleLine#"")
//vUseBase:=SetPricePoint($typeSaleLine)
//End if 
//End if 
//End if 
//End if 
//// Modified by: Bill James (2015-02-02T00:00:00)

//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "Discount"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//$discountString:=aParameterValue{$nextValueElement}
//If ($discountString#"")
//pDiscnt:=Num($discountString)
//End if 
//End if 

//pvQtyOrd:=String(pQtyOrdered)
////
//C_TEXT($vTxtLine)
//pvItemNum:=$itemNum
//vReservations:=""
//vLineAdds:=""
//vLineAddsShow:=""
//pvLnProfile1:=""
//pvLnProfile2:=""
//pvLnProfile3:=""
//pvLnComment:=""
//_Ad1_:=""
//_Ad2_:=""
//_Ad3_:=""
//_Ad4_:=""
//addDiscount:=0
////    
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "LnComment"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//pvLnComment:=aParameterValue{$nextValueElement}
//End if 
//If ((pQtyOrdered>0) & ($itemNum#"-1zaq"))
//If (<>vbItemExtender=1)
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "jitExtend@"; $foundLine; $foundNext)
//If ($nextValueElement>0)  //&(($pExt<$pCR)|($pCR=0)))
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "jitExtend1"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//$itemExtend1:=aParameterValue{$nextValueElement}
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "jitExtend2"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//$itemExtend2:=aParameterValue{$nextValueElement}
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "jitExtend3"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//$itemExtend3:=aParameterValue{$nextValueElement}
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "jitExtend4"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//$itemExtend4:=aParameterValue{$nextValueElement}
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "jitExtend5"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//$itemExtend5:=aParameterValue{$nextValueElement}
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "jitExtend6"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//$itemExtend6:=aParameterValue{$nextValueElement}
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "jitExtend7"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//$itemExtend7:=aParameterValue{$nextValueElement}
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "jitExtend8"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//$itemExtend8:=aParameterValue{$nextValueElement}
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "jitExtend9"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//$itemExtend9:=aParameterValue{$nextValueElement}
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "jitExtend10"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//$itemExtend10:=aParameterValue{$nextValueElement}
//End if 
//ARRAY TEXT($myRay; 10)
//$myRay{1}:=$itemExtend1
//$myRay{2}:=$itemExtend2
//$myRay{3}:=$itemExtend3
//$myRay{4}:=$itemExtend4
//$myRay{5}:=$itemExtend5
//$myRay{6}:=$itemExtend6
//$myRay{7}:=$itemExtend7
//$myRay{8}:=$itemExtend8
//$myRay{9}:=$itemExtend9
//$myRay{10}:=$itemExtend10
////SORT ARRAY($myRay)
//C_LONGINT($incRay)
//For ($incRay; 1; 10)
//pvItemNum:=pvItemNum+$myRay{$incRay}
//End for 
//End if 
////
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_Ad@"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//C_LONGINT($pMore; $lenFound; $noPricing)
//$noPricing:=Num(WCapi_GetParameter("noPricing"; ""; 1))
//If ($noPricing=0)
//$noPricing:=1
//End if 
////// NOT FINISHED
//Http_ItemAdds(pvItemNum; "Read Arrays"; pQtyOrdered; vUseBase+9)  //-1)
//End if 
//End if 
//End if 
////  
//$newItem:=False
//Case of 
//: ($lineRecNum>0)  // ### bj ### 20190213_1750
//// line 132
//// ignore the zeroth record accept that risk
//// : ($lineRecNum>-1) fails occationally if it is not
////GOTO RECORD([WebTempRec];$lineRecNum)   //called when $lineRecNum is found
////clear value of -1
//$itemNum:=[WebTempRec]itemNum
//If ([WebTempRec]idEventLog=vleventID)
//If (pQtyOrdered<=0)
//[WebTempRec]qtyOrdered:=0
//[WebTempRec]posted:=True
//[WebTempRec]dtUpdated:=DateTime_Enter
//SAVE RECORD([WebTempRec])
//Else 
//QUERY([Item]; [Item]itemNum=[WebTempRec]itemNum)
////pDiscnt:=OrdSetDiscount (pQtyOrdered)
//Case of   //check for order and line changes
//: ($typeSaleLine#"")
//[WebTempRec]typeSale:=$typeSaleLine
//: ($typeSaleDoc#"")
//[WebTempRec]typeSale:=$typeSaleDoc
//: ([WebTempRec]typeSale="")
//[WebTempRec]typeSale:=$typeSaleDoc
//End case 
//Case of 
//: ($discountString="noUsed")
//: ($discountString#"")
//pDiscnt:=Num($discountString)

//End case 

//pExtPrice:=[WebTempRec]extendedPrice
//pvItemNum:=[WebTempRec]itemNum
//vUsePricePoint:=[WebTempRec]typeSale  //leave it unchanged if no new instructions       
//Case of 
//: ([WebTempRec]itemNum="ZZZTem@")
//pBasePrice:=[WebTempRec]unitPrice
//pUnitPrice:=[WebTempRec]discountedPrice
//pDiscnt:=0
////pUnitCost:=
//: (<>viMatrixPricing>0)  // Modified by: williamjames (110328)

//// Modified by: William James (2014-08-13T00:00:00)
//// FixThis: change Method so there is only one pricing procedure ::  Http_PostOrd2 and OrdSetPrice should have one procedure


//If (vWccPrimeRec>-1)
//If ($typeSaleLine#"")
//[WebTempRec]typeSale:=$typeSaleLine
//Else 
//If ($typeSaleDoc#"")
//[WebTempRec]typeSale:=$typeSaleDoc
//End if 
//End if 
//End if 
//QUERY([PriceMatrix]; [PriceMatrix]typeSale=[WebTempRec]typeSale; *)
//QUERY([PriceMatrix];  & [PriceMatrix]itemNum=[Item]itemNum; *)
//QUERY([PriceMatrix];  & [PriceMatrix]quantityMin<=pQtyOrdered; *)  //finding a record where Min is less than qty
//QUERY([PriceMatrix];  & [PriceMatrix]quantityMax>=pQtyOrdered)  //finding a record where Max is greater than qty
//Case of 
//: (Records in selection([PriceMatrix])=1)
//pUnitPrice:=[PriceMatrix]price
//pBasePrice:=pUnitPrice
//pDiscnt:=0
//: ((vWccPrimeRec>-1) & ($typeSaleLine="") & ($typeSaleDoc=""))

//// Modified by: William James (2014-04-24T00:00:00 Pricing)
//// is this correct

//pBasePrice:=[WebTempRec]unitPrice
//pUnitPrice:=[WebTempRec]discountedPrice
//pDiscnt:=[WebTempRec]discount


//Else 
//vUseBase:=SetPricePoint(vUsePricePoint)
//pBasePrice:=Field(4; vUseBase)->
//pUnitPrice:=DiscountApply(pBasePrice; pDiscnt; <>tcDecimalUP)+addDiscount
//End case 
//Else 
//vUseBase:=SetPricePoint(vUsePricePoint)
//// ### jwm ### 20150720_1847 QQQQQQQQ
//pDiscnt:=OrdSetDiscount(pQtyOrdered; [WebTempRec]typeSale; [WebTempRec]itemNum)  // ### jwm ### 20150414_1233
//pBasePrice:=Field(4; vUseBase)->
//pUnitPrice:=DiscountApply(pBasePrice; pDiscnt; <>tcDecimalUP)+addDiscount
////pUnitCost:=
//End case 
//pExtPrice:=Round(pUnitPrice*pQtyOrdered; <>tcDecimalTt)
//[WebTempRec]qtyOrdered:=pQtyOrdered
////             
//[WebTempRec]unitPrice:=pBasePrice
//[WebTempRec]discountedPrice:=pUnitPrice
//[WebTempRec]discount:=pDiscnt
//[WebTempRec]extendedPrice:=pExtPrice
//[WebTempRec]dtUpdated:=DateTime_Enter
//SAVE RECORD([WebTempRec])
//End if 
//End if 

//: (($skipNewAdd) & (pvItemNum#""))
//QUERY([Item]; [Item]itemNum=pvItemNum)
//If (Records in selection([Item])=0)
//QUERY([Item]; [Item]barCode=pvItemNum)
//End if 
//If (Records in selection([Item])=0)
//QUERY([Item]; [Item]vendorItemNum=pvItemNum)
//End if 
//If (Records in selection([Item])=0)
//QUERY([Item]; [Item]ean=pvItemNum)
//End if 
//If (Records in selection([Item])=0)
//QUERY([Item]; [Item]mfrItemNum=pvItemNum)
//End if 
//If ((Length(pvItemNum)>3) & (Records in selection([Item])=0))
//QUERY([Item]; [Item]itemNum=pvItemNum+"@")
//If (Records in selection([Item])=0)
//QUERY([Item]; [Item]barCode=pvItemNum+"@")
//End if 
//If (Records in selection([Item])=0)
//QUERY([Item]; [Item]ean=pvItemNum+"@")
//End if 
//End if 
//// ### jwm ### 20180521_1515 Check security level
//If (Records in selection([Item])>0)
//QUERY SELECTION([Item]; [Item]publish>0)
//QUERY SELECTION([Item]; [Item]publish<=viEndUserSecurityLevel)  // ### jwm ### 20180822_1713

//If (Records in selection([Item])=0)
//vResponse:=vResponse+"ERROR: Unauthorized Item "+pvItemNum+"\r"
//End if 

//Else 
//// item not found
//vResponse:=vResponse+"ERROR: Item Not Found "+pvItemNum+"\r"

//End if 

//Case of 
//: (Records in selection([Item])=1)
////continue
//: (Records in selection([Item])>1)  //display list
//$doitemZZZ:=2
//$endLoop:=True
//ORDER BY([Item]; [Item]itemNum)
//REDUCE SELECTION([Item]; 100)
//: ((Records in selection([Item])=0) & ($createZZZ))  //branch to enter zzz item
//QUERY([Item]; [Item]itemNum="zzzTemp@")
//If (Records in selection([Item])>1)
//REDUCE SELECTION([Item]; 1)
//End if 
//pvAltItem:=pvItemNum
//pvItemNum:="zzz_"+pvItemNum
//$doitemZZZ:=1
//$endLoop:=True
//End case 
//Case of 
//: ($doitemZZZ>0)  //drop out
//: (Records in selection([Item])=1)
//pvItemNum:=[Item]itemNum
//If (([Item]reservation) & (<>vlCycleTime>0) & (<>vlCartTime>0))
//pQtyOrdered:=Reservation_Make(pQtyOrdered; False)
//Http_ItemReservationEach($1)
//pvQtyOrd:=String(pQtyOrdered)
//End if 
//If ((pQtyOrdered>0) & (pvItemNum#""))  // ### jwm ### 20180521_1605
//If (Records in selection([WebTempRec])=0)
//WebTempRecCreate
//$newItem:=True
//End if 
//If (WCapi_GetParameter("QtyBundleSell"; "")="t@")
//If ([Item]qtyBundleSell#0)
//pQtyOrdered:=pQtyOrdered*[Item]qtyBundleSell
//End if 
//End if 
//Case of 
//: ([Item]type="IncentiveBonus")
//$thisBonus:=pQtyOrdered*[Item]bonusValue
//If ($thisBonus<$valueBonus)
//$valueBonus:=$valueBonus-$thisBonus
//Else 
//pQtyOrdered:=0
//pvQtyOrd:="0"
//End if 

////
//[WebTempRec]unitPrice:=[Item]priceA
//[WebTempRec]discountedPrice:=[Item]bonusPrice
//pBasePrice:=[WebTempRec]unitPrice
//pUnitPrice:=[WebTempRec]discountedPrice
//pDiscnt:=Discount_SetDiscount(pBasePrice; pUnitPrice)
//[WebTempRec]discount:=pDiscnt
//pExtPrice:=pQtyOrdered*[Item]bonusPrice
//: ((pvLnProfile1="NewsClerk") & (pvLnProfile2#""))
//QUERY([TallyResult]; [TallyResult]purpose="NewsClerk"; *)
//If (pvLnProfile3#"")
//QUERY([TallyResult];  & [TallyResult]profile1=pvLnProfile3; *)
//End if 
//QUERY([TallyResult];  & [TallyResult]name=pvLnProfile2)
//[WebTempRec]unitPrice:=[TallyResult]real1
//[WebTempRec]discountedPrice:=[TallyResult]real1
//[WebTempRec]discount:=Discount_SetDiscount([WebTempRec]unitPrice; [WebTempRec]discountedPrice)

//pExtPrice:=Round(pUnitPrice*[TallyResult]real2; <>tcDecimalTt)
//[WebTempRec]mfrID:=[Item]mfrID

//// Modified by: William James (2014-04-24T00:00:00 Discount)

//pDiscnt:=[WebTempRec]discount
//pUnitPrice:=[WebTempRec]discountedPrice
//pBasePrice:=[WebTempRec]unitPrice
//pQtyOrdered:=[TallyResult]real2
//UNLOAD RECORD([TallyResult])
//: ([WebTempRec]itemNum="ZZZTemp@")
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_101_15jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//UtFillifNotEmpty(->[WebTempRec]description; aParameterValue{$nextValueElement}; 1)
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_101_22jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//UtFillifNotEmpty(->[WebTempRec]mfrID; aParameterValue{$nextValueElement}; 1)
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_101_26jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//UtFillifNotEmpty(->[WebTempRec]mfrItemNum; aParameterValue{$nextValueElement}; 1)
//End if 
//pDiscnt:=0
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_101_10jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//pUnitPrice:=Num(aParameterValue{$nextValueElement})
//End if 
////pUnitPrice:=Num(WCapi_GetParameter(->vText7;"_jit_101_10jj";"";1))
//pBasePrice:=pUnitPrice
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_101_30jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//pUnitCost:=Num(aParameterValue{$nextValueElement})
//End if 


//Else 
//pDiscnt:=OrdSetDiscount(pQtyOrdered; [WebTempRec]typeSale; [WebTempRec]itemNum)  // fixed by jm
//pBasePrice:=Field(4; vUseBase)->
//pUnitPrice:=DiscountApply(pBasePrice; pDiscnt; <>tcDecimalUP)+addDiscount
//End case 
////
//pvUnitPrice:=String(pUnitPrice; <>tcFormatUP)
//pvDcnt:=String(pDiscnt; "##0.0")
//pExtPrice:=Round(pUnitPrice*pQtyOrdered; <>tcDecimalTt)
//pvExtPrice:=String(pExtPrice; <>tcFormatTt)
//pvBasePrice:=String(pBasePrice; <>tcFormatUP)
////              
//Case of   //check for order and line changes
//: ($typeSaleLine#"")
//[WebTempRec]typeSale:=$typeSaleLine
//: ($typeSaleDoc#"")
//[WebTempRec]typeSale:=$typeSaleDoc
//: ([WebTempRec]typeSale="")
//[WebTempRec]typeSale:=[Customer]typeSale
//End case 

//[WebTempRec]qtyOrdered:=pQtyOrdered
//[WebTempRec]unitPrice:=pBasePrice
//[WebTempRec]discountedPrice:=pUnitPrice
//[WebTempRec]extendedPrice:=pExtPrice
//[WebTempRec]comment:=pvLnComment
//[WebTempRec]reservation:=vReservations
//[WebTempRec]adds:=vLineAdds
//[WebTempRec]addsDescripts:=vLineAddsShow
//[WebTempRec]cost:=pUnitCost
//[WebTempRec]dtUpdated:=DateTime_Enter
//SAVE RECORD([WebTempRec])
//End if 
//Else 
//If (pvItemsNotFound="")
//pvItemsNotFound:="Items Not Found:  "+pvItemNum+", "+String(pQtyOrdered)
//Else 
//pvItemsNotFound:=pvItemsNotFound+"; "+pvItemNum+", "+String(pQtyOrdered)
//End if 
//End case 
//End case 
//If ((pQtyOrdered>0) & (Record number([WebTempRec])>-1))
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_101_15jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//UtFillifNotEmpty(->[WebTempRec]description; aParameterValue{$nextValueElement}; 1)
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_101_6jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//UtFillifNotEmpty(->[WebTempRec]classid; aParameterValue{$nextValueElement}; 1)
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_101_7jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//UtFillifNotEmpty(->[WebTempRec]profile1; aParameterValue{$nextValueElement}; 1)
//End if 

//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_101_8jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//UtFillifNotEmpty(->[WebTempRec]profile2; aParameterValue{$nextValueElement}; 1)
//End if 

//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_101_9jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//UtFillifNotEmpty(->[WebTempRec]profile3; aParameterValue{$nextValueElement}; 1)
//End if 

//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_101_13jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//UtFillifNotEmpty(->[WebTempRec]comment; aParameterValue{$nextValueElement}; 1)
//End if 
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_101_6jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//UtFillifNotEmpty(->[WebTempRec]classid; aParameterValue{$nextValueElement}; 1)
//End if 


////UtFillifNotEmpty (->[WebTempRec]Description;WCapi_GetParameter(->vText7;"_jit_101_15jj";"";1);0)
////UtFillifNotEmpty (->[WebTempRec]ClassID;WCapi_GetParameter(->vText7;"_jit_101_6jj";"";1);0)
////UtFillifNotEmpty (->[WebTempRec]Profile1;WCapi_GetParameter(->vText7;"_jit_101_7jj";"";1);0)
////UtFillifNotEmpty (->[WebTempRec]Profile2;WCapi_GetParameter(->vText7;"_jit_101_8jj";"";1);0)
////UtFillifNotEmpty (->[WebTempRec]Profile3;WCapi_GetParameter(->vText7;"_jit_101_9jj";"";1);0)
////UtFillifNotEmpty (->[WebTempRec]Comment;WCapi_GetParameter(->vText7;"_jit_101_13jj";"";1);0)

//If (vWccSecurity>0)
//$nextValueElement:=Array_GetParamWithIn(->aParameterName; "_jit_101_25jj"; $foundLine; $foundNext)
//If ($nextValueElement>0)
//[WebTempRec]taxExempt:=(aParameterValue{$nextValueElement}="true")
//End if 

////[WebTempRec]TaxExempt:=(WCapi_GetParameter(->vText7;"_jit_101_25jj";"";1)="true")
//End if 
//[WebTempRec]dtUpdated:=DateTime_Enter
//SAVE RECORD([WebTempRec])
//End if 
////End if 

//End if 
//Until ($endLoop)
////
//Case of 
//: ($doitemZZZ=1)  //branch to a page for entering the temporary item data
//$jitPageOne:=WCapi_GetParameter("jitPageZZZ"; "")
//$pageDo:=WC_DoPage("WccWebTempRecsOne.html"; $jitPageOne)

//: ($doitemZZZ=2)  //display a list of items found
//$jitPageOne:=WCapi_GetParameter("jitPageList"; "")
//$pageDo:=WC_DoPage("ItemsList.html"; $jitPageOne)
//Else 
//// ### bj ### 20181231_2038
//// Adjust this to ajax calls by line
//QUERY([WebTempRec]; [WebTempRec]idEventLog=vleventID; *)
//QUERY([WebTempRec];  & [WebTempRec]qtyOrdered#0; *)
//QUERY([WebTempRec];  & [WebTempRec]posted=False)

//If ($reverseWebTemp="101_2@")

//Else 
//ORDER BY([WebTempRec]; [WebTempRec]idNum; <)
//End if 

//[EventLog]qty:=0
//[EventLog]value:=0
//[EventLog]valueBonus:=0
//ARRAY REAL($aQtyOrd; 0)
//ARRAY REAL($aExtPrice; 0)
//ARRAY REAL($aBonus; 0)
//ARRAY TEXT($aMfgID; 0)
//SELECTION TO ARRAY([WebTempRec]qtyOrdered; $aQtyOrd; [WebTempRec]extendedPrice; $aExtPrice; [WebTempRec]bonus; $aBonus; [WebTempRec]mfrID; $aMfgID)  //calc cart value
//$k:=Size of array($aQtyOrd)
////displayable arrays
//ARRAY TEXT(amfrID; 0)
//ARRAY TEXT(aMfrCompany; 0)
//ARRAY REAL(aMfrOrderValue; 0)
//ARRAY REAL(aMfrOrderQty; 0)
//ARRAY REAL(aMfrMinReOrder; 0)
//ARRAY REAL(aMfrMinOrder; 0)
//If (<>doMfr)
//SORT ARRAY($aMfgID; $aBonus; $aExtPrice; $aQtyOrd)
//End if 
//C_TEXT($curMfgID)
//C_LONGINT($wMfrFind)



//If ($k>0)
//For ($i; 1; $k)
//If (<>doMfr)
//$w:=Find in array(amfrID; $aMfgID{$i})
//If ($w<1)
//$w:=Size of array(amfrID)+1
//INSERT IN ARRAY(amfrID; $w; 1)
//INSERT IN ARRAY(aMfrCompany; $w; 1)
//INSERT IN ARRAY(aMfrMinReOrder; $w; 1)
//INSERT IN ARRAY(aMfrMinOrder; $w; 1)
//amfrID{$w}:=$aMfgID{$i}
//$wMfrFind:=Find in array(<>amfrID; $aMfgID{$i})  //check the master table
//If ($wMfrFind>0)
//aMfrCompany{$w}:=<>aMfrCompany{$wMfrFind}
//aMfrMinOrder{$w}:=<>aMfrOpenAmount{$wMfrFind}
//aMfrMinReOrder{$w}:=<>aMfrReorderAmount{$wMfrFind}
////<>aMfrTerms{$wMfrFind}
//End if 
//INSERT IN ARRAY(aMfrOrderValue; $w; 1)  //always filll in
//INSERT IN ARRAY(aMfrOrderQty; $w; 1)  //always filll in
//End if 
//aMfrOrderValue{$w}:=aMfrOrderValue{$w}+$aExtPrice{$i}
//aMfrOrderQty{$w}:=aMfrOrderQty{$w}+$aQtyOrd{$i}
//End if 
//[EventLog]qty:=[EventLog]qty+$aQtyOrd{$i}
//[EventLog]value:=[EventLog]value+$aExtPrice{$i}
//[EventLog]valueBonus:=[EventLog]valueBonus+$aBonus{$i}
//End for 
//End if 
//C_TEXT(pvMinOrder)
//If (<>doMfr)
//pvMinOrder:="<Table class="+Txt_Quoted("mfrOrderMinTable")+">"
//pvMinOrder:=pvMinOrder+"<TR><TD class="+Txt_Quoted("mfrTitleAlpha")+">"+"mfrID"+"</TD><TD class="+Txt_Quoted("mfrTitleAlpha")+">"+"MfrName"+"</TD><TD class="+Txt_Quoted("mfrTitleNum")+">"+"OrderMin"+"</TD><TD class="+Txt_Quoted("mfrTitleNum")+">"+"ReOrderMin"+"</TD><TD class="+Txt_Quoted("mfrTitleNum")+">"+"Total"+"</TD><TD class="+Txt_Quoted("mfrTitleNum")+">"+"Units"+"</TD</TR>"+"\r"
//$k:=Size of array(amfrID)
//For ($i; 1; $k)
//pvMinOrder:=pvMinOrder+"<TR><TD class="+Txt_Quoted("mfrOrderAlpha")+">"+amfrID{$i}+"</TD><TD class="+Txt_Quoted("mfrOrderAlpha")+">"+aMfrCompany{$i}+"</TD><TD class="+Txt_Quoted("mfrOrderNumber")+">"+<>tcMONEYCHAR+String(Round(aMfrMinOrder{$i}; 0))+"</TD><TD class="+Txt_Quoted("mfrOrderNumber")+">"+<>tcMONEYCHAR+String(Round(aMfrMinReOrder{$i}; 0))+"</TD><TD class="+Txt_Quoted("mfrOrderNumber")+">"+<>tcMONEYCHAR+String(Round(aMfrOrderValue{$i}; 0))+"</TD><TD class="+Txt_Quoted("mfrOrderNumber")+">"+String(Round(aMfrOrderQty{$i}; 0))+"</TD></TR>"+"\r"
//End for 
//pvMinOrder:=pvMinOrder+"</Table>"
//End if 
////
//C_REAL(pSumBalance)

//If ($vlBeenHere#0)
//[EventLog]beenHere:=$vlBeenHere
//End if 
//If ([EventLog]idNum#0)
//SAVE RECORD([EventLog])
//End if 
//C_TEXT(pvWarning)
//UNLOAD RECORD([Item])

//pSumBalance:=-([Customer]balanceTotalExposure+[EventLog]value)
////
//pvSumQuantity:=String(Round([EventLog]qty; 4); "###,###,##0.###,###")
//pvSumPrice:=String(Round(Sum([WebTempRec]extendedPrice); <>tcDecimalTt); <>tcFormatTt)
//vText1:=pvSumQuantity
//vText2:=pvSumPrice
//pvSumBonus:=String(Round([EventLog]valueBonus; <>tcDecimalTt); <>tcFormatTt)

//$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
//If (($jitPageOne="@Items@") & ([EventLog]lastQueryScript="@Query([Items@"))
//vURLQueryScript:=[EventLog]lastQueryScript
//vURLSortScript:=[EventLog]wccEmail
////SET TEXT TO CLIPBOARD(vURLQueryScript)
//ExecuteText(0; vURLQueryScript)
//ExecuteText(0; vURLSortScript)
//$num:=Records in selection([Item])
//If ($num>(<>viMaxShow*3))
//REDUCE SELECTION([Item]; <>viMaxShow*3)
//End if 

////Else 
////$jitPageOne:=""
//End if 

//$jitPageError:=WCapi_GetParameter("jitPageError"; "")  // ### jwm ### 20150916_1006

//If ((vResponse#"") & ($jitPageError#""))

//$pageDo:=WC_DoPage("Error.html"; $jitPageError)

//Else 

//$pageDo:=WC_DoPage("ShoppingCart.html"; $jitPageOne)

//End if 

//End case 
//$err:=WC_PageSendWithTags($1; $pageDo; 0)
////
//vText3:=""
//vText5:=""
//vText8:=""
//vText7:=""
//pvWarning:=""
//pvItemsNotFound:=""
//vText1:=""
//vText2:=""
//vText3:=""
//vText4:=""
//vText5:=""
//vText6:=""
//vText7:=""
//vText8:=""
//vText9:=""
//vText10:=""
//vReservations:=""
//pvLnProfile1:=""
//pvLnProfile2:=""
//pvLnProfile3:=""
//pvLnComment:=""
//pvAltItem:=""
//ARRAY TEXT(aOItemNum; 0)
//ARRAY TEXT(aODescpt; 0)
//ARRAY REAL(aOQtyOrder; 0)
////
////
//READ WRITE([Customer])
//READ WRITE([Rep])
//READ WRITE([Contact])
//READ WRITE([Lead])
//READ WRITE([Vendor])
//ARRAY TEXT(aMinOrderMfgID; 0)
//ARRAY REAL(aMinOrderValue; 0)



