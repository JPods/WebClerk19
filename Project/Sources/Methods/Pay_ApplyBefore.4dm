//%attributes = {"publishedWeb":true}
//Procedure: Pay_ApplyBefore

C_REAL:C285(pDiff; pTotal; pPayment)
b21:=1
b22:=0
b23:=0
//
REDUCE SELECTION:C351([Invoice:26]; 0)
//  //  CHOPPED FillInvArrays(Records in selection([Invoice]); 0; 0; eIvc2Pay)
//  CHOPPEDIvc_ALDefine(eIvc2Pay)
//
REDUCE SELECTION:C351([Payment:28]; 0)
//  //  CHOPPED FillPayArrays(Records in selection([Payment]); 0; 0; ePay2App)
//  CHOPPEDPay_ALDefine(ePay2App; 0)

aPayInvs:=0
aInvoices:=0
vi5:=aPayInvs
vi6:=aInvoices
v1:=""
v2:=""
v3:=""
v4:=""
UNLOAD RECORD:C212([Customer:2])
srCustomer:=""
srPhone:=""
srAcct:=""
srZip:=""
srDivision:=""

pTotal:=0
pPayment:=0
pDiff:=0
OBJECT SET ENABLED:C1123(b24; False:C215)
OBJECT SET ENABLED:C1123(b26; False:C215)
OBJECT SET ENABLED:C1123(bPayment; False:C215)
OBJECT SET ENABLED:C1123(b28; False:C215)
OBJECT SET ENABLED:C1123(b10; False:C215)
OBJECT SET ENABLED:C1123(b11; False:C215)
OBJECT SET ENABLED:C1123(b12; False:C215)
OBJECT SET ENABLED:C1123(b13; False:C215)
OBJECT SET ENABLED:C1123(b14; False:C215)
OBJECT SET ENABLED:C1123(bCancelB; False:C215)
bCredit:=0