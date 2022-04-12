//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/28/21, 12:01:35
// ----------------------------------------------------
// Method: setChMfgs
// Description
// 
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($i; $k)
MESSAGES OFF:C175
// ### bj ### 20210828_1154  ChangeToStorage

// Modified by: Bill James (8/28/21) ChangeToStorage

ARRAY TEXT:C222(<>aMfg; $k)
ARRAY LONGINT:C221(<>aMfgIdKey; $k)
ARRAY TEXT:C222(<>aMfgName; $k)
var $obRec; $obSel : Object
$obSel:=ds:C1482.Customer.query("mfrLocationid < -1999999")
For each ($obRec; $obSel)
	APPEND TO ARRAY:C911(<>aMfg; $obRec.customerID)
	APPEND TO ARRAY:C911(<>aMfgIdKey; $obRec.mfrLocationid)
	APPEND TO ARRAY:C911(<>aMfgName; $obRec.company)
End for each 

SORT ARRAY:C229(<>aMfg; <>aMfgIdKey; <>aMfgName)
<>aMfg{0}:=""
<>aMfg:=0
MESSAGES ON:C181
