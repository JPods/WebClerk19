//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 10/22/14, 15:00:34
// ----------------------------------------------------
// Method: aaaDecConsts
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20141022_1139 new blank, not blank operators


C_BOOLEAN:C305(<>wcTest; <>vbWildCrumbs)  // ### jwm ### 20180101_1528 Test variable for WC_RequestHandler
<>wcTest:=True:C214
<>vbWildCrumbs:=False:C215  // ### jwm ### 20180405_1652 test variable WC_Core Wildcards in URL Overrides

C_BOOLEAN:C305(<>vbUseLegacyTagParsing)
<>vbUseLegacyTagParsing:=True:C214

C_BOOLEAN:C305(<>vbDateTimeStamp)
<>vbDateTimeStamp:=True:C214  // ### jwm ### 20190222_0029

//(GP) aaaDecConsts
//for additional consts see aaaDecArrays
C_LONGINT:C283(<>viCounterPending)
<>viCounterPending:=100
C_LONGINT:C283(<>alpArrayMax)
<>alpArrayMax:=2000000
C_BOOLEAN:C305(<>MyErrorByPass)
<>MyErrorByPass:=True:C214
ARRAY TEXT:C222(<>aScale; 6)
<>aScale{1}:="Scale"
<>aScale{2}:=".5"
<>aScale{3}:="2"
<>aScale{4}:="3"
<>aScale{5}:="4"
<>aScale{6}:="Other"  //980207
<>aScale:=1
//Serialized Item Record values
C_LONGINT:C283(<>ciSRNotSerialized; <>ciSRSerialTBD; <>ciSRUnknown; <>ciSRReceivd; <>ciSRAltered; <>ciSRThisSerialNumber)
<>ciSRNotSerialized:=0  //not serialized ---- values in aiSerialID
<>ciSRSerialTBD:=-2  //To Be Determined Record Code
//ciSRNewSr:=-3//newly created (make new rec)
<>ciSRReceivd:=-4  //already received, not new --- not used in theCustomer
<>ciSRAltered:=-5  //newly altered, needs to be saved.
<>ciSRUnknown:=-3  //Unrecieved PO Line, serial number not known
<>ciSRThisSerialNumber:=-6  //reference this Serial Number
//
C_LONGINT:C283(<>viPixel; <>outLayoutTrigger)
<>viPixel:=0
// ### bj ### 20190129_1034  what is this
// test this
<>outLayoutTrigger:=1
//
C_LONGINT:C283(<>delayTics)
<>delayTics:=1800
C_DATE:C307(<>cdYester; <>cdWeek; <>cdMonth)
Date_Set


C_LONGINT:C283(<>ciZonRcvCom; <>ciZonRcvPor)
<>ciZonRcvCom:=10+1024-16384+12288  //9600 7E2
C_LONGINT:C283(<>ciCCDevNoCC)
<>ciCCDevNoCC:=0  //No CC Device
C_LONGINT:C283(<>ciCCDevMaSu)
<>ciCCDevMaSu:=1  //Mac Authorize single user
C_LONGINT:C283(<>ciCCDevZjMd)
<>ciCCDevZjMd:=2  //Zon Jr on Modem Port
C_LONGINT:C283(<>ciCCDevZjPr)
<>ciCCDevZjPr:=3  //Zon Jr on Printer Port
C_LONGINT:C283(<>ciCCDevMaMu)
<>ciCCDevMaMu:=4  //Mac Authorize multi-user
C_LONGINT:C283(<>ciCCDevCHASE)
<>ciCCDevCHASE:=5  //CHASE services over internet
C_LONGINT:C283(<>ciCCDevAuthNet)
<>ciCCDevAuthNet:=6  //AuthNet services over internet
C_LONGINT:C283(<>ciCCDevSOAP)
<>ciCCDevSOAP:=7  //SOAP services over internet
C_LONGINT:C283(<>ciCCDevVerisign)
<>ciCCDevVerisign:=8  //Verisign/Paypal services over internet
C_LONGINT:C283(<>ciCCDevSyncRelations)
<>ciCCDevSyncRelations:=9  //Verisign/Paypal services over internet

//
//Tender Type Classes
C_LONGINT:C283(<>ciTCCashChk)  //Cash/Check
<>ciTCCashChk:=1
C_LONGINT:C283(<>ciTCCheck)  //Check
<>ciTCCheck:=2
C_LONGINT:C283(<>ciTCCrdtCrd)  //Credit Card
<>ciTCCrdtCrd:=3
C_LONGINT:C283(<>ciTCAcctRcv)  //Accounts Recieviable
<>ciTCAcctRcv:=4
C_LONGINT:C283(<>ciTCMisc1)  //Misc Type 1
<>ciTCMisc1:=5
C_LONGINT:C283(<>ciTCMisc2)  //Misc Type 2
<>ciTCMisc2:=6
C_LONGINT:C283(<>ciTCMisc3)  //Misc Type 3
<>ciTCMisc3:=7
//
//Auth transaction type values (MacAuth)
C_LONGINT:C283(<>ciATAuthCap)  //Authorize & Capture
<>ciATAuthCap:=1
C_LONGINT:C283(<>ciATAuthNoC)  //Authorize Only
<>ciATAuthNoC:=2
C_LONGINT:C283(<>ciATCredit)  //Credit
<>ciATCredit:=3
C_LONGINT:C283(<>ciATVoid)  //Void
<>ciATVoid:=4
C_LONGINT:C283(<>ciATPstAuth)  //Post Authorize
<>ciATPstAuth:=5
//
//Auth Card Type values (MacAuth)
C_LONGINT:C283(<>ciACTCredit)
<>ciACTCredit:=1  //major credit Card (ex Visa)
C_LONGINT:C283(<>ciACTTECard)
<>ciACTTECard:=2  //Travel&Entertainment Card
C_LONGINT:C283(<>ciACTPrvtCd)
<>ciACTPrvtCd:=3  //Private Label (Other Card)
C_LONGINT:C283(<>ciACTCkMICR)
<>ciACTCkMICR:=4  //MICR Check Guarantee
C_LONGINT:C283(<>ciACTChckDL)
<>ciACTChckDL:=5  //Driver's License Check Guarantee
C_LONGINT:C283(<>ciACTDebit)
<>ciACTDebit:=9  //Debit Card future use
//
C_LONGINT:C283(<>wAlDate; <>wAlAcctNum; <>wAlValue)
<>wAlAcctNum:=78
<>wAlDate:=72
<>wAlValue:=86
//
TIO_DecConst
//
C_POINTER:C301(<>cptNilPoint)  //Uninitialized Pointers are Nil Pointers
//
//EDI_DecConst
//
//Profile Copy values
C_LONGINT:C283(<>ciPrCpyYes)  //Always Copy
<>ciPrCpyYes:=1
C_LONGINT:C283(<>ciPrCpyNo)  //Never Copy
<>ciPrCpyNo:=2
C_LONGINT:C283(<>ciPrCpyOnce)  //Copy Once, Clone gets <>ciPrCpyNo
<>ciPrCpyOnce:=3
C_LONGINT:C283(<>ciPrCpyInvc)  //Copy only if new record is a Invoice
<>ciPrCpyInvc:=4
C_LONGINT:C283(<>ciPrCpyOrd)  //Copy only if new record is a Order
<>ciPrCpyOrd:=5
C_LONGINT:C283(<>ciPrCpyPpl)  //Copy only if new record is a Propsal
<>ciPrCpyPpl:=6
C_LONGINT:C283(<>ciPrCpyCust)  //Copy only if new record is a Customer
<>ciPrCpyCust:=7
//
ARRAY TEXT:C222(<>aCustAddRel; 6)
<>aCustAddRel{1}:="Add Record"
<>aCustAddRel{2}:="CallReport"
<>aCustAddRel{3}:="Invoice"
<>aCustAddRel{4}:="Order"
<>aCustAddRel{5}:="Proposal"
<>aCustAddRel{6}:="Service"
<>aCustAddRel:=1
//
ARRAY TEXT:C222(<>aRayTools; 4)
<>aRayTools{1}:="Tools"
<>aRayTools{2}:="DoSet"
<>aRayTools{3}:="OmitSelect"
<>aRayTools{4}:="SubSelect"
<>aRayTools:=1

//User Report Line Interation Types
C_LONGINT:C283(<>ciUserRptRecordCount)
<>ciUserRptRecordCount:=1  //By Record Count of the default file
C_LONGINT:C283(<>ciUserRptLoopSingleRec)
<>ciUserRptLoopSingleRec:=2  //Loop once for each default file record
C_LONGINT:C283(<>ciUserRptCustom)
<>ciUserRptCustom:=3  //Custom iterations; set-up in the editor for each report
C_LONGINT:C283(<>ciUserRptByFixedLineCnt)
<>ciUserRptByFixedLineCnt:=4  //Fixed number of lines per page, uses P_... vars

//Default Selected Invoice Field
C_LONGINT:C283(<>ciSelectInvField_PN)
<>ciSelectInvField_PN:=1
C_LONGINT:C283(<>ciSelectInvField_Cust)
<>ciSelectInvField_Cust:=2
C_LONGINT:C283(<>ciSelectInvField_Name)
<>ciSelectInvField_Name:=3
C_LONGINT:C283(<>ciSelectInvField_Phone)
<>ciSelectInvField_Phone:=4
C_LONGINT:C283(<>ciSelectInvField_Zip)
<>ciSelectInvField_Zip:=5
C_LONGINT:C283(<>ciSelectInvField_Acct)
<>ciSelectInvField_Acct:=6

//Default Find Customer Checkboxes
//
C_TEXT:C284(<>jitTag; <>refTag; <>midTag; <>endTag; <>formatTag)
<>jitTag:="_jit_"
<>refTag:="rjit_"
<>midTag:="_"
<>formatTag:="_"
<>endTag:="jj"
C_TEXT:C284(<>forceEmpty)
<>forceEmpty:=""
C_LONGINT:C283(<>lenJitTag; <>lenMidTag; <>lenEndTag)
<>lenJitTag:=5  //p will already be at 1
<>lenMidTag:=1
<>lenEndTag:=2  //grabbing in the middle, must add 1
//
<>doeventID:=False:C215


ARRAY TEXT:C222(<>aOperators; 17)
<>aOperators{1}:="equals"
<>aOperators{2}:="not equals"
<>aOperators{3}:="greater than"
<>aOperators{4}:="greater or equal"
<>aOperators{5}:="less than"
<>aOperators{6}:="less than or equal"
<>aOperators{7}:="contains"
<>aOperators{8}:="not contains"
<>aOperators{9}:="literal"
<>aOperators{10}:="blank"  // ### jwm ### 20141022_1139
<>aOperators{11}:="not blank"  // ### jwm ### 20141022_1139
//
<>aOperators{12}:="="
<>aOperators{13}:="#"
<>aOperators{14}:=">"
<>aOperators{15}:=">="
<>aOperators{16}:="<"
<>aOperators{17}:="<="
C_COLLECTION:C1488($vcOperators)
$vcOperators:=New collection:C1472
ARRAY TO COLLECTION:C1563($vcOperators; <>aOperators)
C_OBJECT:C1216($voOperators)
$voOperators:=New object:C1471
$voOperators.operators:=$vcOperators
Storage_ToNew($voOperators; "operators")

ARRAY TEXT:C222(<>aBooleanOperators; 3)
<>aBooleanOperators{1}:="and"
<>aBooleanOperators{2}:="or"
<>aBooleanOperators{3}:="single"

ARRAY TEXT:C222(<>aCountryCodes; 0)
ARRAY TEXT:C222(<>aCountryNames; 0)

ARRAY TEXT:C222(<>aStateNames; 0)
ARRAY TEXT:C222(<>aStateCodes; 0)
ARRAY TEXT:C222(<>aStateCountryCodes; 0)
//
ARRAY TEXT:C222(<>aColorNames; 16)
<>aColorNames{1}:="White"
<>aColorNames{2}:="Yellow"
<>aColorNames{3}:="Orange"
<>aColorNames{4}:="Red"
<>aColorNames{5}:="Purple"
<>aColorNames{6}:="Dark Blue"
<>aColorNames{7}:="Blue"
<>aColorNames{8}:="Light Blue"
<>aColorNames{9}:="Green"
<>aColorNames{10}:="Dark Green"
<>aColorNames{11}:="Dark Brown"
<>aColorNames{12}:="Dark Grey"
<>aColorNames{13}:="Light Grey"
<>aColorNames{14}:="Brown"
<>aColorNames{15}:="Grey"
<>aColorNames{16}:="Black"

ARRAY TEXT:C222(<>arrmonth; 12)
<>arrmonth{1}:="January"
<>arrmonth{2}:="February"
<>arrmonth{3}:="March"
<>arrmonth{4}:="April"
<>arrmonth{5}:="May"
<>arrmonth{6}:="June"
<>arrmonth{7}:="July"
<>arrmonth{8}:="August"
<>arrmonth{9}:="September"
<>arrmonth{10}:="October"
<>arrmonth{11}:="November"
<>arrmonth{12}:="December"

ARRAY TEXT:C222(<>ysSDayNames; 7)  //Short Day Names
<>ysSDayNames{1}:="Sun"
<>ysSDayNames{2}:="Mon"
<>ysSDayNames{3}:="Tue"
<>ysSDayNames{4}:="Wed"
<>ysSDayNames{5}:="Thu"
<>ysSDayNames{6}:="Fri"
<>ysSDayNames{7}:="Sat"
ARRAY TEXT:C222(<>ysLDayNames; 7)  //Long Day Names
<>ysLDayNames{1}:="Sunday"
<>ysLDayNames{2}:="Monday"
<>ysLDayNames{3}:="Tuesday"
<>ysLDayNames{4}:="Wednesday"
<>ysLDayNames{5}:="Thursday"
<>ysLDayNames{6}:="Friday"
<>ysLDayNames{7}:="Saturday"
//

