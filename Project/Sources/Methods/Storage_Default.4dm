//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-13T06:00:00Z)
// Method: Storage_Default
// Description 
// Parameters
// ----------------------------------------------------


C_BOOLEAN:C305(<>booPassZero; <>boSkipWkEnd; <>vbDoSrlNums; <>tcIsVAT; <>booDoCost; <>vbCust2PO; <>vbKeepOpen)
C_LONGINT:C283(<>tcMfgId)
C_TEXT:C284(<>vsZonStStr)
C_TEXT:C284(<>VtaxID; <>tcDunsNum)

var $rec_o; $default_o : Object
$rec_o:=ds:C1482.DefaultAccount.all().first()
$default_o:=New object:C1471("glInventory"; "glInventory"; "glSales"; "glSales"; "glCost"; "glCost")
If ($rec_o#Null:C1517)
	$default_o.glCost:=$rec_o.itemCostofGoods
	$default_o.glInventory:=$rec_o.itemInventory
	$default_o.glSales:=$rec_o.itemSalesAcct
End if 
Storage_ToNew($default_o; "gl")

// Modified by: Bill James (2015-11-04T00:00:00 Counters Change)

$default_o:=New object:C1471
$rec_o:=ds:C1482.Default.query("primeDefault = 1").first()
If ($rec_o=Null:C1517)
	$rec_o:=ds:C1482.Default.new()
	$rec_o.idNum:=1
	$rec_o.primeDefault:=1
	$rec_o.maxArray:=300000000
	$rec_o.save()
End if 

C_TEXT:C284(<>jitHelpFolder; <>jitHelpLocal)

// ### jwm ### 20181214_1401 
If (($rec_o.shareCommand="False") | ($rec_o.shareCommand="true"))
	$rec_o.shareCommand:=""
	$rec_o.save()
End if 

If ($rec_o.shareCommand#"")
	OPEN URL:C673($rec_o.shareCommand)
	// LAUNCH EXTERNAL PROCESS($rec_o.ShareCommand)
	DELAY PROCESS:C323(Current process:C322; 180)
End if 


ARRAY TEXT:C222(<>asiteIDs; 0)
ARRAY LONGINT:C221(<>aSiteUniqueID; 0)
QUERY:C277([DivisionDefault:85]; [DivisionDefault:85]siteID:32#"")
SELECTION TO ARRAY:C260([DivisionDefault:85]siteID:32; <>asiteIDs; [DivisionDefault:85]idNum:1; <>aSiteUniqueID)
REDUCE SELECTION:C351([DefaultSetup:86]; 0)
SORT ARRAY:C229(<>asiteIDs)
INSERT IN ARRAY:C227(<>asiteIDs; 1)
<>asiteIDs{1}:="siteIDs"
<>asiteIDs:=1
//
// Modified by: williamjames (121107)


C_BOOLEAN:C305(<>vbEmptyShip2; <>vAlertNoCity)
<>vAlertNoCity:=$rec_o.alertNoCity
<>vbEmptyShip2:=$rec_o.emptyShip2

If ($rec_o.financeChargePC<0.1)
	$rec_o.financeChargePC:=1.5
	$rec_o.save()
End if 
<>vrFinanceChargePC:=$rec_o.financeChargePC
$default_o.financeCharge:=$rec_o.financeChargePC

// Modified by: Bill James (2015-07-19T00:00:00 Setting help sources, renamed the field
// changed aPages in iLo and help in oLo
If ($rec_o.helpSource<1)  // popup in layout sets 1 to WebClerk.com, 2 to <>vLocalHost, 3 to both
	$rec_o.helpSource:=1
End if 
<>viHelpSet:=$rec_o.helpSource  // used in page popup help HelpPopUp 
$default_o.helpSource:=$rec_o.helpSource

C_LONGINT:C283(<>viDelayQuit; <>viPOByOrderDate)
If ($rec_o.delayQuit=0)
	$rec_o.delayQuit:=10
	$rec_o.save()
End if 
If ($rec_o.delayProcess<45)
	$rec_o.delayProcess:=60
	$rec_o.save()
End if 
C_LONGINT:C283(<>viKeepRecord)
ARRAY TEXT:C222(<>aBarCodePreamble; Get last table number:C254)
<>viKeepRecord:=$rec_o.keepRecord
<>vConfirmEmailSkip:=$rec_o.confirmEmailSkip
<>viDelayProcessReturn:=$rec_o.delayProcess
<>viPOByOrderDate:=Num:C11($rec_o.pOoloOrderDate)
<>vbKeepOpen:=$rec_o.onNewRecordKeepOpen
<>viDelayQuit:=$rec_o.delayQuit
<>vOrder2POByBLQ:=$rec_o.order2POByBLQ
C_BOOLEAN:C305(<>syncByBlob; <>vbSortOnDisplay; <>vbSalesTaxOnAmount; <>vbCommissionOnAmount; <>vbApproval2Print)
<>vbSortOnDisplay:=$rec_o.sortOnDisplay
<>syncByBlob:=True:C214
<>vbSalesTaxOnAmount:=$rec_o.salesTaxOnAmount
<>vbCommissionOnAmount:=$rec_o.commissionOnAmount
<>vbApproval2Print:=$rec_o.approval2Print
C_BOOLEAN:C305(<>vbDuplicatePONum)
<>vbDuplicatePONum:=$rec_o.duplicatePONum
C_LONGINT:C283(<>vCashDrawerOpen; <>CashDrawerCharNum; <>vCashDrawerPort; <>vCashDrawerProtocal)
<>vCashDrawerPort:=21
<>vCashDrawerProtocal:=19466
<>CashDrawerCharNum:=7
<>vCashDrawerOpen:=$rec_o.cashDrawOpen
C_LONGINT:C283(<>taxForce2Zero; <>taxByArray)
<>taxForce2Zero:=0
<>taxByArray:=1
C_LONGINT:C283(<>vConfirmShipChange; <>vCountDeDup)
<>vCountDeDup:=0
<>vConfirmShipChange:=Num:C11($rec_o.confirmShipChange)
C_PICTURE:C286(<>vLogo)
<>vLogo:=$rec_o.logo
C_TEXT:C284(<>vSlogan)
<>vSlogan:=$rec_o.slogan
C_BOOLEAN:C305(<>doCCAlert; <>doNewProcessNewRecord)
<>doCCAlert:=$rec_o.doCCAlert
<>doCCShowPayOnApprove:=$rec_o.ccShowPayOnApprove
<>doNewProcessNewRecord:=$rec_o.processNewRecord
C_LONGINT:C283(<>doLinesByProcess)
<>doLinesByProcess:=$rec_o.orderLinesInvoiceLines
//
C_LONGINT:C283(cbUpdate; <>tcCancelBy; <>tciGLdDiv)
C_LONGINT:C283(<>tcDecimalUP; <>tcDecimalUC)
C_TEXT:C284(<>tcFormatTt; <>tcFormatUC; <>tcFormatUP)

C_TEXT:C284(<>vAltFoneFor)
C_TEXT:C284($temp40Str)
//
C_BOOLEAN:C305(<>vLoadPlanning; <>vbIgnoreFone; <>linkProposal; <>vbDateByDDMMYY; <>vbItemBundle; <>vbDisableProcessWin; <>vbShowTallyInForcast)
C_LONGINT:C283(<>tcPrsMemory)
C_BOOLEAN:C305(<>AuthNetTestMode; <>vbOverPayInvoice; <>vbLockInvAtPrint; <>PasswordAuto)
C_LONGINT:C283(<>vbDoOldVars; <>vlitemAutoManages)
<>vlitemAutoManages:=1

$default_o.lng:=$rec_o.lng
$default_o.lat:=$rec_o.lat

C_LONGINT:C283(<>vWindowWidth; <>vWindowHeight)
If ($rec_o.windowHeightDefault<475)
	$rec_o.windowHeightDefault:=475
	$rec_o.save()
End if 
If ($rec_o.windowWidthDefault<635)
	$rec_o.windowWidthDefault:=635
	$rec_o.save()
End if 
<>vWindowWidth:=$rec_o.windowWidthDefault
<>vWindowHeight:=$rec_o.windowHeightDefault
//
//
<>PasswordAuto:=$rec_o.autoEmployeePasswords
<>vbLockInvAtPrint:=$rec_o.invoicesLockOnPrint
<>vbOverPayInvoice:=$rec_o.overPayInvoices
<>vbIgnoreFone:=$rec_o.ignoreFoneFormat
<>vbManOrdSta:=$rec_o.manualOrdStat
<>linkProposal:=$rec_o.trackProposalQty

<>vbShowTallyInForcast:=$rec_o.showTallyInForcast
<>vLoadPlanning:=$rec_o.loadPlanning
<>tcDunsNum:=$rec_o.dunsNumber
C_BOOLEAN:C305(<>vbSimpleWin)
<>vbSimpleWin:=$rec_o.noItemWin
If ($rec_o.altPhoneFormat="")
	$rec_o.altPhoneFormat:="## ## ####-##-#####"
	$rec_o.save()
End if 
READ ONLY:C145([Counter:41])
If ($rec_o.periodPerHour=0)
	$rec_o.periodPerHour:=1
	$rec_o.save()
End if 
<>vbItemBundle:=$rec_o.itemBundle
<>vbDateByDDMMYY:=$rec_o.dateDDMMYY

$default_o.linkedOnly:=$rec_o.ledgerLinkedOnly
$default_o.division:=$rec_o.division


// QQQQQ write the json back to typed values
$default_o.disableProcessWindow:=$rec_o.disableProcessWindow
$default_o.emailServer:=$rec_o.emailServer
$default_o.email:=$rec_o.email
//
<>ccWebNum:=$rec_o.ccWebNum
<>ccWebDate:=$rec_o.ccWebDate
<>ccWebName:=$rec_o.ccWebName
//
<>viTmIncr:=$rec_o.periodPerHour

<>booDoCost:=$rec_o.costUpdate
<>vbLstCost:=$rec_o.lCostUpDate
<>booConfirm:=$rec_o.setConfirm
<>vAltFoneFor:=$rec_o.altPhoneFormat
//
$default_o.terms:=$rec_o.terms
$default_o.shipVia:=$rec_o.shipVia1
$default_o.typeSale:=$rec_o.typeSale

$default_o.domain:=$rec_o.domain

$default_o.invoiceComment:=$rec_o.invoiceComment
$default_o.company:=$rec_o.company  //17


//ConsoleMessage ("TEST: menuTitle")

$default_o.menuTitle:=Storage:C1525.version.title+":  "+$default_o.company

$default_o.division:=$rec_o.division
$default_o.address1:=$rec_o.address1  //20 removed a line space above and below
$default_o.address2:=$rec_o.address2
$default_o.city:=$rec_o.city
$default_o.state:=$rec_o.state
$default_o.zip:=$rec_o.zip  //25
$default_o.country:=$rec_o.country
$default_o.fob:=$rec_o.fob
$default_o.idPrefix:=$rec_o.siteCode
var $temp_t : Text
$default_o.phone:=Format_Phone($rec_o.phone)
$default_o.fax:=Format_Phone($rec_o.fax)
$temp_t:=jConcat($rec_o.company; "\r")+jConcat($rec_o.address1; "\r")+jConcat($rec_o.address2; "\r")+jConcat($rec_o.city; ", ")+jConcat($rec_o.state; "  ")+jConcat($rec_o.zip; "\r")+jConcat($rec_o.country)
$default_o.address:=Txt_TrimTrailingCR($temp_t)


$default_o.dtStampFldMods:=$rec_o.dtStampFldMods


<>tcLeadDue:=$rec_o.leadResponse
//
<>tcGrace30:=$rec_o.gracePrd1
<>tcGrace60:=$rec_o.gracePrd2
<>tcGrace90:=$rec_o.gracePrd3
<>tcNeedDelay:=$rec_o.needDelay
<>tcCancelBy:=$rec_o.cancelByDays
<>tcAutoFrght:=Num:C11($rec_o.autoCalcFreight)
cbUpDate:=Num:C11($rec_o.letterRecord)
<>tcDialOut:=$rec_o.dialOut
<>tcLocalArea:=Substring:C12($rec_o.phone; 1; 3)
<>tcNoCodHand:=$rec_o.noCODHand
<>tcLateFreq:=$rec_o.lateFreq
<>tcCODTerm:=$rec_o.codTerm
<>tcSaleMar:=Num:C11($rec_o.commissionType)
C_BOOLEAN:C305(<>tcIsVAT)
<>tcIsVAT:=False:C215  //No value added tax required
<>vtaxID:=$rec_o.taxID
//vOpenItem:=$rec_o.OpenItem

C_BOOLEAN:C305(<>vbQtyAvailable)
<>vbQtyAvailable:=$rec_o.qtyAvailable
<>tcbLoadItem:=$rec_o.trackInventory
<>booPassZero:=$rec_o.addAllItem
C_LONGINT:C283(<>tcSrItemSeq)
If (($rec_o.itemSrSequence>19) | ($rec_o.itemSrSequence<1))
	$rec_o.itemSrSequence:=1
	$rec_o.save()
End if 
<>tcSrItemSeq:=$rec_o.itemSrSequence
C_BOOLEAN:C305(<>tcSrItemDoXRefs)
<>tcSrItemDoXRefs:=$rec_o.itemSrSeqXRef





<>tcDecimalUP:=$rec_o.unitPricePrecis
<>tcDecimalUC:=$rec_o.unitCostPrecisi
<>tcDecimalTt:=$rec_o.totalPrecision
<>tcMfgId:=-1999999
<>vbDoSrlNums:=$rec_o.doSerialNum
<>tcbDoSrlOrd:=$rec_o.serialNumOrd
<>tcCcDevice:=$rec_o.ccDeviceType
//
$doNum:=Num:C11(<>tcDecimalTt>0)
$temp40Str:="###,###,###,##0"+("."*$doNum)+("0"*<>tcDecimalTt*$doNum)
<>tcFormatTt:=$temp40Str  //+"  ;"+$tempStr+"CR"
//"###,###,###,##0"+("."*$doNum)+("0"*TOTPREC*$doNum)
$doNum:=Num:C11(<>tcDecimalUC>0)
$temp40Str:="###,###,###,##0"+("."*$doNum)+("0"*<>tcDecimalUC*$doNum)
<>tcFormatUC:=$temp40Str  //+"  ;"+$tempStr+"CR"
$doNum:=Num:C11(<>tcDecimalUP>0)
$temp40Str:="###,###,##0"+("."*$doNum)+("0"*<>tcDecimalUP*$doNum)
<>tcFormatUP:=$temp40Str  //+"  ;"+$tempStr+"CR"
C_REAL:C285(<>minMargin)
If ($rec_o.minimumMargin>70)
	$rec_o.minimumMargin:=5
	$rec_o.save()
End if 
<>minMargin:=$rec_o.minimumMargin
//<>minMargin:=Round(1+($rec_o.MinimumMargin/100);2)-Num([Defaults
//]MinimumMargin<0)
//
<>tcMONEYCHAR:=$rec_o.priceCharacter
<>tcbManyType:=$rec_o.priceMatrixUse
<>boSkipWkEnd:=$rec_o.noWeekEndShip
$SaleAdd:=False:C215
<>tcPriceLvlD:=$rec_o.dPriceName
<>tcPriceLvlC:=$rec_o.cPriceName
<>tcPriceLvlB:=$rec_o.bPriceName
<>tcPriceLvlA:=$rec_o.aPriceName



READ ONLY:C145([PopUp:23])
READ ONLY:C145([PopupChoice:134])
PricingLvlDflts
REDUCE SELECTION:C351([PopUp:23]; 0)
REDUCE SELECTION:C351([PopupChoice:134]; 0)
READ WRITE:C146([PopUp:23])
READ WRITE:C146([PopupChoice:134])




<>tcMaxSerRay:=$rec_o.maxArray
<>bCloneWO:=$rec_o.cloneWO
<>bInvCmpOrd:=$rec_o.addInvCmplOrd
<>bBomExpand:=$rec_o.invtByOrdBOM
<>vbCust2PO:=$rec_o.custAddr2PO
C_LONGINT:C283(<>tciItQtyPre)
<>tciItQtyPre:=$rec_o.itemQtyPrecisio

//Else 
<>vsZonStStr:=""
ARRAY LONGINT:C221(<>yZonRow; 0)  //test values
ARRAY LONGINT:C221(<>yZonColMdl; 0)
//End if 
//ConsoleMessage ("TEST: RECORD($rec_o.")

If ($rec_o.prcssMemory<16000)
	$rec_o.prcssMemory:=64000
	$rec_o.save()
End if 
<>tcPrsMemory:=$rec_o.prcssMemory
<>tcStatPath:=$rec_o.pathOfStatus
<>tcStatDeLay:=$rec_o.statusDelay

C_BOOLEAN:C305(<>vDisplaySingle)
<>vDisplaySingle:=$rec_o.singleRecordoLo



C_BOOLEAN:C305(<>tcOtoIShipD)
<>tcOtoIShipD:=$rec_o.ordToInvDShipOn
C_LONGINT:C283(<>tcPrIvDShip)
<>tcPrIvDShip:=$rec_o.printInvoiceShipDate
Invc_PrimeDateP
C_BOOLEAN:C305(<>tcMAuthAddr)
<>tcMAuthAddr:=$rec_o.macAuthAddress


If ($rec_o.recentDays<90)
	$rec_o.recentDays:=730  // two years
	$rec_o.save()
End if 
$default_o.recentDays:=$rec_o.recentDays

C_BOOLEAN:C305(<>tcUpdateCommFromMaster)
<>tcUpdateCommFromMaster:=$rec_o.updateCommFromMaster
//
C_TEXT:C284(<>tcCCPartner)
<>tcCCPartner:=$rec_o.ccPartner
C_TEXT:C284(<>tcCCVerHost)
<>tcCCVerHost:=$rec_o.ccVerHost
C_TEXT:C284(<>tcCCVerURL)
<>tcCCVerURL:=$rec_o.ccVerURL
C_LONGINT:C283(<>tcCCVerPort)
<>tcCCVerPort:=$rec_o.ccVerPort
C_TEXT:C284(<>tcCCVerUserName)
<>tcCCVerUserName:=$rec_o.ccVerUserName
C_TEXT:C284(<>tcCCVerPassword)
<>tcCCVerPassword:=$rec_o.ccVerPassword
C_TEXT:C284(<>tcCCVerClientID)
<>tcCCVerClientID:=$rec_o.ccVerClientid
C_LONGINT:C283(<>tcCCStoragePolicy)
If ($rec_o.ccStoragePolicy=0)
	$rec_o.ccStoragePolicy:=2
	$rec_o.save()
End if 
<>tcCCStoragePolicy:=$rec_o.ccStoragePolicy
C_TEXT:C284(<>tcCCVerTranID)
<>tcCCVerTranID:=$rec_o.ccVerTransid

C_LONGINT:C283(<>tcDefaultSelectInvField)
If ($rec_o.selectInvField<1)
	<>tcDefaultSelectInvField:=2  //srCustomer variable
Else 
	<>tcDefaultSelectInvField:=$rec_o.selectInvField
End if 

<>vbDoOldVars:=$rec_o.oldVariables
$rec_o.oldVariables:=1
C_LONGINT:C283(<>tcDefaultFindCustChkbx)
If ($rec_o.findCustChkbx<1)
	<>aFindCustChkbx:=10
Else 
	<>aFindCustChkbx:=$rec_o.findCustChkbx
End if 

C_BOOLEAN:C305(<>tcDefaultLockAcctNbr)
<>tcDefaultLockAcctNbr:=$rec_o.lockAcctNumber

C_BOOLEAN:C305(<>tcDefaultAllowEmailChar)
<>tcDefaultAllowEmailChar:=$rec_o.allowEmailChar
//<>tcDefaultAllowEmailChar:=False
C_BOOLEAN:C305(<>doAuditTrail)
<>doAuditTrail:=$rec_o.trackSalesNameID

<>AuthNetTestMode:=$rec_o.authNetTestMode
<>vldoTaxWeb:=$rec_o.taxWebService
//
C_BOOLEAN:C305(<>vbExportEndRecord)
<>vbExportEndRecord:=$rec_o.endRecordExport


// MustFixQQQZZZ: Bill James (2022-01-13T06:00:00Z)
// convert the rest at some point




Storage_ToNew($default_o; "default")


C_TEXT:C284(<>tcBrand)
QUERY:C277([DefaultSetup:86]; [DefaultSetup:86]variableName:7="<>tcBrand"; *)
QUERY:C277([DefaultSetup:86];  & [DefaultSetup:86]machine:13=Current machine:C483)
If (Records in selection:C76([DefaultSetup:86])=1)
	<>tcBrand:=[DefaultSetup:86]value:9
Else 
	QUERY:C277([DefaultSetup:86]; [DefaultSetup:86]variableName:7="<>tcBrand")
	Case of 
		: (Records in selection:C76([DefaultSetup:86])=1)
			<>tcBrand:=[DefaultSetup:86]value:9
		: (Records in selection:C76([DefaultSetup:86])>1)
			<>tcBrand:=[DefaultSetup:86]value:9
		Else 
			// gkgkgk
			// ### jwm ### 20180830_0958
			DefaultSetupsCreate("<>tcBrand"; $default_o.company; "Is text"; "WebClerk"; "[WebClerk]Input"; "Collapsable menu brand name")
	End case 
End if 
REDUCE SELECTION:C351([DefaultSetup:86]; 0)



ARRAY TEXT:C222(<>aDSGroup; 0)
ARRAY TEXT:C222(<>aDSLayoutName; 0)
ARRAY TEXT:C222(<>aDSMachine; 0)
ARRAY TEXT:C222(<>aDSMachineOwner; 0)
ARRAY TEXT:C222(<>aDSNameID; 0)
ARRAY LONGINT:C221(<>aDSUniqueID; 0)
ARRAY TEXT:C222(<>aDSValue; 0)
ARRAY TEXT:C222(<>aDSVariableName; 0)
ARRAY TEXT:C222(<>aDSType; 0)
ARRAY LONGINT:C221(<>aDSSequence; 0)

QUERY:C277([DefaultSetup:86]; [DefaultSetup:86]group:12="all"; *)
QUERY:C277([DefaultSetup:86];  | [DefaultSetup:86]nameID:1=Current user:C182; *)
QUERY:C277([DefaultSetup:86];  | [DefaultSetup:86]machine:13=Current machine:C483; *)
QUERY:C277([DefaultSetup:86];  | [DefaultSetup:86]machineOwner:14=Current system user:C484; *)
QUERY:C277([DefaultSetup:86])

SELECTION TO ARRAY:C260([DefaultSetup:86]group:12; <>aDSGroup; [DefaultSetup:86]layoutName:3; <>aDSLayoutName; [DefaultSetup:86]machine:13; <>aDSMachine; [DefaultSetup:86]machineOwner:14; <>aDSMachineOwner; [DefaultSetup:86]nameID:1; <>aDSNameID; [DefaultSetup:86]idNum:5; <>aDSUniqueID; [DefaultSetup:86]value:9; <>aDSValue; [DefaultSetup:86]variableName:7; <>aDSVariableName; [DefaultSetup:86]seq:15; <>aDSSequence; [DefaultSetup:86]type:8; <>aDSType)
REDUCE SELECTION:C351([DefaultSetup:86]; 0)


PathSetServer