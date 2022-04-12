//%attributes = {"publishedWeb":true}

//  // ----------------------------------------------------
//  // User name (OS): Bill James
//  // Date and time: 2015-07-20T00:00:00, 12:21:51
//  // ----------------------------------------------------
//  // Method: Http_PostOrd2_Hold
//  // Description
//  // Modified: 07/20/15
//  // Structure: CEv13_131005
//  // 
//  //
//  // Parameters
//  // ----------------------------------------------------
//  
//  
//  C_TEXT($txtPage; $txtPart; $typeSaleDoc; $typeSaleLine)
//  C_REAL($runQty; pQtyOrdered; $runPrice; pUnitPrice; pExtPrice; addDiscount; pQtyOrdered)
//  C_REAL(<>vMinOrders)
//  C_TEXT(vText1; vText2; vText3; vText4; vText5; vText6; vText7; vText8; vText9; vText10)
//  C_LONGINT($err; $pTest; $vlBeenHere; vlBeenHere)
//  C_LONGINT($1)
//  C_POINTER($2)
//  C_LONGINT($3)
//  C_TEXT($itemExtend1; $itemExtend2; $itemExtend3; $itemExtend4; $itemExtend5)
//  C_TEXT($itemExtend6; $itemExtend7; $itemExtend8; $itemExtend9; $itemExtend10)
//  //
//  C_LONGINT($p; $theFile; $theField; $testFile; $setUseBasePrice)
//  READ ONLY([Customer])
//  READ ONLY([Rep])
//  READ ONLY([Contact])
//  READ ONLY([Lead])
//  READ ONLY([Vendor])
//  //
//  $vlBeenHere:=Num(WCapi_GetParameter("beenHere"; ""))
//  If (([EventLog]beenHere=$vlBeenHere) & ($vlBeenHere#0))
//  $skipNewAdd:=False
//  Else 
//  $skipNewAdd:=True
//  End if 
//  $reverseWebTemp:=WCapi_GetParameter("CartOrder"; "")
//  //TRACE
//  $jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
//  $pageDo:=WC_DoPage("ShoppingCart.html"; $jitPageOne)
//  vText9:=""
//  //zttp_UserGet 
//  If (vWccSecurity>0)
//  $typeSaleDoc:=WCapi_GetParameter("TypeSaleDoc"; "")
//  If ($typeSaleDoc#"")
//  vUseBase:=SetPricePoint($typeSaleDoc)
//  End if 
//  End if 
//  $setUseBasePrice:=vUseBase
//  //TRACE
//  // ### bj ### 20181214_0724
//  //[EventLog]Message:=""
//  [EventLog]qty:=0
//  [EventLog]value:=0
//  [EventLog]beenHere:=DateTime_Enter
//  vBeenHere:=[EventLog]beenHere
//  vlBeenHere:=[EventLog]beenHere
//  $err:=0
//  //
//  If ($2->="Get@")  //must be here to catch the last item or it gets zeroed
//  $p:=Position(Storage.char.crlf; $2->)
//  If ($p>0)  //clip of the header tail
//  $2->:=Substring($2->; 1; $p-1)
//  //Else 
//  //ignor the header will be clipped by the first item read
//  End if 
//  End if 
//  //
//  ARRAY TEXT(aOItemNum; 0)
//  ARRAY TEXT(aODescpt; 0)
//  ARRAY REAL(aOQtyOrder; 0)
//  $mySort:=""
//  $p:=Position("_jitSort"; $2->)
//  If ($p>0)
//  $showLast:=0
//  $mySort:=Substring($2->; $p; 80)  //clip the sort command, get enough 
//  $p:=Position(<>endTag; $mySort)  //find the end
//  $mySort:=Substring($mySort; 1; $p+1)
//  $showLast:=Http_DoSort($mySort)
//  $mySort:="&"+$mySort+"&"
//  End if 
//  //TRACE
//  C_LONGINT($p; $pEqual; $pEnd; $pCR; $pEndSeg)
//  $endLoop:=False
//  $p:=Position("LineRecordNum"; $2->)  //do the lines  
//  //TRACE
//  If ($p>0)
//  Repeat 
//  $typeSaleLine:=""
//  vText7:=""
//  $p:=Position("LineRecordNum"; $2->)  //do the lines  
//  $2->:=Substring($2->; $p+4)  //clip off thru the "&" string     
//  $pNext:=Position("LineRecordNum"; $2->)  //do the lines
//  If ($pNext=0)
//  vText7:="Line"+$2->
//  $endLoop:=True
//  $2->:=""
//  Else 
//  vText7:="Line"+Substring($2->; 1; $pNext-1)  //clip incoming to a single item record
//  End if 
//  //If ($p=0)
//  //$runQty:=0
//  //$runPrice:=0
//  //$valueBonus:=0
//  //End if 
//  $typeSaleLine:=""
//  If (vText7#"")
//  vUseBase:=$setUseBasePrice  //reset in each loop
//  $baseQty:=0
//  $lineRecNum:=Num(WCapi_GetParameter("LineRecordNum"; ""; 1))
//  $itemNum:=WCapi_GetParameter("ItemNum"; ""; 1)
//  pvQtyOrd:=WCapi_GetParameter("QtyOrdered"; ""; 1)
//  pQtyOrdered:=Num(pvQtyOrd)
//  
//  If ((pQtyOrdered>0) & (vWccSecurity>0))
//  $typeSaleLine:=WCapi_GetParameter("TypeSaleLine"; ""; 1)
//  If ($typeSaleLine#"")
//  vUseBase:=SetPricePoint($typeSaleLine)
//  End if 
//  End if 
//  pvQtyOrd:=String(pQtyOrdered)
//  
//  C_TEXT($vTxtLine)
//  pvItemNum:=$itemNum
//  vReservations:=""
//  vLineAdds:=""
//  vLineAddsShow:=""
//  pvLnProfile1:=""
//  pvLnProfile2:=""
//  pvLnProfile3:=""
//  pvLnComment:=""
//  _Ad1_:=""
//  _Ad2_:=""
//  _Ad3_:=""
//  _Ad4_:=""
//  addDiscount:=0
//  //    
//  If ((<>vbItemExtender=1) & (pQtyOrdered#0))
//  $vTxtLine:=vText7
//  $pExt:=Position("&jitExtend"; vText7)
//  If ($pExt>0)  //&(($pExt<$pCR)|($pCR=0)))
//  $itemExtend1:=WCapi_GetParameter("jitExtend1"; ""; 1)
//  $itemExtend2:=WCapi_GetParameter("jitExtend2"; ""; 1)
//  $itemExtend3:=WCapi_GetParameter("jitExtend3"; ""; 1)
//  $itemExtend4:=WCapi_GetParameter("jitExtend4"; ""; 1)
//  $itemExtend5:=WCapi_GetParameter("jitExtend5"; ""; 1)
//  $itemExtend6:=WCapi_GetParameter("jitExtend6"; ""; 1)
//  $itemExtend7:=WCapi_GetParameter("jitExtend7"; ""; 1)
//  $itemExtend8:=WCapi_GetParameter("jitExtend8"; ""; 1)
//  $itemExtend9:=WCapi_GetParameter("jitExtend9"; ""; 1)
//  $itemExtend10:=WCapi_GetParameter("jitExtend10"; ""; 1)
//  ARRAY TEXT($myRay; 10)
//  $myRay{1}:=$itemExtend1
//  $myRay{2}:=$itemExtend2
//  $myRay{3}:=$itemExtend3
//  $myRay{4}:=$itemExtend4
//  $myRay{5}:=$itemExtend5
//  $myRay{6}:=$itemExtend6
//  $myRay{7}:=$itemExtend7
//  $myRay{8}:=$itemExtend8
//  $myRay{9}:=$itemExtend9
//  $myRay{10}:=$itemExtend10
//  SORT ARRAY($myRay)
//  C_LONGINT($incRay)
//  For ($incRay; 1; 10)
//  pvItemNum:=pvItemNum+$myRay{$incRay}
//  End for 
//  End if 
//  //
//  $pMore:=Position("_Ad"; $vTxtLine)
//  If ($pMore>0)
//  C_LONGINT($pMore; $lenFound; $noPricing)
//  $noPricing:=Num(WCapi_GetParameter("noPricing"; ""; 1))
//  If ($noPricing=0)
//  $noPricing:=1
//  End if 
//  Http_ItemAdds(pvItemNum; vText7; pQtyOrdered; vUseBase+9)  //-1)
//  End if 
//  End if 
//  //  
//  $newItem:=False
//  Case of 
//  : ($lineRecNum>-1)
//  GOTO RECORD([WebTempRec]; $lineRecNum)
//[AccountPayType]//  If ([WebTempRec]idEventLog=vleventID)
//  If (pQtyOrdered<=0)
//  [WebTempRec]qtyOrdered:=0
//  SAVE RECORD([WebTempRec])
//  Else 
//  QUERY([Item]; [Item]itemNum=[WebTempRec]itemNum)
//  pDiscnt:=OrdSetDiscount(pQtyOrdered)
//  Case of   //check for order and line changes
//  : ($typeSaleLine#"")
//  [WebTempRec]typeSale:=$typeSaleLine
//  : ($typeSaleDoc#"")
//  [WebTempRec]typeSale:=$typeSaleDoc
//  : ([WebTempRec]typeSale="")
//  [WebTempRec]typeSale:=[Customer]typeSale
//  End case 
//  
//  pExtPrice:=[WebTempRec]extendedPrice
//  pvItemNum:=[WebTempRec]itemNum
//  vUsePricePoint:=[WebTempRec]typeSale  //leave it unchanged if no new instructions              
//  vUseBase:=SetPricePoint(vUsePricePoint)
//  pBasePrice:=Field(4; vUseBase)->
//  pUnitPrice:=DiscountApply(pBasePrice; pDiscnt; <>tcDecimalUP)+addDiscount
//  pExtPrice:=Round(pUnitPrice*pQtyOrdered; <>tcDecimalTt)
//  [WebTempRec]qtyOrdered:=pQtyOrdered
//  //             
//  [WebTempRec]unitPrice:=pBasePrice
//  [WebTempRec]discountedPrice:=pUnitPrice
//  [WebTempRec]extendedPrice:=pExtPrice
//  SAVE RECORD([WebTempRec])
//  End if 
//  End if 
//  
//  : ($skipNewAdd)
//  QUERY([Item]; [Item]itemNum=pvItemNum)
//  If (Records in selection([Item])=1)
//  If (([Item]reservation) & (<>vlCycleTime>0) & (<>vlCartTime>0))
//  pQtyOrdered:=Reservation_Make(pQtyOrdered; False)
//  Http_ItemReservationEach($1)
//  pvQtyOrd:=String(pQtyOrdered)
//  
//  //
//  //
//  //Else 
//  //If (($3=1)&(<>vlCycleTime>0)&(<>vlCartTime>0))
//  //QUERY([Item];[Item]ItemNum=pvItemNum)
//  //If (Records in selection([Item])=1)
//  //If ([Item]Reservation)
//  //Reservation_Drop 
//  //End if 
//  //End if 
//  //UNLOAD RECORD([Item])
//  //End if 
//  //End if 
//  End if 
//  If (pQtyOrdered>0)
//  If (Records in selection([WebTempRec])=0)
//  CREATE RECORD([WebTempRec])
//  
//  [WebTempRec]idEventLog:=vleventID
//  [WebTempRec]itemNum:=pvItemNum
//  [WebTempRec]description:=[Item]description
//  
//  
//  If ([RemoteUser]company#"")
//  [WebTempRec]company:=[RemoteUser]company
//  Else 
//  [WebTempRec]company:=[RemoteUser]userName
//  End if 
//  [WebTempRec]tableNum:=[RemoteUser]tableNum
//  
//  //TRACE
//  [WebTempRec]taxExempt:=(([Item]taxID#"") & ([Item]taxID#"false") & ([Customer]taxExemptid#"") & (Record number([Customer])>-1))
//  Case of   //check for order and line changes
//  : ($typeSaleLine#"")
//  [WebTempRec]typeSale:=$typeSaleLine
//  : ($typeSaleDoc#"")
//  [WebTempRec]typeSale:=$typeSaleDoc
//  : ([WebTempRec]typeSale="")
//  [WebTempRec]typeSale:=[Customer]typeSale
//  End case 
//  $newItem:=True
//  End if 
//  Case of 
//  : ([Item]type="IncentiveBonus")
//  $thisBonus:=pQtyOrdered*[Item]bonusValue
//  If ($thisBonus<$valueBonus)
//  $valueBonus:=$valueBonus-$thisBonus
//  Else 
//  pQtyOrdered:=0
//  pvQtyOrd:="0"
//  End if 
//  [WebTempRec]unitPrice:=[Item]priceA
//  [WebTempRec]discountedPrice:=[Item]bonusPrice
//  pBasePrice:=[WebTempRec]unitPrice
//  pUnitPrice:=[WebTempRec]discountedPrice
//  pDiscnt:=Discount_SetDiscount([Item]priceA; [Item]bonusPrice)
//  pExtPrice:=pQtyOrdered*[Item]bonusPrice
//  : ((pvLnProfile1="NewsClerk") & (pvLnProfile2#""))
//  QUERY([TallyResult]; [TallyResult]purpose="NewsClerk"; *)
//  If (pvLnProfile3#"")
//  QUERY([TallyResult];  & [TallyResult]profile1=pvLnProfile3; *)
//  End if 
//  QUERY([TallyResult];  & [TallyResult]name=pvLnProfile2)
//  [WebTempRec]unitPrice:=[TallyResult]real1
//  [WebTempRec]discountedPrice:=[TallyResult]real1
//  pExtPrice:=Round(pUnitPrice*[TallyResult]real2; <>tcDecimalTt)
//  [WebTempRec]mfrID:=[Item]mfrID
//  pDiscnt:=0
//  pUnitPrice:=[WebTempRec]discountedPrice
//  pBasePrice:=[WebTempRec]unitPrice
//  pQtyOrdered:=[TallyResult]real2
//  UNLOAD RECORD([TallyResult])
//  : ([WebTempRec]itemNum="ZZZTemp@")
//  UtFillifNotEmpty(->[WebTempRec]mfrID; WCapi_GetParameter("_jit_101_22jj"; ""; 1); 0)
//  UtFillifNotEmpty(->[WebTempRec]mfrItemNum; WCapi_GetParameter("_jit_101_26jj"; ""; 1); 0)
//  pDiscnt:=0
//  pUnitPrice:=Num(WCapi_GetParameter("_jit_101_10jj"; ""; 1))
//  pBasePrice:=pUnitPrice
//  Else 
//  pDiscnt:=OrdSetDiscount(pQtyOrdered)
//  pBasePrice:=Field(4; vUseBase)->
//  pUnitPrice:=DiscountApply(pBasePrice; pDiscnt; <>tcDecimalUP)+addDiscount
//  End case 
//  //
//  pvUnitPrice:=String(pUnitPrice; <>tcFormatUP)
//  pvDcnt:=String(pDiscnt; "##0.0")
//  pExtPrice:=Round(pUnitPrice*pQtyOrdered; <>tcDecimalTt)
//  pvExtPrice:=String(pExtPrice; <>tcFormatTt)
//  pvBasePrice:=String(pBasePrice; <>tcFormatUP)
//  //              
//  Case of 
//  : ($typeSaleLine#"")
//  [WebTempRec]typeSale:=$typeSaleLine
//  : ($typeSaleDoc#"")
//  [WebTempRec]typeSale:=$typeSaleDoc
//  Else 
//  [WebTempRec]typeSale:=vUseTypeSale
//  End case 
//  [WebTempRec]qtyOrdered:=pQtyOrdered
//  [WebTempRec]unitPrice:=pBasePrice
//  [WebTempRec]discountedPrice:=pUnitPrice
//  [WebTempRec]extendedPrice:=pExtPrice
//  [WebTempRec]comment:=pvLnComment
//  [WebTempRec]reservation:=vReservations
//  [WebTempRec]adds:=vLineAdds
//  [WebTempRec]addsDescripts:=vLineAddsShow
//  SAVE RECORD([WebTempRec])
//  End if 
//  Else 
//  If (pvItemsNotFound="")
//  pvItemsNotFound:="Items Not Found:  "+pvItemNum+", "+String(pQtyOrdered)
//  Else 
//  pvItemsNotFound:=pvItemsNotFound+"; "+pvItemNum+", "+String(pQtyOrdered)
//  End if 
//  End if 
//  End case 
//  If ((pQtyOrdered>0) & (Record number([WebTempRec])>-1))
//  UtFillifNotEmpty(->[WebTempRec]description; WCapi_GetParameter("_jit_101_15jj"; ""; 1); 0)
//  UtFillifNotEmpty(->[WebTempRec]classid; WCapi_GetParameter("_jit_101_6jj"; ""; 1); 0)
//  UtFillifNotEmpty(->[WebTempRec]profile1; WCapi_GetParameter("_jit_101_7jj"; ""; 1); 0)
//  UtFillifNotEmpty(->[WebTempRec]profile2; WCapi_GetParameter("_jit_101_8jj"; ""; 1); 0)
//  UtFillifNotEmpty(->[WebTempRec]profile3; WCapi_GetParameter("_jit_101_9jj"; ""; 1); 0)
//  UtFillifNotEmpty(->[WebTempRec]comment; WCapi_GetParameter("_jit_101_13jj"; ""; 1); 0)
//  
//  If (vWccSecurity>0)
//  [WebTempRec]taxExempt:=(WCapi_GetParameter("_jit_101_25jj"; ""; 1)="true")
//  End if 
//  SAVE RECORD([WebTempRec])
//  End if 
//  End if 
//  REDUCE SELECTION([WebTempRec]; 0)
//  REDUCE SELECTION([Item]; 0)
//  Until ($endLoop)
//  End if 
//  //
//  QUERY([WebTempRec]; [WebTempRec]idEventLog=vleventID; *)
//  QUERY([WebTempRec];  & [WebTempRec]qtyOrdered#0; *)
//  QUERY([WebTempRec];  & [WebTempRec]posted=False)
//  
//  If ($reverseWebTemp="101_2@")
//  
//  Else 
//  ORDER BY([WebTempRec]; [WebTempRec]idNum; <)
//  End if 
//  
//  ARRAY REAL($aQtyOrd; 0)
//  ARRAY REAL($aExtPrice; 0)
//  ARRAY REAL($aBonus; 0)
//  ARRAY TEXT($aMfgID; 0)
//  //
//  SELECTION TO ARRAY([WebTempRec]qtyOrdered; $aQtyOrd; [WebTempRec]extendedPrice; $aExtPrice; [WebTempRec]bonus; $aBonus; [WebTempRec]mfrID; $aMfgID)
//  $k:=Size of array($aQtyOrd)
//  [EventLog]qty:=0
//  [EventLog]value:=0
//  [EventLog]valueBonus:=0
//  If (<>vMinOrders=1)
//  SORT ARRAY($aMfgID; $aBonus; $aExtPrice; $aQtyOrd)
//  End if 
//  //
//  //TRACE
//  ARRAY TEXT(aMinOrderMfgID; 0)
//  ARRAY REAL(aMinOrderValue; 0)
//  C_TEXT($curMfgID)
//  If ($k>0)
//  $curMfgID:="q 23rfMJUYLY67'HRTSER'TRHE56H6SXRTHRJERSERTSERNTND876KM67KR6"
//  For ($i; 1; $k)
//  If ($curMfgID#$aMfgID{$i})
//  $w:=Size of array(aMinOrderMfgID)+1
//  INSERT IN ARRAY(aMinOrderMfgID; $w; 1)
//  INSERT IN ARRAY(aMinOrderValue; $w; 1)
//  aMinOrderMfgID{$w}:=$aMfgID{$i}
//  $curMfgID:=$aMfgID{$i}
//  End if 
//  aMinOrderValue{$w}:=aMinOrderValue{$w}+$aExtPrice{$i}
//  [EventLog]qty:=[EventLog]qty+$aQtyOrd{$i}
//  [EventLog]value:=[EventLog]value+$aExtPrice{$i}
//  [EventLog]valueBonus:=[EventLog]valueBonus+$aBonus{$i}
//  End for 
//  End if 
//  
//  If (<>vMinOrders=1)
//  C_TEXT(pvMinOrder)
//  pvMinOrder:="<Table>"
//  $k:=Size of array(aMinOrderMfgID)
//  For ($i; 1; $k)
//  pvMinOrder:=pvMinOrder+"<TR><TD class="+Txt_Quoted("minOrderMfgID")+">"+aMinOrderMfgID{$i}+"</TD><TD class="+Txt_Quoted("minOrderValue")+">"+String(Round(aMinOrderValue{$i}; 0))+"</TD></TR>"+"\r"
//  End for 
//  pvMinOrder:=pvMinOrder+"</Table>"
//  End if 
//  //
//  C_REAL(pSumBalance)
//  
//  If ($vlBeenHere#0)
//  [EventLog]beenHere:=$vlBeenHere
//  End if 
//  If ([EventLog]idNum#0)
//  SAVE RECORD([EventLog])
//  End if 
//  C_TEXT(pvWarning)
//  UNLOAD RECORD([Item])
//  
//  pSumBalance:=-([Customer]balanceTotalExposure+[EventLog]value)
//  //
//  pvSumQuantity:=String(Round([EventLog]qty; 4); "###,###,##0.###,###")
//  pvSumPrice:=String(Round([EventLog]value; <>tcDecimalTt); <>tcFormatTt)
//  vText1:=pvSumQuantity
//  vText2:=pvSumPrice
//  pvSumBonus:=String(Round([EventLog]valueBonus; <>tcDecimalTt); <>tcFormatTt)
//  
//  $err:=WC_PageSendWithTags($1; $pageDo; 0)
//  //
//  REDUCE SELECTION([WebTempRec]; 0)
//  vText3:=""
//  vText5:=""
//  vText8:=""
//  vText7:=""
//  pvWarning:=""
//  pvItemsNotFound:=""
//  vText1:=""
//  vText2:=""
//  vText3:=""
//  vText4:=""
//  vText5:=""
//  vText6:=""
//  vText7:=""
//  vText8:=""
//  vText9:=""
//  vText10:=""
//  vReservations:=""
//  pvLnProfile1:=""
//  pvLnProfile2:=""
//  pvLnProfile3:=""
//  pvLnComment:=""
//  ARRAY TEXT(aOItemNum; 0)
//  ARRAY TEXT(aODescpt; 0)
//  ARRAY REAL(aOQtyOrder; 0)
//  //
//  //
//  READ WRITE([Customer])
//  READ WRITE([Rep])
//  READ WRITE([Contact])
//  READ WRITE([Lead])
//  READ WRITE([Vendor])
//  ARRAY TEXT(aMinOrderMfgID; 0)
//  ARRAY REAL(aMinOrderValue; 0)
//  
//  
//  
//  
//  