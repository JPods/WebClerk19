//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-06-23T00:00:00, 12:55:23
// ----------------------------------------------------
// Method: WC_ServerInit
// Description
// Modified: 06/23/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
ARRAY TEXT:C222(aCookies; 0)
ARRAY TEXT:C222(aCookieName; 0)
ARRAY TEXT:C222(aCookieValue; 0)
C_LONGINT:C283(vLineStyleMod)
vLineStyleMod:=2
webLog:=""

eventID_Cookie:=""
allowAlerts_boo:=False:C215  //block all everytime just in case it gets set by some script
C_TEXT:C284(vAllyData)
C_TEXT:C284(vResponse)
vResponse:=""
// ### bj ### 20200101_2016
vMimeType:=""
C_LONGINT:C283(vtaskID)
taskID:=0

vAllyData:=""
vIndex:=0
vSize:=0
vText8:=""
vURLSeeMore:=""
//vText11:=""
vlUserRec:=-1  //set to no one
vWccPrimeRec:=-1  //set to no one
vleventID:=""
viEndUserSecurityLevel:=1

vRelateLevel:=0
vWebClerkPath:=""
vTmpDateBeg:=!00-00-00!
vTmpDateEnd:=!00-00-00!
vURLSort:=""
vURLSortScript:=""  //in Http_DoSort  &  WC_eventID
vURLQuery:=""
vURLQueryScript:=""
vURLShowMore:=""
RemoteUsers_SetVars(0)
//
pCreditCard:=""
pvCreditBalance:=""
pSumBalance:=0
pvSumBalance:=""
//
pvSumQuantity:=""
pvSumPrice:=""
pvDocRef:=""
pvParseStatus:=""
pvQtyOrd:=""
pvQtyInCart:=0
pvTypeSale:=""
//webLog:=""
webCalendar:=""
//
vInAsCustomer:=""
vResponse:=""
// ### bj ### 20190108_2147
vcustomerID:=""  // cannot be interprocess or it will leak across threads
vtEmailReport:=""
//clear specialty key values
CapKey:=0
ShftKey:=0
OptKey:=0
CmdKey:=0
CtlKey:=0


jitVariable1:=""
jitVariable2:=""
jitVariable3:=""
jitVariable4:=""
jitVariable5:=""
jitVariable6:=""
jitVariable7:=""
jitVariable8:=""
jitVariable9:=""
jitVariable10:=""
jitVariable11:=""
jitVariable12:=""

Variable1:=""
Variable2:=""
Variable3:=""
Variable4:=""
Variable5:=""
Variable6:=""
Variable7:=""
Variable8:=""
Variable9:=""
Variable10:=""
Variable11:=""
Variable12:=""
Variable13:=""
Variable14:=""
Variable15:=""
Variable16:=""
Variable17:=""
Variable18:=""
Variable19:=""
Variable20:=""
//
vtEmailAttachment:=""
vtEmailReport:=""
ARRAY TEXT:C222(atEmailAttachments; 0)
//
pvQtyInCart:=0
pvTimesInCart:=0
ARRAY TEXT:C222(aShoppingCartItem; 0)
ARRAY REAL:C219(aShoppingCartQty; 0)
ARRAY LONGINT:C221(aShoppingCartTimes; 0)

returnValue:=""
returnField:=""
returnTable:=""

voState.url:=""
//vWCDocumentURI:=""

CustAddress:=""

vUUIDKeywo:=""  // workOrders
vUUIDKeyor:=""  // Orders
vUUIDKeycu:=""  // Customer
vUUIDKeyco:=""  // Contact
vUUIDKeyin:=""  // invoice
vUUIDKeypo:=""  // PO
vUUIDKeypr:=""  // Project
vUUIDKeypu:=""  // Purposal