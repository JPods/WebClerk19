//%attributes = {"publishedWeb":true}
//Procedure: Http_CloneOrd
//  C_TEXT($txtPage; $txtPart; $text2Send)
//  C_REAL($runQty; $qty; $runPrice; $unitPrice; $extPrice)
//  C_TEXT(vText1; vText2; vText3; vText4; vText5; vText6; vText7; vText8; vText9; vText10)
//  C_LONGINT($err; $pTest; $i; $k; $w)
//  C_LONGINT($1)
//  C_POINTER($2)
//  //
//  C_LONGINT($p; $theFile; $theField; $testFile)
//  READ ONLY([Customer])
//  READ ONLY([RemoteUser])
//  READ ONLY([Order])
//  READ ONLY([Item])
//  //
//  pPayAmount:=0
//  pBalance:=0
//  
//  TRACE
//  vText9:=""
//  C_LONGINT($1; $err; $orderNum)
//  C_POINTER($2)
//  $doError:=True
//  If (<>viOrdStatus>0)
//  
//  If ([EventLog]remoteUserRec>-1)  //|(([EventLog]FileNum>0)&([EventLog]CustomerRecNum>-1)))    
//  GOTO RECORD([RemoteUser]; [EventLog]remoteUserRec)
//  If ([EventLog]tableNum=2)
//  GOTO RECORD([Customer]; [EventLog]customerRecNum)
//  //zttp_UserGet 
//  If (Record number([Customer])>-1)
//  $doError:=False
//  //
//  $doCount:=3
//  C_LONGINT($ordNum; $doCount)
//  $ordNum:=Num(WCapi_GetParameter("OrderNum"; ""))
//  If ($ordNum>0)
//  QUERY([Order]; [Order]orderNum=$ordNum)
//  If (([Order]salesNameID#"CloneAllowed") & ([Order]customerID#[Customer]customerID))
//  REDUCE SELECTION([Order]; 0)
//  End if 
//  $doCount:=1
//  End if 
//  //        
//  If (Records in selection([Order])=0)
//  QUERY([Order]; [Order]customerID=[Customer]customerID)
//  End if 
//  If (Records in selection([Order])=0)
//  vResponse:="There are no orders to clone."
//  $err:=WC_PageSendWithTags($1; WC_DoPage("Error.html"; ""); 0)
//  Else 
//  $txtPage:=WC_PageLoad(WC_DoPage("OrdersClone.html"; ""))
//  $p:=Position("_jit_begin_4_1jj"; $txtPage)
//  $pEqual:=Position("_jit_end_jj"; $txtPage)
//  vText5:=Substring($txtPage; 1; $p-1)
//  //
//  
//  vText5:=TagsToText(vText5)
//  $err:=TCP Send($1; vText5)  //send the top of the page
//  $vtPageLines:=Substring($txtPage; ($p+16); ($pEqual-1-$p-16))
//  vText6:=Substring($txtPage; $pEqual+11)  //Get the end of the page          
//  $doError:=False
//  $k:=Records in selection([Order])
//  If ($k>3)
//  SELECTION RANGE TO ARRAY($k-2; $k; [Order]orderNum; aTmpLong1)
//  $k:=3
//  Else 
//  SELECTION TO ARRAY([Order]orderNum; aTmpLong1)
//  End if 
//  $ord1:=0
//  $ord2:=0
//  $ord3:=0
//  If ($k>0)
//  QUERY([OrderLine]; [OrderLine]orderNum=aTmpLong1{1}; *)
//  $ord1:=aTmpLong1{1}
//  If ($k>1)
//  QUERY([OrderLine];  | [OrderLine]orderNum=aTmpLong1{2}; *)
//  $ord2:=aTmpLong1{2}
//  If ($k>2)
//  QUERY([OrderLine];  | [OrderLine]orderNum=aTmpLong1{3}; *)
//  $ord3:=aTmpLong1{3}
//  End if 
//  End if 
//  QUERY([OrderLine])
//  End if 
//  ARRAY LONGINT(aTmpLong1; 0)
//  SELECTION TO ARRAY([OrderLine]itemNum; aOItemNum; [OrderLine]orderNum; aoLineAction; [OrderLine]qty; aOQtyOrder; [OrderLine]location; aOLocation)
//  REDUCE SELECTION([OrderLine]; 0)
//  REDUCE SELECTION([Order]; 0)
//  SORT ARRAY(aoLineAction; aOItemNum; aOQtyOrder; aOLocation; <)
//  // ArraySort(aoLineAction;"<";aOItemNum;"<";aOQtyOrder;">";aOLocation;"=")
//  ARRAY TEXT(aTmp35Str1; 0)
//  ARRAY LONGINT(aTmpLong2; 0)
//  ARRAY REAL(aTmpReal1; 0)
//  ARRAY REAL(aTmpReal2; 0)
//  ARRAY REAL(aTmpReal3; 0)
//  $text2Send:=""
//  $k:=Size of array(aoLineAction)
//  For ($i; 1; $k)
//  $w:=Find in array(aTmp35Str1; aOItemNum{$i}; 1)
//  If ($w=-1)
//  INSERT IN ARRAY(aTmpReal1; 1; 1)
//  INSERT IN ARRAY(aTmpReal2; 1; 1)
//  INSERT IN ARRAY(aTmpReal3; 1; 1)
//  INSERT IN ARRAY(aTmpLong2; 1; 1)
//  INSERT IN ARRAY(aTmp35Str1; 1; 1)
//  aTmpLong2{1}:=aOLocation{$i}
//  aTmp35Str1{1}:=aOItemNum{$i}
//  $w:=1
//  End if 
//  Case of 
//  : (aoLineAction{$i}=$ord1)
//  aTmpReal1{$w}:=aOQtyOrder{$i}
//  : (aoLineAction{$i}=$ord2)
//  aTmpReal2{$w}:=aOQtyOrder{$i}
//  : (aoLineAction{$i}=$ord3)
//  aTmpReal3{$w}:=aOQtyOrder{$i}
//  End case 
//  End for 
//  ARRAY LONGINT(aoLineAction; 0)
//  ARRAY TEXT(aOItemNum; 0)
//  ARRAY LONGINT(aOLocation; 0)
//  //ArraySort (aTmpLong2;">";aTmp35Str1;">";aTmpReal1;"=";aTmpReal2;"=";aTmpReal3;"=")
//  MULTI SORT ARRAY(aTmpLong2; >; aTmp35Str1; >; aTmpReal1; aTmpReal2; aTmpReal3)
//  $k:=Size of array(aTmpLong2)
//  ARRAY REAL(aTmpReal4; $k)
//  $runQty:=0
//  $runPrice:=0
//  //
//  vUseBase:=SetPricePoint([Customer]typeSale)
//  For ($i; 1; $k)
//  aTmpReal4{$i}:=Round((aTmpReal1{$i}+aTmpReal2{$i}+aTmpReal3{$i})/$doCount; 0)
//  QUERY([Item]; [Item]itemNum=aTmp35Str1{$i})
//  If (Records in selection([Item])=1)
//  pvItemNum:=[Item]itemNum
//  pvDescription:=[Item]description
//  pvQtyOrd:=String(aTmpReal4{$i})
//  pDiscnt:=OrdSetDiscount(aTmpReal4{$i})
//  $unitPrice:=Field(4; vUseBase)->
//  $discntPrc:=DiscountApply($unitPrice; pDiscnt; <>tcDecimalUP)
//  $extPrice:=Round($discntPrc*aTmpReal4{$i}; <>tcDecimalTt)
//  $runPrice:=$runPrice+$extPrice
//  $runQty:=$runQty+aTmpReal4{$i}
//  pvBasePrice:=String($unitPrice; <>tcFormatUP)
//  pvUnitPrice:=String($discntPrc; <>tcFormatUP)
//  pvDiscount:=String(pDiscnt; "##0.0")
//  pvExtPrice:=String($extPrice; <>tcFormatTt)
//  pvExtPrice:=String($extPrice; <>tcFormatTt)
//  pvLnProfile1:=String(Round(aTmpReal1{$i}; 0))
//  pvLnProfile2:=String(Round(aTmpReal2{$i}; 0))
//  pvLnProfile3:=String(Round(aTmpReal3{$i}; 0))
//  vText4:=$vtPageLines
//  vText4:=TagsToText(vText4)
//  $text2Send:=$text2Send+vText4
//  End if 
//  End for 
//  [EventLog]qty:=$runQty
//  [EventLog]value:=$runPrice
//  EventLogsMessage(voState.url+" Order: "+String([Order]orderNum))
//  If ([EventLog]idNum#0)
//  SAVE RECORD([EventLog])
//  End if 
//  UNLOAD RECORD([Item])
//  //$txtPage:=$txtPage+$text2Send
//  vText1:=String(Round($runQty; 4); "###,###,##0.###,###")
//  vText2:=String(Round($runPrice; <>tcDecimalTt); <>tcFormatTt)
//  vText3:=""
//  vText5:=""
//  vText8:=""
//  $err:=TCP Send($1; $text2Send)
//  vText6:=TagsToText(vText6)
//  $err:=TCP Send($1; vText6)
//  // send the file if method = GET (so that we also support method = HEAD)
//  
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
//  //          
//  ARRAY REAL(aTmpReal1; 0)
//  ARRAY REAL(aTmpReal2; 0)
//  ARRAY REAL(aTmpReal3; 0)
//  ARRAY LONGINT(aTmpLong2; 0)
//  ARRAY TEXT(aTmp35Str1; 0)
//  End if 
//  End if 
//  End if 
//  End if 
//  End if 
//  READ WRITE([Item])
//  READ WRITE([RemoteUser])
//  READ WRITE([Customer])
//  READ WRITE([Order])
//  If ($doError)
//  vResponse:=""
//  If (<>viOrdStatus=0)
//  vResponse:=vResponse+"Cloning not allowed"+"\r"
//  End if 
//  If ([EventLog]remoteUserRec=-1)
//  vResponse:=vResponse+"You must be signed in to clone orders"+"\r"
//  End if 
//  If ([EventLog]tableNum#2)
//  If ([EventLog]tableNum=0)
//  vResponse:=vResponse+"Must be a customer to clone orders.  You are not currently signed in."+"\r"
//  Else 
//  vResponse:=vResponse+"Must be a customer to clone orders, remote user relates to :"+Table name([EventLog]tableNum)+"\r"
//  End if 
//  End if 
//  $err:=WC_PageSendWithTags($1; WC_DoPage("Error.html"; ""); 0)
//  End if 