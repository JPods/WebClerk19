//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-22T06:00:00Z)
// Method: Http_OrdFill
// Description 
// Parameters
// ----------------------------------------------------
// extractAsApplicable


//C_TEXT($myText; $myLnText)
//C_LONGINT($p; $theFile; $theField; $testFile; $pEnd; $w; $1; $pjitLn; $setUseBasePrice)
//C_POINTER($2; $ptShipTo)
//C_BOOLEAN($3)
//C_REAL($qty)
//C_TEXT(pvLnComment; $shipVia; $custPO; $needDate; $needTime; $myCommentProcess)
//C_TEXT($address1; $address2; $city; $state; $zip; $typeSaleDoc)
//CREATE RECORD([Order])
//ccNumber:=""
//ccExpires:=""
//ccName:=""
//ccZip:=""
//$typeSaleDoc:=""
////$shipComment:=WCapi_GetParameter("ShipComment";"")
//shipVia:=WCapi_GetParameter("shipVia"; "")
//$shipViaAuto:=""
//C_REAL($freightAutoPrice)
//// If (<>doAutoFreight)
//$p:=Position(shipVia; <>tcMONEYCHAR)
//If ($p>0)
//$shipViaAuto:=Substring(shipVia; 1; $p-1)
//$freightAutoPrice:=Num(Substring(shipVia; $p+1))
//End if 
//// End if 
//shipZip:=WCapi_GetParameter("shipZip"; "")
//$custPO:=WCapi_GetParameter("CustPO"; "")
//ccCardType:=WCapi_GetParameter("ccCardType"; "")
//ccNumber:=WCapi_GetParameter("ccNumber"; "")
//If ((ccCardType="") & (ccNumber#""))
//C_TEXT($firstCharacter)
//ccCardType:=CC_ReturnCardType(ccNumber)
//End if 
//ccExpires:=WCapi_GetParameter("ccExpires"; "")
//ccName:=WCapi_GetParameter("ccName"; "")
//ccZip:=WCapi_GetParameter("ccZip"; "")
//ccSecurityCode:=WCapi_GetParameter("ccSecurityCode"; "")
////$reverseWebTemp:=WCapi_GetParameter("CartOrder";"")
////
//$myCommentProcess:=WCapi_GetParameter("commentProcess"; "")
////
//[EventLog]qty:=0
//[Order]adSource:="Webclerk"
//myCycle:=3  // load customer data
////vHere:=3

//If ([EventLog]allyid#"")
//AllyFillTemplate(0)  //  push current Customers record and load in Ally data
//End if 

//C_LONGINT($repRecord; $employeeRecord)  //keep from losing who is processing the order
//$repRecord:=Record number([Rep])
//$employeeRecord:=Record number([Employee])
//NxPvOrders($3)  //build order with or without saving

//If ($repRecord>-1)  //keep from losing who is processing the order
//GOTO RECORD([Rep]; $repRecord)
//End if 
//If ($employeeRecord>-1)
//GOTO RECORD([Employee]; $employeeRecord)
//End if 

//If ((vWccTableNum=0) & (vWccPrimeRec>-1))
//GOTO RECORD(Table(vWccTableNum)->; vWccPrimeRec)  //make available
//End if 

//[Order]customerPO:=$custPO

//C_LONGINT($currentCustomerRecord)
//$currentCustomerRecord:=Record number([Customer])
//If (([EventLog]shipToTableNum>0) & ([EventLog]shipToRecordid>0))
//GOTO RECORD(Table([EventLog]shipToTableNum)->; [EventLog]shipToRecordid)  //xxxwdj###070627
//Case of 
//: ([EventLog]shipToTableNum=13)
//AddressOrderFill("shiptofromContact")
//: ([EventLog]shipToTableNum=Table(->[Vendor]))
//AddressOrderFill("shiptofromVendor")
//AddressOrderFill("billtofromVendor")
//: ([EventLog]shipToTableNum=Table(->[Rep]))
//AddressOrderFill("shiptofromRep")
//AddressOrderFill("billtofromRep")
//: ([EventLog]shipToTableNum=Table(->[Customer]))
//AddressOrderFill("shiptofromCustomer")
//AddressOrderFill("billtofromCustomer")
//End case 
//If ($currentCustomerRecord#Record number([Customer]))
//GOTO RECORD([Customer]; $currentCustomerRecord)
//End if 
//$ptShipTo:=Table([EventLog]shipToTableNum)
//If (False)  //set bill to feature some time
//GOTO RECORD([Contact]; [EventLog]shipToRecordid)
//[Order]billToCompany:=[Contact]company
//[Order]billToAttention:=[Contact]nameFirst+" "+[Contact]nameLast
//[Order]billToPhone:=[Contact]phone
//[Order]billToFAX:=[Contact]fax
//[Order]billToAddress1:=[Contact]address1
//[Order]billToAddress2:=[Contact]address2
//[Order]billToCity:=[Contact]city
//[Order]billToState:=[Contact]state
//[Order]billToZip:=[Contact]zip
//[Order]billToCountry:=[Contact]country
//[Order]billToEmail:=[Contact]email
//End if 
//End if 
//If (Record number([Employee])>-1)
//[Order]takenBy:=[Employee]nameID
//Else 
//[Order]takenBy:=[RemoteUser]userName
//End if 
//[Order]orderedBy:=[RemoteUser]userName
//WC_Parse(Table(->[Order]); $2; $3)
////
//If (vWccSecurity>0)
//$typeSaleDoc:=WCapi_GetParameter("TypeSaleDoc"; "")
//If ($typeSaleDoc#"")
//vUseBase:=SetPricePoint($typeSaleDoc)
//End if 
//End if 
//$setUseBasePrice:=vUseBase
////TRACE
//Case of 
//: ($shipViaAuto#"")
//[Order]shipVia:=$shipViaAuto
//: ((shipVia#"") & ([Order]shipVia#shipVia))
//[Order]shipVia:=shipVia
//: (([Order]shipVia="") & ([Customer]shipVia#""))
//[Order]shipVia:=[Customer]shipVia
//: ([Order]shipVia=Storage.default.shipVia)
////no action    
//Else 
//[Order]shipVia:=shipVia
//End case 
//If ($shipViaAuto#"")
//$w:=Find in array(<>aShipVia; [Order]shipVia)
//If ($w<1)
//[Order]shipVia:=Storage.default.shipVia
//End if 
////
//End if 
//shipVia:=[Order]shipVia
//C_TEXT(tcShipMissing; tcTaxMissing)
//If ((shipZip#"") & ([Order]zip#shipZip))
//[Order]zip:=shipZip
//End if 
//shipZip:=[Order]zip
////
//[Order]actionBy:="WebClerk"
//C_DATE($ordDate)
//myCycle:=0

//$w:=Find in array(<>aTaxJuris; [Order]taxJuris)
//Case of 
//: ([Customer]taxExemptid#"")
//tcTaxMissing:="Tax Exempt ID: "+[Customer]taxExemptid
//: ([Order]taxJuris="")
//tcTaxMissing:="No Tax Jurisdiction"
//: ($w>0)
//tcTaxMissing:="Tax Jurisidiction: "+[Order]taxJuris
//Else 
//tcTaxMissing:="Tax not calculated"
//End case 

//QUERY([WebTempRec]; [WebTempRec]idEventLog=vleventID; *)
//QUERY([WebTempRec];  & [WebTempRec]qtyOrdered#0; *)
//QUERY([WebTempRec];  & [WebTempRec]posted=False)
//$k:=Records in selection([WebTempRec])
//// ShoppingCartToArrays this is in TagsToDataBlock

//If ($k=0)  // if there are no line items reject the order
//$3:=False
//End if 
////If ($reverseWebTemp="101_-2@")
////ORDER BY([WebTempRec];[WebTempRec]UniqueID;<)
////End if 
//FIRST RECORD([WebTempRec])
////TRACE
//For ($i; 1; $k)
//$typeSaleLine:=""
//If ([WebTempRec]typeSale="")
//vUseBase:=$setUseBasePrice  //reset in each loop
//Else 
//vUseBase:=SetPricePoint([WebTempRec]typeSale)
//End if 
//$pQtyOrd:=[WebTempRec]qtyOrdered
//QUERY([Item]; [Item]itemNum=[WebTempRec]itemNum)
//pPartNum:=[Item]itemNum
//pDescript:=[WebTempRec]description
//pvLnComment:=[WebTempRec]comment
//If (([Item]reservation) & (<>vlCycleTime>0) & (<>vlCartTime>0))
//$pQtyOrd:=Reservation_Make($pQtyOrd; $3)
//End if 
//C_REAL($baseQty)
//$baseQty:=[Item]qtySaleDefault
//[Item]qtySaleDefault:=[WebTempRec]qtyOrdered  //do not save item
//viOrdLnCnt:=Size of array(aoLineAction)+1

//OrdLnAdd(viOrdLnCnt; 1; False)  //  $3 is false and it is extended below

//If (([Item]serialized) & ($3) & ([Item]location<0))
//Http_SerialIssue
//End if 
//aoLnComment{aoLineAction}:=[WebTempRec]comment
//aoProfile1{aoLineAction}:=[WebTempRec]profile1
//aoProfile2{aoLineAction}:=[WebTempRec]profile2
//aoProfile3{aoLineAction}:=[WebTempRec]profile3
//aODescpt{aoLineAction}:=[WebTempRec]description

//// Modified by: Bill James (2015-07-16T00:00:00 Doubling the discount)

//// 
//// Modified by: Bill James (2016-01-17T00:00:00 Removed the if(false) must allow overwrite)
//// If (False)  // Modified by: Bill James (2015-07-16T00:00:00 Doubling the discount)
//If (vWccPrimeRec>-1)
//// Modified by: William James (2014-06-11T00:00:00 Subrecord eliminated)
//aOUnitPrice{aoLineAction}:=[WebTempRec]discountedPrice
//pUnitPrice:=[WebTempRec]discountedPrice
//// Modified by: William James (2014-06-11T00:00:00 Subrecord eliminated)
//If ([WebTempRec]unitPrice=0)
//[WebTempRec]unitPrice:=[WebTempRec]discountedPrice
//End if 
//pDiscnt:=Discount_SetDiscount([WebTempRec]unitPrice; [WebTempRec]discountedPrice)
//pBasePrice:=[WebTempRec]unitPrice
//End if 
//// End if 
////
//If (pPartNum="zzzTemp@")
////TRACE
//C_LONGINT($theElement)
//$theElement:=Find in array(<>aMfg; [WebTempRec]mfrID)
//If ($theElement>0)
//aOLocation{aoLineAction}:=<>aMfgIdKey{$theElement}
//End if 
//aOAltItem{aoLineAction}:=[WebTempRec]mfrItemNum

//pDiscnt:=0
//aODiscnt{aoLineAction}:=0
//pUnitPrice:=[WebTempRec]discountedPrice
//aOUnitPrice{aoLineAction}:=pUnitPrice
//// Modified by: William James (2014-06-11T00:00:00 Subrecord eliminated)
//If ([WebTempRec]unitPrice=0)
//[WebTempRec]unitPrice:=[WebTempRec]discountedPrice
//End if 
//pBasePrice:=[WebTempRec]unitPrice
//pDiscnt:=Discount_SetDiscount([WebTempRec]unitPrice; [WebTempRec]discountedPrice)
//[WebTempRec]discount:=pDiscnt
//aOUnitCost{aoLineAction}:=[WebTempRec]cost
//aOQtyOrder{aoLineAction}:=[WebTempRec]qtyOrdered
//End if 

//[EventLog]qty:=[EventLog]qty+[WebTempRec]qtyOrdered
////TRACE
//If (vWccSecurity>0)
//aOTaxable{aoLineAction}:=aOTaxable{aoLineAction}*Num([WebTempRec]taxExempt=False)
//End if 
//OrdLnExtend(aoLineAction)
//If ([WebTempRec]adds#"")  //must be after the regular line is extended
//Http_ItemAdds(pvItemNum; [WebTempRec]adds; $pQtyOrd; aoLineAction)
//End if 

//// Modified by: Bill James (2016-11-24T00:00:00)

//// removed the if
//// If ([WebTempRec]ExtendedPrice=0)
//[WebTempRec]extendedPrice:=aOExtPrice{aoLineAction}
//SAVE RECORD([WebTempRec])
//// End if 
//NEXT RECORD([WebTempRec])
//End for 
////TRACE
////If ([Order]Zone<1)
//If ($shipViaAuto#"")
//[Order]autoFreight:=False
//[Order]shipMiscCosts:=0
//[Order]shipAdjustments:=0
//[Order]shipFreightCost:=$freightAutoPrice
//Else 
//Find Ship Zone(->[Order]zip; ->[Order]zone; ->[Order]shipVia; ->[Order]country; ->[Order]siteID)
//End if 
////End if 
//C_BOOLEAN($doReCalc)
//$doReCalc:=False


//booAccept:=True
//vMod:=calcOrder(vMod)
//XML_FedExRateRequest


//If (<>vWebCustBalMaxOrd=1)
//PUSH RECORD([Order])
//Ledger_TallyBal(False; False)
//SAVE RECORD([Customer])

//POP RECORD([Order])
//End if 
////TRACE
//pvHalfTotal:=Round([Order]total/2; 2)
//pSumBalance:=-([Customer]balanceTotalExposure+[Order]total)
//If ((pSumBalance<0) & (<>vWebCustBalMaxOrd=1))
//$3:=False
//vResponse:="Value of Order Exceeds Current Balance: "+pvSumBalance
//End if   //CuImportCSVFujitsu

//If (([Order]shipVia="") | ([Order]zone=-1))
//tcShipMissing:="Shipping not estimated"
//Else 
//tcShipMissing:="Shipping estimated"
//End if 
//////
//[EventLog]carrier:=[Order]shipVia
//[EventLog]zip:=[Order]zip
//If ([EventLog]idNum#0)
//SAVE RECORD([EventLog])
//End if 

//If ($3)
//vMod:=True
//booAccept:=True
////
//Before_New(->[Order])
//acceptOrders
////  



//If (<>CashDrawerOpen>0)
//CashDrawerOpen
//WC_LogEvent("CashDrawerOpen"; "true")
//End if 

////TRACE
////[Order]Terms:="Instore"
//[Order]idEventLog:=[EventLog]id
//If ([Order]idNum>0)
//SAVE RECORD([Order])
//Else 
//[EventLog]areYouHuman:="zeroOrder"
//EventLogsMessage("Trying to save a zero Order http_OrdFill.")
//End if 
////

//$splitOrders:=WCapi_GetParameter("SplitOrders"; "")
//If (($splitOrders="t@") & (vWccSecurity>0))

//$doc2Print:=WCapi_GetParameter("Doc2Print"; "")
//OrdLnFillRays
//Ord2MfgOrd
//FIRST RECORD([Order])
////TRACE
//If ($doc2Print#"")

//WC_LogEvent("$doc2Print"; $doc2Print)

//QUERY([UserReport]; [UserReport]name=$doc2Print)
//If (Records in selection([UserReport])#1)
//vResponse:="To print, there must be one and only one UserReport: "+$doc2Print
//Else 
//CREATE SET([Order]; "P_Current")
//Prnt_ReportOpts

//WC_LogEvent("Prnt_ReportOpts"; "true")

//USE SET("P_Current")
//CLEAR SET("P_Current")
//End if 
//End if 
//Else 
//$eventID:=obEventLog.id  // can get unloaded in the printing process
//$emailConfirm:=WCapi_GetParameter("EmailConfirm"; "")
//If ($emailConfirm#"N@")
//Http_OrderConfirm($1; "WebClerk_NewOrder")

//WC_LogEvent("$emailConfirm"; "true")

//End if 
//If (<>vtcAutoPrint>0)
//ptCurTable:=(->[Order])
//vHere:=1
//Print_Auto(->[Order])
//WC_LogEvent("Print_Auto"; "true")
//vHere:=0
//End if 
//If ($eventID#[EventLog]idNum)  // can get unloaded in the printing process
//QUERY([EventLog]; [EventLog]idNum=$eventID)
//End if 
//End if 

//// RP_SOtoPOtoVendorSO
//// ### bj ### 20190125_2209
//Execute_TallyMaster("WebOrderSave"; "webscript")

////

//QUERY([WebTempRec]; [WebTempRec]idEventLog=vleventID)
//FIRST RECORD([WebTempRec])
//$cntTemp:=Records in selection([WebTempRec])

//If ([Order]lineCount#$cntTemp)
//QUERY([OrderLine]; [OrderLine]idNumOrder=[Order]idNum)
//End if 
//WC_LogEvent("Count-[Orderline]"; String(Records in selection([OrderLine])))
//WC_LogEvent("Count-[WebTempRec]"; String($cntTemp))

//C_LONGINT($incTemp; $cntTemp)
//FIRST RECORD([WebTempRec])
//For ($incTemp; 1; $cntTemp)
//// [WebTempRec]Company filled when created   Http_PostOrd2
//[WebTempRec]posted:=True
//[WebTempRec]tableNum:=3
//[WebTempRec]idNumOrder:=[Order]idNum
//SAVE RECORD([WebTempRec])
//NEXT RECORD([WebTempRec])
//End for 


////C_TEXT($eventID)
//C_LONGINT($eventID)
//$eventID:=obEventLog.id
//[EventLog]dateComplete:=Current date
//[EventLog]company:=[Order]company
//[Order]customerID:=[Order]customerID

//WC_LogEvent("customerID"; [Order]customerID)
//WC_LogEvent("Company"; [Order]company)
//WC_LogEvent("OrderNum"; String([Order]idNum))
//WC_LogEvent("Http_OrdFill"; "Closing eventID")



//// ### bj ### 20181115_1546
//WC_EventLogReplace("Http_OrdFill")

////  WC_DupicateEventLog is replaced by WC_EventLogReplace

//// this might have been the defect sending the [EventLog] into another realm
//// why is this here ?????
//// C_TEXT($theScript)
//// $theScript:="QUERY([EventLog];[EventLog]eventID="+Txt_Quoted (String(vleventID))+")"
//// $childProcess:=New process("ExecuteText";<>tcPrsMemory;String(Count user processes)+"-"+Table name(<>ptCurTable);0;$theScript)

//End if 

//// tasks require whether saved or not


//vMod:=False
//booAccept:=False
//Case of 
//: ((<>tcDotted="internal@") & ([Customer]terms="CC_SSLSecure@"))  //|([Lead]Terms="CC_SSLSecure@"))
//tcPayPath:=tcSSLSecure+"/pay_Ord"+"_"+<>tcSSLUser+"_"+<>tcDotted  //+"*jitxUser="+String(vleventID)+"*"
//: ((<>tcDotted="internal@") & ([Customer]terms="TC_SSLSecure@"))
//tcPayPath:=tcSSLSecure+"/pay_Ord"+"_"+<>tcSSLUser+"_"+<>tcDotted  //+"*jitxUser="+String(vleventID)+"*"
//: ([Customer]terms="CC_SSLSecure@")  //|([Lead]Terms="CC_SSLSecure@"))
//tcPayPath:=tcSSLSecure+"/pay_SSLTrap"+"_"+<>tcSSLUser+"_"+<>tcDotted  //+"*jitxUser="+String(vleventID)+"*"
//Else 
//tcPayPath:="/pay_Ord"  //*jitxUser="+String(vleventID)+"*"
//End case 
////
//If ([Order]idNum>0)
//QUERY([OrderLine]; [OrderLine]idNumOrder=[Order]idNum)
//End if 