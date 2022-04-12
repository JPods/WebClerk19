//%attributes = {"publishedWeb":true}

//Procedure: Process_InitLocal
ARRAY LONGINT:C221(<>aLastRecNum; Get last table number:C254)
ARRAY LONGINT:C221(aChildProcesses; 0)
ARRAY LONGINT:C221(aSrPendRec; 0)
ARRAY LONGINT:C221(APAGEPATH; Get last table number:C254)
C_LONGINT:C283(vlStatTime)
C_POINTER:C301(ptCurTable; ptPrintFile)
C_BOOLEAN:C305(vbForceShip)
C_TEXT:C284(vPackingProcess)
C_TEXT:C284(<>vWindowTitle)
vbForceShip:=False:C215
ptPrintFile:=(->[Control:1])
If (Is nil pointer:C315(ptCurTable))
	ptCurTable:=(->[Control:1])
End if 
splashMenu:=1
//MENU BAR(1)
iLoMenu:=6
oLoMenu:=6
C_LONGINT:C283(doQuickQuote)
//
Compiler_Variables_Inter
Date_Set
aaaLocalWebVars
ServiceArrayInit(0)
//Compiler_Arrays 
//Compiler_Methods
//Compiler_Variables 
//
aaaDecVariable
aaaDeciLoVars
aaaDecArrays
C_LONGINT:C283(vdeBugElement; vRelateLevel; viFindCustChkbx)
ARRAY LONGINT:C221(aWebRelatedTableNum; 0)
ARRAY LONGINT:C221(aWebRelatedRecNum; 0)
ARRAY TEXT:C222(aWebRelatedNote; 0)
ARRAY LONGINT:C221(aWebBaseRecNum; 0)

ARRAY TEXT:C222(SRVarNames; 0)
ARRAY TEXT:C222(a1Text; 0)
C_TEXT:C284(v35diaStr1)
//
skipReCost:=False:C215
vUseBase:=2
// 
vIvcDirect:=False:C215  //
//
C_PICTURE:C286(vItemPict)
C_POINTER:C301(ptFile)  //;ptCurDay)
C_TEXT:C284(lbCustomer; lbAcct; lbPhone; lbZip)
lbCustomer:="Customer"
lbAcct:="Acct"
lbPhone:="Phone"
lbZip:="Zip"
lbName:="Name"
vFldDelim:=Char:C90(9)
vRecDelim:=Char:C90(13)
//
//C_LONGINT(offArea1)
//offArea1:=0
// 
viAlertTimes:=0
If (Application type:C494#4D Server:K5:6)
	
End if 

BooAccept:=True:C214  // ### jwm ### 20190805_1113
StopAddLoop:=True:C214
StopModLoop:=True:C214
C_BOOLEAN:C305(vbNxPvPage)
vbNxPvPage:=False:C215
ARRAY LONGINT:C221(aPagePath; Get last table number:C254)

