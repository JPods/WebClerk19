//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/25/10, 12:01:58
// ----------------------------------------------------
// Method: aaaDecArrays
// Description
// 
//
// Parameters
// ----------------------------------------------------
//


ARRAY TEXT:C222(ddEmail; 0)
APPEND TO ARRAY:C911(ddEmail; "View html")
APPEND TO ARRAY:C911(ddEmail; "Edit html")
APPEND TO ARRAY:C911(ddEmail; "Save html")

ARRAY TEXT:C222(ddPathToOriginal; 0)
APPEND TO ARRAY:C911(ddPathToOriginal; "View as text")
APPEND TO ARRAY:C911(ddPathToOriginal; "View as Email")

ARRAY TEXT:C222(<>atMapTables; 1)
ARRAY OBJECT:C1221(<>aobMapFields; 1)
<>atMapTables{1}:="SyncRecord"
<>aobMapFields{1}:=JSON Parse:C1218("{\"ApprovedBySend\":\"ApprovedBySend\",\"Date\":\"Date\",\"Relationship\":\"Relationship\",\"Size\":\"Size\",\"UUIDKeyOurs\":\"UUIDKeyOurs\"}")

// ### AZM ### 20171206_1115 // ADDED TO USE WITH HTML_BuildOptions() TO DISPLAY BOOLEANS AS HTML SELECTS
ARRAY TEXT:C222(atBooleans10; 0)
APPEND TO ARRAY:C911(atBooleans10; "0")
APPEND TO ARRAY:C911(atBooleans10; "1")
ARRAY TEXT:C222(atBooleansTF; 0)
APPEND TO ARRAY:C911(atBooleansTF; "False")
APPEND TO ARRAY:C911(atBooleansTF; "True")
ARRAY TEXT:C222(atBooleansYN; 0)
APPEND TO ARRAY:C911(atBooleansYN; "No")
APPEND TO ARRAY:C911(atBooleansYN; "Yes")

// ### azm ### 20180112_1424 added for server side logging of changes similar to // zzzqqq U_DTStampFldMod
ARRAY TEXT:C222(atSavedFieldNames; 0)
ARRAY TEXT:C222(atSavedFieldValuesNew; 0)
ARRAY TEXT:C222(atSavedFieldValuesOld; 0)

ARRAY TEXT:C222(aExecuteScript; 0)
ARRAY TEXT:C222(aExecuteScript; 0)

ARRAY TEXT:C222(<>atConsoleMessage; 0)

ARRAY TEXT:C222(aSetCookie; 0)  // ### jwm ### 20160315_1203 used by method SetCookie
ARRAY TEXT:C222(aBadWords; 0)
ARRAY LONGINT:C221(aOrderLineStack; 0)
ARRAY LONGINT:C221(aInvoiceLineStack; 0)
ARRAY LONGINT:C221(aProposalLineStack; 0)
ARRAY LONGINT:C221(aPOLineStack; 0)

ARRAY TEXT:C222(aShoppingCartItem; 0)
ARRAY REAL:C219(aShoppingCartQty; 0)
ARRAY TEXT:C222(<>aProcessPass1; 0)
ARRAY TEXT:C222(<>aProcessPass2; 0)
ARRAY TEXT:C222(<>aProcessPass3; 0)
ARRAY TEXT:C222(<>aProcessPass4; 0)
ARRAY TEXT:C222(<>aProcessPass5; 0)
ARRAY TEXT:C222(<>aProcessPass6; 0)
ARRAY TEXT:C222(atEmailCC; 0)
ARRAY TEXT:C222(atEmailBCC; 0)
ARRAY TEXT:C222(atEmailAttachments; 0)
//
ARRAY TEXT:C222(aTCP; 0)
C_REAL:C285(pCostTax)
C_TEXT:C284(pLocationBin)
//
ARRAY TEXT:C222(aPages; 0)
ARRAY TEXT:C222(aElectroZip; 0)
ARRAY LONGINT:C221(aLineCnts; 4)
Exch_InitRays(0)
SRpt_StRayClr(0)
ARRAY TEXT:C222(aElec20Str1; 0)
ARRAY TEXT:C222(aElec20Str2; 0)
ARRAY TEXT:C222(aElec20Str3; 0)
//
ARRAY TEXT:C222(aProOrName; 0)  //name rays
ARRAY TEXT:C222(aProOrValue; 0)  //name rays
ARRAY LONGINT:C221(aProOrRec; 0)  //name rays
ARRAY LONGINT:C221(aProOrSeq; 0)  //name rays
//
//ARRAY REAL(aInvTotal;0)//from adding and applying cash -- Customer File
//ARRAY REAL(aAmtApp;0)
//ARRAY REAL(aDscnt;0)
//ARRAY REAL(aCheckApp;0)
//ARRAY REAL(aCheckTotal;0)
//
ARRAY TEXT:C222(aAttributes; 1)
ARRAY TEXT:C222(aAttCodes; 1)
ARRAY LONGINT:C221(aAttNums; 1)
ARRAY TEXT:C222(aCauses; 1)
aAttributes:=1
aAttributes{1}:="Attribute"
aCauses{1}:="Causes"
aCauses:=1
//
ARRAY TEXT:C222(aTNName; 0)
ARRAY TEXT:C222(aTNSub; 0)
ARRAY LONGINT:C221(aTNRec; 0)
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

//07/15/03.prf
//new arrays for field filtering
//array TEXT(theFieldsOriginal;0)
//array TEXT(theFieldsFilter;0)
//array TEXT(theTypesFilter;0)
//array TEXT(theUniquesFilter;0)
//ARRAY LONGINT(theFldNumFilter;0)//09/10/03.prf 
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
ARRAY LONGINT:C221(aOpenOrders; 0)  //use in Selecting Orders to Invoice Arrays
ARRAY DATE:C224(aNeedDates; 0)
ARRAY DATE:C224(aComDates; 0)
ARRAY LONGINT:C221(aSelRecs; 0)
//
ARRAY POINTER:C280(arrformat; 0)
//
ARRAY LONGINT:C221(aRecNum; 0)

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
ARRAY TEXT:C222(aText1; 0)
ARRAY TEXT:C222(aText2; 0)
ARRAY TEXT:C222(aText3; 0)
ARRAY TEXT:C222(aText4; 0)
ARRAY TEXT:C222(aText5; 0)
ARRAY TEXT:C222(aText6; 0)
ARRAY TEXT:C222(aText7; 0)
ARRAY TEXT:C222(aText8; 0)
ARRAY TEXT:C222(aText9; 0)
ARRAY TEXT:C222(aText10; 0)
ARRAY TEXT:C222(aText11; 0)
ARRAY TEXT:C222(aText12; 0)
ARRAY TEXT:C222(aText13; 0)
ARRAY TEXT:C222(aText14; 0)
ARRAY TEXT:C222(aText15; 0)
ARRAY TEXT:C222(aText16; 0)
ARRAY TEXT:C222(aText17; 0)
ARRAY TEXT:C222(aText18; 0)
ARRAY TEXT:C222(aText19; 0)
ARRAY TEXT:C222(aText20; 0)
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
ARRAY TEXT:C222(aFCItem; 0)
ARRAY TEXT:C222(aFCDesc; 0)
ARRAY DATE:C224(aFCActionDt; 0)
ARRAY REAL:C219(aFCBomCnt; 0)
ARRAY REAL:C219(aFCRunQty; 0)
ARRAY REAL:C219(aFCBaseQty; 0)
ARRAY TEXT:C222(aFCBomLevel; 0)
ARRAY TEXT:C222(aFCParent; 0)
ARRAY TEXT:C222(aFCTypeTran; 0)
ARRAY LONGINT:C221(aFCDocID; 0)
ARRAY LONGINT:C221(aFCRecNum; 0)
ARRAY TEXT:C222(aFCWho; 0)
ARRAY REAL:C219(aFCTallyLess2Year; 0)
ARRAY REAL:C219(aFCTallyLess1Year; 0)
ARRAY REAL:C219(aFCTallyYTD; 0)

ARRAY TEXT:C222(aFCShortItem; 0)
ARRAY REAL:C219(aFCShortBaseQty; 0)
ARRAY REAL:C219(aFCShortTallyLess2Year; 0)
ARRAY REAL:C219(aFCShortTallyLess1Year; 0)
ARRAY REAL:C219(aFCShortTallyYTD; 0)
//
//Date: 03/20/02 PRF
ARRAY TEXT:C222(aZipCode; 0)
ARRAY TEXT:C222(aZipCity; 0)
ARRAY TEXT:C222(aZipState; 0)
ARRAY TEXT:C222(aZipPrefCity; 0)
//
ARRAY LONGINT:C221(aOrdLnSel; 0)
//
PpLnInitRays
OrdLnRays(0)
IvcLnFillRays(0)
//PoLnFillRays (0)
List_RaySize(0)
Exch_InitRays(0)
IVNT_dRayInit
ServiceArrayInit(0)
Temp_RayInit
//
POLn_RaySize(0; 0; 0)
WO_FillArrays(0)
TC_FillArrays(0)
Wd_FillRay(0)
//
ARRAY TEXT:C222(aContact; 0)
ARRAY TEXT:C222(aShipTo; 0)
//
ARRAY LONGINT:C221(aSrPendAct; 0)  //initialize the array for tracking changes in serial numbers
//1, add; 2, issue; 3, purchase; 4, delete (return)
ARRAY LONGINT:C221(aSrPendRec; 0)
ARRAY LONGINT:C221(aSrPendLn; 0)
//
ARRAY REAL:C219(aReal1; 0)
ARRAY REAL:C219(aReal2; 0)
ARRAY REAL:C219(aReal3; 0)
ARRAY REAL:C219(aReal4; 0)
ARRAY REAL:C219(aReal5; 0)
ARRAY REAL:C219(aReal6; 0)
ARRAY REAL:C219(aReal7; 0)
ARRAY REAL:C219(aReal8; 0)
ARRAY REAL:C219(aReal9; 0)
ARRAY REAL:C219(aReal10; 0)
ARRAY PICTURE:C279(aPict1; 0)
ARRAY PICTURE:C279(aPict2; 0)

ARRAY DATE:C224(aDate3; 0)

ARRAY TEXT:C222(aOPiType; 0)
ARRAY TEXT:C222(aOPiStatus; 0)
ARRAY LONGINT:C221(aOPiDocID; 0)
ARRAY LONGINT:C221(aOPiDocRef; 0)
ARRAY DATE:C224(aOpiDateEnd; 0)
ARRAY DATE:C224(aOPiDateBeg; 0)
ARRAY DATE:C224(aOPiNeed; 0)
ARRAY REAL:C219(aOPiAmt; 0)
ARRAY REAL:C219(aOPiOpen; 0)
ARRAY TEXT:C222(aOPiPO; 0)
ARRAY TEXT:C222(aOPiAttn; 0)
ARRAY TEXT:C222(aOPiRep; 0)
ARRAY TEXT:C222(aOPiSale; 0)
ARRAY TEXT:C222(aOPiPro1; 0)
ARRAY TEXT:C222(aOPiPro2; 0)
ARRAY TEXT:C222(aOPiPro3; 0)
ARRAY LONGINT:C221(aOPiRecID; 0)
//
ARRAY TEXT:C222(aLoOrdComme; 9)
aLoOrdComme{1}:="Process"
aLoOrdComme{2}:="Public"
aLoOrdComme{3}:="Alert"
aLoOrdComme{4}:="ShipInstructions"
aLoOrdComme{5}:="FAX"
aLoOrdComme{6}:="eMail"
aLoOrdComme{7}:="Cust/Vend Comment"
aLoOrdComme{8}:="Cust/Vend Ship"
aLoOrdComme{9}:="Cust/Vend Alert"
aLoOrdComme:=1
//
ARRAY TEXT:C222(aLoCustOPi; 9)
aLoCustOPi:=1
aLoCustOPi{1}:="All Recent"
aLoCustOPi{2}:="All"
aLoCustOPi{3}:="Proposal"
aLoCustOPi{4}:="Pp_Lines"
aLoCustOPi{5}:="Order"
aLoCustOPi{6}:="Ord_Lines"
aLoCustOPi{7}:="Invoice"
aLoCustOPi{8}:="Inv_Lines"
aLoCustOPi{9}:="Pp_Ord_Lines"
//
ARRAY TEXT:C222(<>aSelectInvField; 6)
<>aSelectInvField{1}:="Item Number"
<>aSelectInvField{2}:="Customer"
<>aSelectInvField{3}:="Last Name"
<>aSelectInvField{4}:="Phone"
<>aSelectInvField{5}:="Zip Code"
<>aSelectInvField{6}:="Account"
<>aSelectInvField:=1
//
ARRAY TEXT:C222(<>aFindCustChkbx; 10)
<>aFindCustChkbx{1}:="Customer"
<>aFindCustChkbx{2}:="Lead"
<>aFindCustChkbx{3}:="Vendor"
<>aFindCustChkbx{4}:="Customer+Lead"
<>aFindCustChkbx{5}:="Lead+Vendor"
<>aFindCustChkbx{6}:="Customer+Vendor"
<>aFindCustChkbx{7}:="Cust+Cont+Lead+Vend"
<>aFindCustChkbx{8}:="Customer+Contact"
<>aFindCustChkbx{9}:="Contact"
<>aFindCustChkbx{10}:="Cust+Cont+Vend"



ARRAY LONGINT:C221(<>aALRowRGBColor; 36)
<>aALRowRGBColor{1}:=0x00CC  //Retired, zero qty or less on-hand
<>aALRowRGBColor{2}:=0x0000  //red on yellow
<>aALRowRGBColor{3}:=0x0000
<>aALRowRGBColor{4}:=0x00FF
<>aALRowRGBColor{5}:=0x00FF
<>aALRowRGBColor{6}:=0x0099

<>aALRowRGBColor{7}:=0x0000  //Retired, greater than zero qty or less on-hand
<>aALRowRGBColor{8}:=0x0000  //black on yellow
<>aALRowRGBColor{9}:=0x0000
<>aALRowRGBColor{10}:=0x00FF
<>aALRowRGBColor{11}:=0x00FF
<>aALRowRGBColor{12}:=0x0099

<>aALRowRGBColor{13}:=0x00CC  //Backordered, zero qty or less on-hand
<>aALRowRGBColor{14}:=0x0000  //red on light gray
<>aALRowRGBColor{15}:=0x0000
<>aALRowRGBColor{16}:=0x00DD
<>aALRowRGBColor{17}:=0x00DD
<>aALRowRGBColor{18}:=0x00DD

<>aALRowRGBColor{19}:=0x0000  //Backordered, , greater than zero qty or less on-hand
<>aALRowRGBColor{20}:=0x0000  //black on light gray
<>aALRowRGBColor{21}:=0x0000
<>aALRowRGBColor{22}:=0x00DD
<>aALRowRGBColor{23}:=0x00DD
<>aALRowRGBColor{24}:=0x00DD

<>aALRowRGBColor{25}:=0x00CC  //Active, zero qty or less on-hand
<>aALRowRGBColor{26}:=0x0000  //red on white
<>aALRowRGBColor{27}:=0x0000
<>aALRowRGBColor{28}:=0x00FF
<>aALRowRGBColor{29}:=0x00FF
<>aALRowRGBColor{30}:=0x00FF

<>aALRowRGBColor{31}:=0x0000  //Active, greater than zero qty or less on-hand
<>aALRowRGBColor{32}:=0x0000  //black on white
<>aALRowRGBColor{33}:=0x0000
<>aALRowRGBColor{34}:=0x00FF
<>aALRowRGBColor{35}:=0x00FF
<>aALRowRGBColor{36}:=0x00FF

