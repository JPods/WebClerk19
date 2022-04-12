//%attributes = {"publishedWeb":true}
//Method: Prs_InitVarPrcs
C_LONGINT:C283(<>vEoF)  // ### jwm ### 20160705_1324
//C_TEXT(<>vEoF)
<>vEoF:=1000000000  //Char(3) 1073741824 = 1 gig

//<>vEoF:=Char(3)  //  End of text  // ### jwm ### 20160705_1120 unless file contains this character it will read the entire file.
//<>vEoF:=Char(4)  //  End of transmission
//  <>vEoF:=Char(26)  // substitute
C_LONGINT:C283(<>FreightService)  // freight as a web service = 2

C_BOOLEAN:C305(<>tcbDoStat)
C_LONGINT:C283(<>overTheCntr; <>vlWcGetSpec; <>viWebPriceLevel)
C_LONGINT:C283(<>prcControl; <>viItemXRef)
ARRAY TEXT:C222(<>aSrchCode; 0)
Rpt_RayManage(0)
NTKString__InitHTMLEntities
//
//
//Compiler_Variables_Inter 
//Compiler_Arrays_Inter 

ARRAY TEXT:C222(<>atConsoleMessage; 0)  // ### jwm ### 20160711_1328 Console Message Buffer 

ARRAY LONGINT:C221(<>aPrsRelatedParentTable; 0)
ARRAY LONGINT:C221(<>aPrsRelatedParentRecord; 0)
//
ARRAY LONGINT:C221(<>aiCOPRWide1; 0)
ARRAY LONGINT:C221(<>aiCOPRSort1; 0)
//
ARRAY TEXT:C222(<>aLaunchSuff; 0)
ARRAY TEXT:C222(<>aLaunchApp; 0)
ARRAY TEXT:C222(<>aLaunchCrea; 0)
//
C_TEXT:C284(<>vItemNum; <>vItemNumCreate)
C_LONGINT:C283(<>vSoapTrack)
C_LONGINT:C283(<>vlWebTimeOutDelay)
If (<>vlWebTimeOutDelay=0)
	<>vlWebTimeOutDelay:=10
End if 
//

C_LONGINT:C283(<>viScrubEmail)
<>viScrubEmail:=1
//
C_LONGINT:C283(<>vDoubleConfirm)
C_TEXT:C284(<>vTN_OutSide)  //call techNotes from outside


C_LONGINT:C283(<>tcLateFreq; <>viTmIncr)  //time increment
<>viTmIncr:=4
C_TEXT:C284(<>passMeText1)
C_LONGINT:C283(<>tcCancelBy)
C_TEXT:C284(<>vProfile1; <>vProfile2; <>vProfile3; <>vProfile4; <>vProfile5; <>vProfile6; <>vProfile7)
C_TEXT:C284(<>tcPriceLvlD; <>tcPriceLvlC; <>tcPriceLvlB; <>tcPriceLvlA)
C_BOOLEAN:C305(<>tcNoCodHand)
C_BOOLEAN:C305(<>booConfirm)  //Navigation, show Accept/Cancel 
C_TEXT:C284(<>tcCODTerm)
C_LONGINT:C283(<>tcDecimalTt; <>tcDecimalUP; <>tcDecimalUC)
C_TEXT:C284(<>tcMONEYCHAR)
C_TEXT:C284(<>tcFullCo)
C_LONGINT:C283(<>tcLeadDue; <>tcGrace30)
C_LONGINT:C283(<>tcGrace60; <>tcGrace90; <>tcNeedDelay)
C_LONGINT:C283(<>tcAutoFrght)

C_TEXT:C284(<>tcDialOut)  //(P) DialPhones 
C_TEXT:C284(<>tcLocalArea)
C_BOOLEAN:C305(<>tcbManyType)
C_BOOLEAN:C305(<>OrdIvcLnTrk)
C_BOOLEAN:C305(<>bBomSoExp)
//
aaaDecConsts  //do here since they are inter-Process Vars
//
C_LONGINT:C283(<>vlCOPiTab)
ARRAY LONGINT:C221(<>aiCOPiWide1; 0)
ARRAY LONGINT:C221(<>aiCOPiWide2; 0)
ARRAY LONGINT:C221(<>aiCOPiSort1; 0)
ARRAY LONGINT:C221(<>aiCOPiSort2; 0)
C_LONGINT:C283(<>vlCOPiLock1)
C_LONGINT:C283(<>vlCOPiLock2)
//
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

//
TIO_InitVars
//
//
$k:=Get last table number:C254
ARRAY LONGINT:C221(<>aPrimeRpts; $k)
For ($i; 1; $k)
	<>aPrimeRpts{$i}:=-1
End for 
READ ONLY:C145([UserReport:46])
QUERY:C277([UserReport:46]; [UserReport:46]isPrimary:15=True:C214; *)
QUERY:C277([UserReport:46];  & [UserReport:46]active:1=True:C214)
FIRST RECORD:C50([UserReport:46])
For ($i; 1; Records in selection:C76([UserReport:46]))
	<>aPrimeRpts{[UserReport:46]tableNum:3}:=Record number:C243([UserReport:46])
	NEXT RECORD:C51([UserReport:46])
End for 
//
QUERY:C277([UserReport:46]; [UserReport:46]name:2="Srch@"; *)
QUERY:C277([UserReport:46];  & [UserReport:46]active:1=True:C214)
SELECTION TO ARRAY:C260([UserReport:46]name:2; <>aSrchCode)
REDUCE SELECTION:C351([UserReport:46]; 0)
READ WRITE:C146([UserReport:46])
//
//jsetChArrays //must be before new Co records

setTypeSalePopu  //after defaults
setCurrencyRay  //after defaults
//
QUERY:C277([Customer:2]; [Customer:2]company:2="Over-the-Counter"; *)
QUERY:C277([Customer:2];  | [Customer:2]company:2="*Over the Counter"; *)
QUERY:C277([Customer:2];  | [Customer:2]customerID:1="OverCntr")
If (Records in selection:C76([Customer:2])>0)
	FIRST RECORD:C50([Customer:2])
	<>overTheCntr:=Record number:C243([Customer:2])
Else 
	<>overTheCntr:=0
End if 
//
READ ONLY:C145([DefaultAccount:32])  //keep out of jSetPayTypes, used in accept record gp
GOTO RECORD:C242([DefaultAccount:32]; 0)
jSetPayTypes
//AllowAccess ([Default]AllowAppleEvent)
UNLOAD RECORD:C212([DefaultAccount:32])
// 
// 
//
ARRAY TEXT:C222(<>aPrecDis; 5)
<>aPrecDis{1}:="0."
<>aPrecDis{2}:="0.0"
<>aPrecDis{3}:="0.00"
<>aPrecDis{4}:="0.000"
<>aPrecDis{5}:="0.0000"
//
MESSAGES ON:C181
//  MESSAGE("Thank you.")
//
//  ConsoleMessage ("TEST: Thank you.")

C_LONGINT:C283(<>iPopFont)
<>iPopFont:=0
//
ARRAY TEXT:C222(<>pTnd1Class; 7)
<>pTnd1Class{1}:="Cash"
<>pTnd1Class{2}:="Check"
<>pTnd1Class{3}:="Credit Card"
<>pTnd1Class{4}:="A/R Tender"
<>pTnd1Class{5}:="Other1"
<>pTnd1Class{6}:="Other2"
<>pTnd1Class{7}:="Other3"
<>pTnd1Class:=1
COPY ARRAY:C226(<>pTnd1Class; <>pTnd2Class)
<>pTnd2Class:=1
COPY ARRAY:C226(<>pTnd1Class; <>pTnd3Class)
<>pTnd3Class:=1
COPY ARRAY:C226(<>pTnd1Class; <>pTnd4Class)
<>pTnd4Class:=1
COPY ARRAY:C226(<>pTnd1Class; <>pTnd5Class)
<>pTnd5Class:=1
COPY ARRAY:C226(<>pTnd1Class; <>pTnd6Class)
<>pTnd6Class:=1
COPY ARRAY:C226(<>pTnd1Class; <>pTnd7Class)
<>pTnd7Class:=1
COPY ARRAY:C226(<>pTnd1Class; <>pTnd8Class)
<>pTnd8Class:=1
COPY ARRAY:C226(<>pTnd1Class; <>pTnd9Class)
<>pTnd9Class:=1
COPY ARRAY:C226(<>pTnd1Class; <>pTnd10Class)
<>pTnd10Class:=1

ARRAY TEXT:C222(<>aCCIssuer; 9)  //list of Credit Card Issuers
C_LONGINT:C283(<>ciCCIUnknwn)
<>ciCCIUnknwn:=0
<>aCCIssuer{1}:="Unknown"  //#0 add 1 to index when using
C_LONGINT:C283(<>ciCCIVisa)
<>ciCCIVisa:=1
<>aCCIssuer{2}:="Visa"  //#1
C_LONGINT:C283(<>ciCCIMstrCd)
<>ciCCIMstrCd:=2
<>aCCIssuer{3}:="MasterCard"
C_LONGINT:C283(<>ciCCIAmEx)
<>ciCCIAmEx:=3
<>aCCIssuer{4}:="Amex"
C_LONGINT:C283(<>ciCCICartBl)
<>ciCCICartBl:=4
<>aCCIssuer{5}:="Carte"
C_LONGINT:C283(<>ciCCIDiners)
<>ciCCIDiners:=5
<>aCCIssuer{6}:="Diners"
C_LONGINT:C283(<>ciCCIDiscov)
<>ciCCIDiscov:=6
<>aCCIssuer{7}:="Discover"
C_LONGINT:C283(<>ciCCIJCB)
<>ciCCIJCB:=7
<>aCCIssuer{8}:="JCB"
C_LONGINT:C283(<>ciCCIOther)
<>ciCCIOther:=8
<>aCCIssuer{9}:="Other"
ARRAY TEXT:C222(yAuthStatus; 9)  //list of Credit Card Issuers
//Tender Authorization Status
yAuthStatus{1}:="pend"  //index=1 while const=0; add 1 for use
C_LONGINT:C283(<>ciTASPend)  //pending
<>ciTASPend:=0
yAuthStatus{2}:="auth"
C_LONGINT:C283(<>ciTASAuthed)  //authorized
<>ciTASAuthed:=1
yAuthStatus{3}:="dcld"
C_LONGINT:C283(<>ciTASDeclin)  //declined
<>ciTASDeclin:=2
yAuthStatus{4}:="rfer"
C_LONGINT:C283(<>ciTASPhone)  //referal (Phone bank)
<>ciTASPhone:=3
yAuthStatus{5}:="err"
C_LONGINT:C283(<>ciTASError)  //error
<>ciTASError:=4
yAuthStatus{6}:="void"
C_LONGINT:C283(<>ciTASVoided)  //voided
<>ciTASVoided:=5
yAuthStatus{7}:="othr"
C_LONGINT:C283(<>ciTASOther)  //other
<>ciTASOther:=6
yAuthStatus{8}:="pkup"
C_LONGINT:C283(<>ciTASPickUp)  //pick-up Card
<>ciTASPickUp:=7
yAuthStatus{9}:="hide"
C_LONGINT:C283(<>ciTASHideError)  //Error reported elsewhere hide error here
<>ciTASHideError:=8

//
ARRAY TEXT:C222(<>aCostCause; 3)
<>aCostCause{1}:="p"  //planned
<>aCostCause{2}:="i"  //internal change in scope
<>aCostCause{3}:="c"  //customer directed change

//
//User Report Type and Creator Pairs
ARRAY TEXT:C222(<>yURptTypes; 15)
ARRAY TEXT:C222(<>yURptDTypes; 15)  //created on the Fly to hold a distinct set of Doc Types
ARRAY TEXT:C222(<>yURptCreatr; 15)
<>yURptTypes{1}:="Other"  //1 must always be other
<>yURptCreatr{1}:=""
<>yURptTypes{2}:="SuperReport"
<>yURptCreatr{2}:="GTSR"
<>yURptTypes{3}:="QuickReport"
<>yURptCreatr{3}:="JITA"
<>yURptTypes{4}:="Script"
<>yURptCreatr{4}:="FRmk"
<>yURptTypes{5}:="Text-Out"
<>yURptCreatr{5}:="TxtO"
<>yURptTypes{6}:="EDI-Out"
<>yURptCreatr{6}:="EDIO"
<>yURptTypes{7}:="EDI In"
<>yURptCreatr{7}:="EDII"
<>yURptTypes{8}:="Script"
<>yURptCreatr{8}:="EDIx"
<>yURptTypes{9}:="Service"
<>yURptCreatr{9}:="MySv"
<>yURptTypes{10}:="Schedule"
<>yURptCreatr{10}:="ScOp"
<>yURptTypes{11}:="TinyMCE"
<>yURptCreatr{11}:="TMCE"
<>yURptTypes{12}:="Email"
<>yURptCreatr{12}:="Mail"
<>yURptTypes{13}:="Fax Attachment"
<>yURptCreatr{13}:="4com"
<>yURptTypes{14}:="Browser"
<>yURptCreatr{14}:="Brow"
<>yURptTypes{15}:="Clipboard"
<>yURptCreatr{15}:="Clip"
//
//fill the Fax Attachment Pop-up and the related UniqueID array
//ConsoleMessage ("TEST: URpt_FillFaxAtt")  // ### jwm ### 20190930_1827 what was the purpose of doing this ???
URpt_FillFaxAtt
//
//set-up for ELog_NewRecord
C_LONGINT:C283(<>lELogLastDT)
<>lELogLastDT:=DateTime_Enter
C_TEXT:C284(<>vTextStat1; <>vTextStat2; <>vTextStat3; <>vTextStat4; <>vTextStat5)
C_TEXT:C284(<>vTextStat6; <>vTextStat7; <>vTextStat8; <>vTextStat9; <>vTextStat10)
//
ARRAY TEXT:C222(<>aLtrsCont; 0)
//
Dial_LoadArrays
//
C_BOOLEAN:C305(<>vbTEvtLogSt)
C_BOOLEAN:C305(<>vbDoQuit)
//
ARRAY TEXT:C222(<>aTechNoteNames; 1)
ARRAY LONGINT:C221(<>aTechNoteRec; 1)
ARRAY LONGINT:C221(<>aTechNoteScroll; 1)
<>aTechNoteNames{1}:="Back"
<>aTechNoteRec{1}:=-1
<>aTechNoteScroll{1}:=0
ARRAY LONGINT:C221(<>aLastRecNum; Get last table number:C254)
//
C_LONGINT:C283(<>vbItemExtender)


C_LONGINT:C283(<>vtcAltSearch)
C_LONGINT:C283(<>vbNoCustomWeb)
C_LONGINT:C283(<>vtcShowLedgers)

C_LONGINT:C283(<>viWebShow)
C_LONGINT:C283(<>vtcAutoPrint)
C_LONGINT:C283(<>vtcStrictInventory)
C_LONGINT:C283(<>vlCycleTime)
C_LONGINT:C283(<>vlCartTime)
C_LONGINT:C283(<>vlSecurityBump; viEndUserSecurityLevel)

// Authorization Mode
C_LONGINT:C283(<>ciCCAuthModeCHASE)
<>ciCCAuthModeCHASE:=1  //Auth Capture???

//
REDRAW WINDOW:C456
LineArraySize
