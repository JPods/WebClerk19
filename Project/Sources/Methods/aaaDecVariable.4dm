//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/21/10, 06:43:52
// ----------------------------------------------------
// Method: aaaDecVariable
// Description
// 
//
// Parameters
// ----------------------------------------------------

Compiler_Variables
var imageDoc_p; imageQA_p; vItemPict : Picture
// olo DT variables
C_TEXT:C284(vtDT01; vtDT02; vtDT03; vtDT04; vtDT05; vtDTAction; vtDTActionLast; vtDTActivated)
C_TEXT:C284(vtDTApprCood; vtDTApprOth; vtDTApprPurch; vtDTApprSales; vtDTArchived; vtDTAssembly; vtDTBegin)
C_TEXT:C284(vtDTBeginPlanned; vtDTBestUseEnd; vtDTBestUseStart; vtDTChange; vtDTCompleted; vtDTCounted)
C_TEXT:C284(vtdtCreated; vtDTCustoms; vtDTDateTime1; vtDTDateTime2; vtDTDeath; vtDTdInventoryRecord)
C_TEXT:C284(vtDTDocument; vtDTEnd; vtDTEndPlanned; vtDTEntered; vtdtEvent; vtdtExpires; vtDTItemCard)
C_TEXT:C284(vtDTItemDate; vtDTLast; vtDTLastExecuted; vtdtLastSync; vtDTLastUpdate; vtdtLastUpdated)
C_TEXT:C284(vtDtLastVisit; vtDTNeeded; vtDTNextEvent; vtDTNextRun; vtDTNextStart; vtDTOriginated; vtDTProdCompl)
C_TEXT:C284(vtDTProdRelease; vtDTReceived; vtDTReceiveExpected; vtDTReleased; vtDTReport; vtDTRequested)
C_TEXT:C284(vtDTReservation; vtDTRevenue; vtDTReviewed; vtDTShipOn; vtDTSignIn; vtDTSignOut; vtDTsiteID; vtDTStack)
C_TEXT:C284(vtDTStampFldMods; vtDTStarted; vtDTSubmitted; vtDTSync; vtDTTEventsDirt; vtDTUpdated; vtDtUser)
C_TEXT:C284(vtDTCreated; vtDTSignOn; vtDTSignOff)
C_PICTURE:C286(vPGraf)
C_TEXT:C284(<>vConsole_Log)
C_TEXT:C284(RequiredField)  // ### jwm ### 20160810_1053
C_BOOLEAN:C305(<>salesRepSpreadSheet; <>useTransactions; transactionActive)
<>salesRepSpreadSheet:=False:C215
C_LONGINT:C283(dialIt1; dialIt2; dialIt3; dialIt4; dialIt5; dialIt6; dialIt7; dialIt8)
C_TEXT:C284(vTextAsIs1; vTextAsIs2; vTextAsIs3)
C_LONGINT:C283(viExConPrec; viExDisPrec)
C_TEXT:C284(srUserName; srPassword)
C_BOOLEAN:C305(doOLO; haveReceiptID; <>vConfirmEmailSkip)
C_LONGINT:C283(viALVert; viALHorz)
C_LONGINT:C283(SRWindow)  //required to zoom window
C_DATE:C307(SRDate)
C_LONGINT:C283(SRRecord)
C_LONGINT:C283(SRPage)
C_LONGINT:C283(SR_TotalPgs)
//C_TIME(SRTime)
C_LONGINT:C283(splashMenu; oLoMenu; iLoMenu)
C_TEXT:C284(SRDateLong)
C_TEXT:C284(LtrSignedBy)
C_REAL:C285(vrLo1; vrLo2; vrLo3; vrLo4; vrLo5; vrLo6; vrLo7; vrAmountOverRide)
C_TEXT:C284(pXRfTypeSale)
C_TEXT:C284(pXRfDescrp)
C_LONGINT:C283(vbLocked_13; vbLocked_06; vbLocked_02)
//
C_TEXT:C284(pvAddress1; pvAddress2; pvCity; pvState; pvZip; pvCountry)
//
C_BOOLEAN:C305(doItemList)
C_BOOLEAN:C305(newOrd; newInv; newStak; newPo; newProp; newService)  //navigation, save or recover sequence numbers
C_BOOLEAN:C305(booPreNext; myDoNew)  //Used in next and previous record buttons
C_LONGINT:C283(bChangeRec; bNewRec; doSearch; unLocked)
C_TEXT:C284(vDocType)
vDocType:="TEXT"
C_LONGINT:C283(curTableNum; curTableNumAlt)  //curTableNumAlt use in import/export/apply select
C_LONGINT:C283(myCycle)  //navigation
C_LONGINT:C283(viNavAccept)
C_BOOLEAN:C305(booAccept)  //navigation, used in Accept Button & customer card
C_BOOLEAN:C305(booDuringDo)  //navigation, used to skip during phase in side buttons
C_BOOLEAN:C305(booSorted)  //tests to see if a sort has been preformed prior to ops on a set
C_TEXT:C284(vStr255)  //used to apply to records
C_LONGINT:C283(myOK; vPastDue)
C_BOOLEAN:C305(mySpecCan)
C_LONGINT:C283(bCancel; bCancelB)  //Cancel buttons
C_LONGINT:C283(bAccept; bAcceptB)
C_LONGINT:C283(b1; b2; b3; b4; b5; b6; b7; b8; b9; b10)
C_LONGINT:C283(b11; b12; b13; b14; b15; b16; b17; b18; b19)
C_LONGINT:C283(b20; b21; b22; b23; b24; b25; b26; b27; b28; b29; B31)
C_LONGINT:C283(b60; b61; b62; b63; b64; b65; b66; b67; b68; b69)
C_LONGINT:C283(bNext; bPrevious; bReturn; bSave; Can; Cond)
C_LONGINT:C283(bSubAdd; bSubDel)
C_LONGINT:C283(CurRecNum; SavedRecordNum)  // ### azm ### 20171006_1330
C_TEXT:C284(returnTableName; returnRecordNum; returnString)
C_LONGINT:C283(Dial it1)
C_LONGINT:C283(bLoad)  //Export and Invoice
C_TEXT:C284(v1; v2; v3; v4; v5; v6; v7; v8; v9; v10; v11; v12; v13; v14; v15)
C_LONGINT:C283(vi1; vi2; vi3; vi4; vi5; vi6; vi7; vi8; vi9; vi10)
C_REAL:C285(vR1; vR2; vR3; vR4; vR5; vR6; vR7; vR8; vR9; vR10)
C_TEXT:C284(vText; vText1; vText2; vText3; vText4; vText5; vText6; vText7; vText8; vText9; vText10)
C_TEXT:C284(vData; vData1; vData2; vData3; vData4; vData5; vData6; vData7; vData8; vData9; vData10)
C_OBJECT:C1216(vObject; vObject1; vObject2; vObject3; vObject4; vObject5; vObject6; vObject7; vObject8; vObject9; vObject10)
C_BLOB:C604(vBlob; vBlob1; vBlob2; vBlob3; vBlob4; vBlob5; vBlob6; vBlob7; vBlob8; vBlob9; vBlob10)
C_DATE:C307(vDate; vDate1; vDate2; vDate3; vDate4; vDate5; vDate6; vDate7; vDate8; vDate9; vDate10)
C_TIME:C306(vTime1; vTime; vTime2; vTime3; vTime4; vTime5; vTime6; vTime7; vTime8; vTime9; vTime10)
C_PICTURE:C286(vPict1; vPict2; vPict3; vPict4; vPict5; vPict6; vPict7; vPict8; vPict9; vPict10)
C_LONGINT:C283(viBoo1; viBoo2; viBoo3)
C_TEXT:C284(myDocName)
C_LONGINT:C283(viErr)
// EDI variables
C_TEXT:C284(vtPartVendor; vtPartBuyer; vtPartManufacturer; vtMonth; vtDay; vtYear; vtUnitOfMeasure; vtLineID)
C_LONGINT:C283(viLineCount)
C_REAL:C285(vrQtyOrdered; vrUnitPrice)
// 

C_TEXT:C284(dtSYNC)
C_TEXT:C284(ScreenSize)
ScreenSize:="9"
C_TEXT:C284(vOverDueBy)
C_TEXT:C284(vPartNum)
C_TEXT:C284(vPartDesc)
C_LONGINT:C283(myTrap)
C_TEXT:C284(vText)
vText:=""
C_REAL:C285(vItemScale; vRunningBal)
C_LONGINT:C283(vHere; viOrdLnCnt; viInvcLnCnt; viPOLnCnt; viPrplLnCnt; LastPick)
vHere:=0
C_LONGINT:C283(cntFields; vCount; vInvNum)
C_BOOLEAN:C305(vInclTrue; vModCust; vMod; vLineReCalc; vLineMod)
C_TEXT:C284(vHeading; vClosing)  //used in 30/60/90 notice
C_TEXT:C284(vPage)
C_POINTER:C301(ptFile)
C_TEXT:C284(vName)
//
C_LONGINT:C283(viRecordsInTable; viRecordsInSelection)
C_REAL:C285(vComRep; vComSales)
C_LONGINT:C283(vInvNum; vOrdNum; vCount)
C_REAL:C285(vItemSpace; vItemScale)  //used to set scale and space of usage grafs
//vItemSpace:=1
vItemScale:=0.5
//defaults
C_REAL:C285(vSaleByRep; vComByRep)
//startup
C_POINTER:C301(ptVar)
//Insight Customer
C_TEXT:C284(vTempAcct)  // used to declare new customer accounts.
C_TEXT:C284(pPartNum)
C_TEXT:C284(pUnitMeas)
C_TEXT:C284(pDescript)
C_BOOLEAN:C305(pBooTaxable)
C_REAL:C285(pQtyOrd; pQtyShip; pQtyBL; pUtWt; pFrght)
C_LONGINT:C283(pLocation; pLineNum)
C_REAL:C285(pUnitPrice; pDiscnt; pExtPrice; pSalesTax; pUnitCost; pExtCost; pMiscCost; pGross; pGrossMar; pBasePrice)
C_REAL:C285(pCommSales; pCommSPC; pCommRep; pCommRPC; pComm)
C_TEXT:C284(ptaxID)
C_LONGINT:C283(pUse)
C_TEXT:C284(pProdBy)
C_TEXT:C284(pComment)
C_TEXT:C284(pProfile1; pProfile2; pProfile3)  //line item profiles
C_TEXT:C284(pShipOrdSt)  //Ship/Order Status in detail
C_TEXT:C284(vStatus)  //Ship/Order Status in detail

C_TEXT:C284(srCustomer)
C_TEXT:C284(srPhone)
C_TEXT:C284(srAcct)
C_TEXT:C284(srZip)
C_TEXT:C284(srState)
C_TEXT:C284(srAction)
C_TEXT:C284(srDivision)
C_DATE:C307(srActionDat)
C_TEXT:C284(srAdSource)
C_LONGINT:C283(srQAThere)
C_TEXT:C284(srRepID)
C_TEXT:C284(srsalesNameID)
C_TEXT:C284(srSICCode)
C_TEXT:C284(srProspect)
C_TEXT:C284(srNeed)
C_TEXT:C284(srProfile1)
C_TEXT:C284(srProfile2)
C_TEXT:C284(srProfile3)
C_TEXT:C284(srProfile4)
C_TEXT:C284(srProfile5)
C_LONGINT:C283(srProfile6)
C_LONGINT:C283(srProfile7)
C_TEXT:C284(srVndAlpha)
C_TEXT:C284(srLstName)
C_TEXT:C284(srItem; srItemMfgItemNum; srItemType; srItemNum; srItemSpecID)
C_TEXT:C284(srItemVendorID; srItemMfgID)
C_TEXT:C284(srItemKeyWords)
C_TEXT:C284(srItemsProfile1; srItemsProfile2; srItemsProfile3; srItemsProfile4; srItemsProfile5)
C_TEXT:C284(srItemDscrp)

C_TEXT:C284(ShipTo)  // used in printing to concat customers addresses
//
//Ian's Externals
//C_LONGINT(Pos;Tot;Blk)//Ian's Progress Indicato
//C_Longint(Can;TPos;Style;Pat;Cond)//Setting graphics
//C_TEXT(Msg)
//Tot:=0//Records in selection([Invoice])
//Pos:=0//Center in existing 4D window
//Can:=0//With Cancel Button
//Ttl:=""
//TPos:=1//Center Justified
//Msg:=" "
//Style:=0
//Pat:=0//Fill Pattern for Indicator 50%
//Blk:=0
//Cond:=0
//
C_LONGINT:C283(vOrdSet; vInvSet; vPropSet; vPOSet)  //Set the current Number of Invoices, etc...
//
C_LONGINT:C283(viRecordsInTable; viRecordsInSelection)
C_POINTER:C301(ptFile)  //Used in standard file selection and export/import
//
C_TEXT:C284(vShipper; vShipperID)
//
C_BOOLEAN:C305(doTax)
//
C_REAL:C285(sTaxRate)
C_BOOLEAN:C305(doTax)
doTax:=False:C215
C_LONGINT:C283(vCntCust; vCntCon; vCntSer; vCntPp; vCntOrd; vCntInv; vCntShow)  //used in Sync
//
C_TEXT:C284(vtLastLabel)
C_POINTER:C301(ptLineRec)
C_TEXT:C284(myStrDoc)
C_TEXT:C284(pvFAX; pvPhone)
C_TEXT:C284(pvItemNum)
C_TEXT:C284(pvDescription)
C_TEXT:C284(pvQtyOrd; pvQtyShip; pvQtyBL)
C_TEXT:C284(pvTaxable; pvTax; pvPricePt; pvBasePrice)
C_TEXT:C284(pvUnitPrice; pvDiscount; pvExtPrice; pvAmountBL)
C_TEXT:C284(pvUnitCost; pvExtCost; pvUnitMeas; pvLocation; pvUnitWt; pvExtWt)
C_TEXT:C284(pvLeadTime)
C_TEXT:C284(pvSerial; pvTermState; pvLnComment)
C_TEXT:C284(pvCommRep; pvCommSales; pvRateRep; pvRateSales; pvReference)
C_TEXT:C284(pvLnProfile1; pvLnProfile2; pvLnProfile3)  //LineItem Profiles
C_TEXT:C284(pvShipOrdSt)  //Ship/Order Status in invoice lines
C_TEXT:C284(pvLnProfile1; pvLnProfile2; pvLnProfile3; pvLnProfile4)
C_TEXT:C284(CustAddress; ShipAddress; MainAddress)
C_TEXT:C284(vFrghtType; pvLnStatus)
C_TEXT:C284(pvUse)
C_REAL:C285(vR1; vR2; vR3; vR4; vR5; vR6; vR7; vR8; vR9; vR10)
C_TEXT:C284(pvAltItem)
//
C_LONGINT:C283(viVert; viHorz; ALProEvt)
//
C_LONGINT:C283(shipToMe)
//
C_TEXT:C284(MfgName; MfgAttn)
C_TEXT:C284(MfgAddress)
C_TEXT:C284(MfgPhone; MfgFAX)
//
C_LONGINT:C283(vPageCount)
//
C_TEXT:C284(pveMailAddressDoc; pveMailAddressCo; pveMailAddressiS; pveMailAddressiB)
C_TEXT:C284(pvPhoneDoc; pvPhoneCo; pvPhoneiS; pvPhoneiB)
C_TEXT:C284(pvFaxDoc; pvFaxCo; pvFaxiS; pvFaxiB)
C_TEXT:C284(BillAddress)
strCurrency:=""
//
ARRAY LONGINT:C221(aPagePath; Get last table number:C254)
//
vText:=""
ScreenSize:="9"
//
C_LONGINT:C283(CmdKey; OptKey; CtlKey; ShftKey; CapKey)
CmdKey:=0
OptKey:=0
CtlKey:=0
ShftKey:=0
CapKey:=0
C_TEXT:C284(pComplete)
fExUnCost:=""
fExUnPrice:=""
fExUnExCost:=""
fExUnExPrice:=""

fExExtAmt:=0
fExExtShip:=0
fExExtTax:=0
fExExtTtl:=0
C_REAL:C285(fExExtAmt; fExExtShip; fExExtTax; fExExtTtl)
C_TEXT:C284(fExUnCost; fExUnPrice; fExUnExCost; fExUnExPrice)
//
C_BOOLEAN:C305(allowAlerts_boo)  //blocks GUI code sections when they are used by EDI
allowAlerts_boo:=True:C214  //true means don't block the code
C_TEXT:C284(lang)
C_REAL:C285(rUExchRate; rUExchRate)

C_TEXT:C284(sAltCo)
C_TEXT:C284(sAltAcct)
C_TEXT:C284(sAltPhone)
C_TEXT:C284(sAltZip)
C_LONGINT:C283(viWebOrder)
viWebOrder:=0
//
C_POINTER:C301(vtZipPtr; vtsalesNameIDPtr; vtRepIDPtr)  //used in method J_FindZipSalesRepFields

C_LONGINT:C283(vWccRemoteUserRec; vWccPrimeRec)
C_LONGINT:C283(vWccTableNum; vWccSecurity)

// ### jwm ### 20171106_1425 copied from Startup Method
C_TEXT:C284(<>WindowPosition)
C_BOOLEAN:C305(<>WindowToBack)