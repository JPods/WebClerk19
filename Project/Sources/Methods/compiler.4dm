//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/19/12, 14:58:57
// ----------------------------------------------------
// Method: .compiler
// Description
// 
//
// Parameters
// ----------------------------------------------------
//Hide warning: Pointer in COPY ARRAY  (518.1)  
//%W-518.1 
//Hide warning: Pointer in SELECTION TO ARRAY(518.2)  
//%W-518.2 
//Hide warning: Pointer in an array delcaration (518.5)  

//%W-518.6 
//Hide warning: This method is protected by a password.  (518.8)
//%W-518.8 
//Hide warning: Pointer in DISTINCT VALUES.  (518.10)
//%W-518.10 
//Hide warning: Assumes that the array index is type real.  (533.3)
//%W-533.3   //
//Hide warning: Missing parameter in the plug-in procedure call.  (533.4)
//%W-533.4   //
//Hide warning: Assumes that the pointer points to an alphanumeric expression  (533.1)
//%W-533.1
Compiler_A_I
Compiler_C_P
// ### jwm ### 20171109_1154 new contacts popups
ARRAY TEXT:C222(<>aContactsProfile1; 0)
ARRAY TEXT:C222(<>aContactsProfile2; 0)
ARRAY TEXT:C222(<>aContactsProfile3; 0)
ARRAY TEXT:C222(<>aContactsProfile4; 0)
ARRAY TEXT:C222(<>aContactsProfile5; 0)

C_POINTER:C301(ptCurTable)
C_LONGINT:C283(curTableNum)
C_LONGINT:C283(pSeq)
// ### bj ### 20181201_1134  delete this variable
C_LONGINT:C283(changerecord)
C_TEXT:C284(reportName)
C_TEXT:C284(<>aTaxWebService)
ARRAY TEXT:C222(dChangeBy; 0)
//
C_TEXT:C284(vResponseCum)
//
C_TEXT:C284(vLabel001; vLabel002; vLabel003; vLabel004; vLabel005; vLabel006; vLabel007; vLabel008; vLabel009; vLabel010; vLabel011; vLabel012; vLabel013; vLabel014; vLabel015; vLabel016; vLabel017; vLabel018; vLabel019; vLabel020; vLabel021; vLabel022; vLabel023; vLabel024; vLabel025; vLabel026; vLabel027; vLabel028; vLabel029; vLabel030; vLabel031; vLabel032; vLabel033; vLabel034; vLabel035; vLabel036; vLabel037; vLabel038; vLabel039; vLabel040; vLabel041; vLabel042; vLabel043; vLabel044; vLabel045; vLabel046; vLabel047; vLabel048; vLabel049; vLabel050; vLabel051; vLabel052; vLabel053; vLabel054; vLabel055; vLabel056; vLabel057; vLabel058; vLabel059; vLabel060; vLabel061; vLabel062; vLabel063; vLabel064; vLabel065; vLabel066; vLabel067; vLabel068; vLabel069; vLabel070; vLabel071; vLabel072; vLabel073; vLabel074; vLabel075; vLabel076; vLabel077; vLabel078; vLabel079; vLabel080; vLabel081; vLabel082; vLabel083; vLabel084; vLabel085; vLabel086; vLabel087; vLabel088; vLabel089; vLabel090; vLabel091; vLabel092; vLabel093; vLabel094; vLabel095; vLabel096; vLabel097; vLabel098; vLabel099; vLabel100; vLabel101; vLabel102; vLabel103; vLabel104; vLabel105; vLabel106; vLabel107; vLabel108; vLabel109; vLabel110)
ARRAY LONGINT:C221(<>aiCORLWide1; 0)
ARRAY LONGINT:C221(<>aiCORLSort1; 0)
C_LONGINT:C283(<>vlCORLLock1)
C_LONGINT:C283(eLoadTagsOrders; eLoadItemsOrders)
ARRAY TEXT:C222(aCustPO; 0)
C_BOOLEAN:C305(<>ProcessAll)
ARRAY TEXT:C222(<>APREFNAMES; 0)
ARRAY TEXT:C222(<>APREFVALUES; 0)
ARRAY TEXT:C222(<>APREFVALUES; 0)
C_TEXT:C284(<>PREFSPATH)
C_LONGINT:C283(<>vlRecNum; <>orderPacking; <>vWindowOverRide)
C_LONGINT:C283(<>webEngine)
//
C_TEXT:C284(vSearchBy)
C_TEXT:C284(vSearchBy2)
C_BOOLEAN:C305(<>logDetails)
//
C_TEXT:C284(pPricePt)
C_TEXT:C284(pvRecordReturn)
C_LONGINT:C283(pvRecordNum)
C_TEXT:C284(pDescript)

C_TEXT:C284(pReferNum)
C_TEXT:C284(ptaxID)
//

C_DATE:C307(vDateCRCompleted)
C_TIME:C306(vTimeCRCompleted)
ARRAY TEXT:C222(aTmpText1; 0)
HIDE TOOL BAR:C434

C_TEXT:C284(fExUnExPrice)
C_BOOLEAN:C305(<>allowZip; Is macOS:C1572; $doFirst)
C_REAL:C285(vrLo1; vrLo2; vrLo3; vrLo4; vrLo5; vrLo6; vrLo7)
C_LONGINT:C283($plat; $sys; $mach)
C_LONGINT:C283(<>viDelayPrss)
//
C_LONGINT:C283(viEndUserSecurityLevel; <>viDebugMode)
//C_TEXT(<>viErrText)
C_DATE:C307(d06Begin; d06Complete; d06End; d06Enter)
C_TEXT:C284(pvDocPhone)
C_TEXT:C284(variable1; variable2; variable3; variable4; variable5; variable6; variable7; variable8; variable9; variable10)

ARRAY LONGINT:C221(theFldNum; 0)
ARRAY TEXT:C222(aXItemNum; 0)
ARRAY TEXT:C222(aWdReason; 0)
ARRAY TEXT:C222(<>aLaunchSuff; 0)
ARRAY TEXT:C222(<>aLaunchApp; 0)
ARRAY TEXT:C222(<>aLaunchCrea; 0)
ARRAY TEXT:C222(<>aFScCover; 0)
C_TEXT:C284(pvSerial; pvTermState)
C_LONGINT:C283(SRWindow)  //required to zoom window
C_DATE:C307(SRDate)
C_BOOLEAN:C305(<>vRep)
ARRAY TEXT:C222(aElectroZip; 0)
C_REAL:C285(vTimeTotal)
ARRAY TEXT:C222(<>aSrchCode; 0)
//C_LONGINT(SRpage;SRRecord;SRTime)
C_TEXT:C284(<>vProfile1; <>vProfile2; <>vProfile3; <>vProfile4; <>vProfile5; <>vProfile6; <>vProfile7)
C_TEXT:C284(<>tcPriceLvlD; <>tcPriceLvlC; <>tcPriceLvlB; <>tcPriceLvlA)
C_TEXT:C284(vPartNum)
C_TEXT:C284(vPartDesc)
C_TEXT:C284(srItemNum)
ARRAY TEXT:C222(aOOgItem; 0)
ARRAY TEXT:C222(aItemNum; 0)
C_LONGINT:C283(zzz)
ARRAY TEXT:C222(<>aPrsName; 0)
ARRAY LONGINT:C221(<>aPrsNum; 0)
//
ARRAY LONGINT:C221(<>aItemLines; 0)  //transfer items from QuickQuote
//
ARRAY TEXT:C222(aLsDocType; 0)
ARRAY TEXT:C222(aElectroZip; 0)
ARRAY TEXT:C222(SRVarNames; 0)
ARRAY TEXT:C222(aContact; 0)
ARRAY TEXT:C222(<>aTypeSale; 0)  //popup arrays
ARRAY TEXT:C222(<>aTypeSale; 0)
ARRAY LONGINT:C221(<>aTypeSaleNum; 0)  //default price number
ARRAY TEXT:C222(<>aTerms; 0)
ARRAY TEXT:C222(<>aProspect; 0)
ARRAY TEXT:C222(<>aNeed; 0)
ARRAY TEXT:C222(<>aProfile1; 0)
ARRAY TEXT:C222(<>aProfile2; 0)
ARRAY TEXT:C222(<>aProfile3; 0)
ARRAY TEXT:C222(<>aProfile4; 0)
ARRAY TEXT:C222(<>aProfile5; 0)
ARRAY TEXT:C222(<>aJobType; 0)
//
//array TEXT(aAction;0)
ARRAY TEXT:C222(<>aNoteType; 0)
ARRAY TEXT:C222(<>aSalutation; 0)
//
ARRAY TEXT:C222(<>aShipVia; 0)
ARRAY TEXT:C222(<>aReps; 0)
ARRAY TEXT:C222(<>aComNameID; 0)
ARRAY TEXT:C222(<>aNameID; 0)
ARRAY TEXT:C222(<>aScripts; 0)  // complained of changing string size
ARRAY TEXT:C222(<>aAdSources; 0)
ARRAY TEXT:C222(<>aStdOrdCom; 0)
//

ARRAY TEXT:C222(<>aFields; 0; 0)  //create 2D array of file/field name
ARRAY TEXT:C222(<>aTypes; 0; 0)  //create 2D array for of field/type
//array TEXT(aIndexes;0;0)
//
ARRAY TEXT:C222(<>aStdOrdCom; 0)  //startup arrays
ARRAY TEXT:C222(<>aNameID; 0)
ARRAY TEXT:C222(<>aComNameID; 0)
ARRAY TEXT:C222(<>aScripts; 0)
//
ARRAY TEXT:C222(<>aProcesses; 0)
ARRAY LONGINT:C221(<>aProcessNums; 0)
//
C_BOOLEAN:C305(<>vbDoSrlNums)
//
ARRAY TEXT:C222(aSPOItmAlph; 0)
ARRAY TEXT:C222(aSPOItmDesc; 0)
ARRAY TEXT:C222(aSPOSerialN; 0)
ARRAY TEXT:C222(aSPOModelN; 0)
ARRAY LONGINT:C221(aSPOPOLnNum; 0)
ARRAY BOOLEAN:C223(aSPOOnFP; 0)
ARRAY TEXT:C222(aSPOFPlanID; 0)
ARRAY LONGINT:C221(aSPOFPLnNum; 0)
ARRAY DATE:C224(aSPOFPExpir; 0)
ARRAY LONGINT:C221(aSPOFPPONum; 0)
ARRAY TEXT:C222(aSPOFPVndID; 0)
ARRAY TEXT:C222(aPages; 0)

ARRAY REAL:C219(aExUnitPrc; 0)
ARRAY REAL:C219(aExExtPrc; 0)
ARRAY REAL:C219(aExUnitCost; 0)
ARRAY REAL:C219(aExExtCost; 0)
ARRAY REAL:C219(aExBackLog; 0)
ARRAY REAL:C219(aExTaxIn; 0)
ARRAY REAL:C219(aExTaxOut; 0)
ARRAY REAL:C219(aExComSale; 0)
ARRAY REAL:C219(aExComRep; 0)
//
//ARRAY REAL(aInvTotal;0)//from adding and applying cash -- Customer File
//ARRAY REAL(aAmtApp;0)
//ARRAY REAL(aDscnt;0)
//ARRAY REAL(aCheckApp;0)
//ARRAY REAL(aCheckTotal;0)
//
ARRAY TEXT:C222(aAttributes; 0)
ARRAY TEXT:C222(aAttCodes; 0)
ARRAY LONGINT:C221(aAttNums; 0)
ARRAY TEXT:C222(aCauses; 0)
//
ARRAY TEXT:C222(aCostAcct; 0)
ARRAY TEXT:C222(aInvAcct; 0)
ARRAY TEXT:C222(aSalesAcct; 0)

ARRAY REAL:C219(aCost; 0)
//
ARRAY TEXT:C222(aPartNum; 0)
ARRAY TEXT:C222(aPartDesc; 0)
ARRAY REAL:C219(aQtySold; 0)  //Report Daily Sales by Item

ARRAY TEXT:C222(aRptPartNum; 0)  //Report Monthly Sales by Item
//
ARRAY TEXT:C222(aMatchField; 0)  //Importing/Exporting Arrays
ARRAY TEXT:C222(aMatchType; 0)
ARRAY LONGINT:C221(aMatchNum; 0)
ARRAY TEXT:C222(theFields; 0)
ARRAY TEXT:C222(aImpFields; 0)
ARRAY LONGINT:C221(aCntMatFlds; 0)
ARRAY LONGINT:C221(aCntImpFlds; 0)
ARRAY TEXT:C222(aBullets; 0)
ARRAY TEXT:C222(theUniques; 0)
//
ARRAY REAL:C219(aGrafData; 0)
//
ARRAY REAL:C219(aSaleNplan; 0)  //Items iLo Normalized arrays
ARRAY REAL:C219(aSaleNact; 0)
ARRAY REAL:C219(aQtyNplan; 0)
ARRAY REAL:C219(aQtyNact; 0)
ARRAY REAL:C219(aInvNplan; 0)
ARRAY REAL:C219(aInvNact; 0)
ARRAY REAL:C219(aScpNplan; 0)
ARRAY REAL:C219(aScpNact; 0)
ARRAY REAL:C219(aCapN; 0)
//
ARRAY REAL:C219(aSalesPlan; 0)  //Items iLo actual arrays
ARRAY REAL:C219(aSalesAct; 0)
ARRAY REAL:C219(aQtyPlan; 0)
ARRAY REAL:C219(aQtyAct; 0)
ARRAY REAL:C219(aInvenPlan; 0)
ARRAY REAL:C219(aInvenAct; 0)
ARRAY REAL:C219(aScrpPlan; 0)
ARRAY REAL:C219(aScrpAct; 0)
ARRAY REAL:C219(aCapacity; 0)
//
ARRAY TEXT:C222(aX; 0)  //graffing usage
ARRAY REAL:C219(aY1; 0)
ARRAY REAL:C219(aY2; 0)
ARRAY REAL:C219(aY3; 0)
ARRAY REAL:C219(aY4; 0)
//
//array TEXT(acShipCo;0)//setShipArray for Orders and Invoices
// Shipping options
//array TEXT(acShipAddr1;0)
//array TEXT(acShipCity;0)
//array TEXT(acShipLast;0)
//array TEXT(acShipFirst;0)
//ARRAY LONGINT(acShipRec;0)
//
ARRAY TEXT:C222(aComNames; 0)  //temp display array
//
ARRAY TEXT:C222(aCustomers; 0)  //use in Selecting Customers
ARRAY TEXT:C222(aCustCity; 0)
ARRAY TEXT:C222(aCustZip; 0)
ARRAY TEXT:C222(aCustPhone; 0)
ARRAY TEXT:C222(aCustAcct; 0)
ARRAY TEXT:C222(aCustRep; 0)
ARRAY TEXT:C222(aCustSales; 0)
ARRAY TEXT:C222(aCustCodes; 0)
//
ARRAY TEXT:C222(aCustType; 0)
ARRAY TEXT:C222(aCustAttn; 0)
ARRAY LONGINT:C221(aRecNum; 0)
//
ARRAY LONGINT:C221(aOpenOrders; 0)  //use in Selecting Orders to Invoice Arrays
ARRAY DATE:C224(aNeedDates; 0)
ARRAY DATE:C224(aComDates; 0)
ARRAY LONGINT:C221(aSelRecs; 0)
//
ARRAY POINTER:C280(arrformat; 0)
//
ARRAY TIME:C1223(aServiceTime; 0)
ARRAY DATE:C224(aServiceDate; 0)
ARRAY TEXT:C222(aServiceAction; 0)
ARRAY TEXT:C222(aServiceVariable; 0)
ARRAY TEXT:C222(aCustCodes; 0)


//
ARRAY TEXT:C222(a20Str1; 0)
ARRAY TEXT:C222(a20Str2; 0)
ARRAY TEXT:C222(a20Str3; 0)
ARRAY TEXT:C222(a20Str4; 0)
ARRAY TEXT:C222(a20Str5; 0)
ARRAY TEXT:C222(a20Str6; 0)
ARRAY TEXT:C222(a20Str7; 0)
ARRAY TEXT:C222(a20Str8; 0)
ARRAY TEXT:C222(a20Str9; 0)
ARRAY TEXT:C222(a20Str10; 0)
//
ARRAY TEXT:C222(a80Str1; 0)
ARRAY TEXT:C222(a80Str2; 0)
//
ARRAY TEXT:C222(aLetters; 0)
//
ARRAY TEXT:C222(aWhens; 0)
ARRAY TEXT:C222(aWhys; 0)
ARRAY TEXT:C222(aRptNames; 0)
ARRAY LONGINT:C221(aLongInt1; 0)
//
//
//array TEXT(aFCItem;0)
//array TEXT(aFCDesc;0)
//ARRAY DATE(aFCActionDt;0)
//ARRAY REAL(aFCBomCnt;0)
//ARRAY REAL(aFCRunQty;0)
//ARRAY REAL(aFCBaseQty;0)
//ARRAY REAL(aFCBaseQty;0)
//array TEXT(aFCBomLevel;0)
//array TEXT(aFCParent;0)
//array TEXT(aFCTypeTran;0)
//ARRAY LONGINT(aFCDocID;0)
//ARRAY LONGINT(aFCRecNum;0)
//ARRAY TEXT(aFCWho;0)
//ARRAY REAL(aFCTallyLess2Year;0)
//ARRAY REAL(aFCTallyLess1Year;0)
//ARRAY REAL(aFCTallyYTD;0)
//
////
//ARRAY LONGINT(aOrdLnSel;0)
////
//ARRAY LONGINT(aPLineAction;0)
//array TEXT(aPUse;0)
//ARRAY REAL(aPQtyOpen;0)
//ARRAY LONGINT(aPPQDiR;0)
////
//ARRAY LONGINT(aliRefID1;0)////PrpLine]ProposalKey
//array TEXT(aStr20Ref1;0)////PrpLine]Status
//ARRAY LONGINT(aintRef1;0)////PrpLine]Probability
//ARRAY BOOLEAN(aPBooUse;0)////PrpLine]Use
//array TEXT(aPItemNum;0)////PrpLine]ItemNum
//array TEXT(aPAltItem;0)////PrpLine]ItemNum
//ARRAY REAL(aPQtyOrder;0)////PrpLine]Qty
//array TEXT(aPDescpt;0)////PrpLine]Description
//ARRAY REAL(aPUnitPrice;0)////PrpLine]UnitPrice
//ARRAY REAL(aPDiscnt;0)////PrpLine]PriceDisount
//ARRAY REAL(aPDscntUP;0)
//ARRAY REAL(aPExtPrice;0)////PrpLine]ExtendedPrice
//ARRAY BOOLEAN(aPTaxable;0)////PrpLine]SaleTaxable
//ARRAY REAL(aPSaleTax;0)////PrpLine]SalesTax
//
//ARRAY REAL(aPUnitWt;0)////PrpLine]UnitWeight
//ARRAY REAL(aPExtWt;0)////PrpLine]ExtendedWt
//ARRAY REAL(aPUnitCost;0)////PrpLine]UnitCost
//ARRAY REAL(aPExtCost;0)////PrpLine]ExtendedCost
//ARRAY REAL(aPRepRate;0)////PrpLine]CommRateRep
//ARRAY REAL(aPRepComm;0)////PrpLine]CommRep
//ARRAY REAL(aPSalesRate;0)////PrpLine]CommRateSales
//ARRAY REAL(aPSaleComm;0)////PrpLine]CommSales
//ARRAY LONGINT(aPLeadTime;0)////PrpLine]Leadtime
//ARRAY LONGINT(aPLocation;0)////PrpLine]Location
//array TEXT(aPUnitMeas;0)////PrpLine]SaleUnitofMeas
//ARRAY LONGINT(aPSerial;0)////PrpLine]Serialized
//array TEXT(aPPricePt;0)////PrpLine]PricePoint
//ARRAY LONGINT(aPSeq;0)////PrpLine]Sequence
////
//ARRAY LONGINT(aPpOgRec;0)//Original record count
//
//ARRAY LONGINT(aoLineAction;0)//initialize the array to 0's in the elements
//ARRAY LONGINT(aOLineNum;0)
//array TEXT(aOItemNum;0)
//array TEXT(aOAltItem;0)
//ARRAY REAL(aOQtyOrder;0)
//ARRAY REAL(aOQtyShip;0)
//ARRAY REAL(aOQtyBL;0)
////
//
//array TEXT(aODescpt;0)
//ARRAY REAL(aOUnitPrice;0)
//ARRAY REAL(aODiscnt;0)
//ARRAY REAL(aODscntUP;0)
//ARRAY LONGINT(aOPQDIR;0)//Item Record Number, for lookup
//ARRAY REAL(aOExtPrice;0)
//ARRAY REAL(aOUnitCost;0)
//ARRAY REAL(aOExtCost;0)
////
//ARRAY REAL(aOBackLog;0)
//array TEXT(aOTaxable;0)
//ARRAY REAL(aOSaleTax;0)
//ARRAY REAL(aOSaleComm;0)
//ARRAY REAL(aOSalesRate;0)
//ARRAY REAL(aORepComm;0)
//ARRAY REAL(aORepRate;0)
////
//array TEXT(aOUnitMeas;0)
//ARRAY REAL(aOUnitWt;0)
//ARRAY REAL(aOExtWt;0)
//ARRAY LONGINT(aOLocation;0)
//ARRAY REAL(aOQtyOpen;0)
//ARRAY LONGINT(aOSerialRc;0)
//ARRAY TEXT(aOSerialNm;0)
//array TEXT(aOPricePt;0)
//ARRAY LONGINT(aOSeq;0)
//ARRAY DATE(aODateReq;0)
//ARRAY DATE(aOShipOnDate;0)
////
//array TEXT(aOOgItem;0)
//ARRAY REAL(aOOgQOrd;0)
//ARRAY REAL(aOOgQShip;0)
//ARRAY LONGINT(aOOgLine;0)
//
//ARRAY LONGINT(aiLineAction;0)//initialize the array to 0's in the elements
//ARRAY LONGINT(aiLineNum;0)
//array TEXT(aiItemNum;0)
//array TEXT(aiAltItem;0)
//ARRAY REAL(aiQtyOrder;0)
//ARRAY REAL(aiQtyRemain;0)
//ARRAY REAL(aiQtyShip;0)
//ARRAY REAL(aiQtyBL;0)
//array TEXT(aiDescpt;0)
//ARRAY REAL(aiUnitPrice;0)
//ARRAY REAL(aiDiscnt;0)
//ARRAY REAL(aiUnitPriceDiscounted;0)
//ARRAY LONGINT(aiPQDIR;0)//Item Record Number, for lookup
//ARRAY REAL(aiExtPrice;0)
//ARRAY REAL(aiUnitCost;0)
//ARRAY REAL(aiExtCost;0)
////ARRAY REAL(aiBackLog;0)
//array TEXT(aiTaxable;0)
//ARRAY REAL(aiSaleTax;0)
//ARRAY REAL(aiSaleComm;0)
//ARRAY REAL(aiSalesRate;0)
//ARRAY REAL(aiRepComm;0)
//ARRAY REAL(aiRepRate;0)
//array TEXT(aiUnitMeas;0)
//ARRAY REAL(aiUnitWt;0)
//ARRAY REAL(aiExtWt;0)
//ARRAY LONGINT(aiLocation;0)
//ARRAY REAL(aiQtyOpen;0)
////ARRAY LONGINT(aiSerialed;0)//serial rec number changes
//ARRAY LONGINT(aiSerialRc;0)//maintains orig serial num status
//ARRAY TEXT(aiSerialNm;0)// selected serial number
//array TEXT(aiPricePt;0)
//ARRAY LONGINT(aiSeq;0)
//
ARRAY LONGINT:C221(aSrIvAct; 0)  //initialize the array for tracking changes in serial numbers
ARRAY LONGINT:C221(aSrIvRec; 0)
ARRAY LONGINT:C221(aSrIvLnNum; 0)

ARRAY TEXT:C222(aPartNum; 0)
ARRAY TEXT:C222(aPartDesc; 0)
ARRAY LONGINT:C221(aItemSrRec; 0)  //Item record number
ARRAY REAL:C219(aQtyOnHand; 0)  //Current Qty On Hand
ARRAY REAL:C219(aQtyRecds; 0)  //Qty for the Adjustment
ARRAY REAL:C219(aPartQty; 0)  //New Qty On Hand
ARRAY REAL:C219(aQtyOnPOLns; 0)  //Currently On PO
ARRAY REAL:C219(aQtyOrd; 0)  //Current Qty On Sales Ord
ARRAY TEXT:C222(aBackOrder; 0)
ARRAY REAL:C219(aCosts; 0)
ARRAY LONGINT:C221(aLeadTime; 0)  //Current Qty On Sales Ord

ARRAY REAL:C219(aExUnitPrc; 0)
ARRAY REAL:C219(aExExtPrc; 0)
ARRAY REAL:C219(aExUnitCost; 0)
ARRAY REAL:C219(aExExtCost; 0)
ARRAY REAL:C219(aExBackLog; 0)
ARRAY REAL:C219(aExTaxIn; 0)
ARRAY REAL:C219(aExTaxOut; 0)
ARRAY REAL:C219(aExComSale; 0)
ARRAY REAL:C219(aExComRep; 0)

IVNT_dRayInit

//
ARRAY TEXT:C222(aServiceTableName; 0)
ARRAY TIME:C1223(aServiceTime; 0)
ARRAY DATE:C224(aServiceDate; 0)
//ARRAY DATE(aSerDate;0)
ARRAY TEXT:C222(aServiceAction; 0)
ARRAY TEXT:C222(aServiceVariable; 0)
ARRAY TEXT:C222(aServiceCompany; 0)
//array TEXT(aServiceAttentionID;0)
ARRAY LONGINT:C221(aServiceRecs; 0)
//
ARRAY LONGINT:C221(aTmpLong1; 0)
ARRAY TEXT:C222(aTmp40Str1; 0)
ARRAY TEXT:C222(aTmp40Str2; 0)
ARRAY TEXT:C222(aTmp12Str1; 0)
ARRAY TEXT:C222(aTmp20Str1; 0)
ARRAY TEXT:C222(aTmp10Str1; 0)  //Conversion to 25 char accounts
ARRAY TEXT:C222(aTmp25Str1; 0)
ARRAY TEXT:C222(aTmp35Str1; 0)
//
ARRAY TEXT:C222(aTmp2Str1; 0)
//
ARRAY TEXT:C222(aTmp20Str2; 0)
ARRAY TEXT:C222(aTmp20Str3; 0)
ARRAY TEXT:C222(aTmp20Str4; 0)
ARRAY LONGINT:C221(aTmpLong2; 0)
ARRAY DATE:C224(aTmpDate1; 0)
ARRAY BOOLEAN:C223(aTmpBoo1; 0)
ARRAY BOOLEAN:C223(aTmpBoo2; 0)
//
//ARRAY REAL(aPOQtyOrder;0)
//ARRAY REAL(aPOQtyRcvd;0)
//ARRAY REAL(aPoQtyBL;0)
//array TEXT(aPODescpt;0)
//ARRAY REAL(aPOUnitCost;0)
//ARRAY REAL(aPODiscnt;0)
//ARRAY REAL(aPoDscntUP;0)
//ARRAY REAL(aPOExtCost;0)
//ARRAY REAL(aPOVATax;0)
//array TEXT(aPOTaxable;0)
//array TEXT(aPOUnitMeas;0)
//ARRAY REAL(aPoBackLog;0)
//ARRAY LONGINT(aPOLineNum;0)
//ARRAY DATE(aPODateExp;0)
//ARRAY LONGINT(aPOOrdRef;0)
//ARRAY DATE(aPODateRcvd;0)
//ARRAY LONGINT(aPOSerialRc;0)
//ARRAY TEXT(aPOSerialNm;0)
//array TEXT(aPOVndrAlph;0)
//array TEXT(aPoItemNum;0)
//ARRAY LONGINT(aPOLineAction;0)
//ARRAY LONGINT(aPoPQBIR;0)
//ARRAY LONGINT(aPoSeq;0)

//
ARRAY TEXT:C222(aCon20Str1; 0)
ARRAY TEXT:C222(aCon20Str2; 0)
ARRAY TEXT:C222(aCon20Str4; 0)  //3 was creating an error
ARRAY TEXT:C222(aCon80Str1; 0)
ARRAY BOOLEAN:C223(aConBoo1; 0)
ARRAY BOOLEAN:C223(aConBoo2; 0)
ARRAY TEXT:C222(aCon40Str1; 0)
ARRAY TEXT:C222(aCon12Str1; 0)
ARRAY TEXT:C222(aContact; 0)
//
aaaStdRays
//
C_TEXT:C284(tcSSLSecure; tcJustAddress; tcFullAddress)
C_TEXT:C284(tcCompany; tcEmailAddr; tcEmailSrvr; tcDomain; tcSecure; tcDotted; tcSSLSecure; tcSSLUser)