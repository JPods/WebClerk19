C_LONGINT:C283(bpayAlt)
REDUCE SELECTION:C351([Payment:28]; 0)
//  //  CHOPPED FillPayArrays(Records in selection([Payment]); 0; 0; ePay2App)
sAltCo:=""
sAltAcct:=""
sAltPhone:=""
sAltZip:=""
sAltDivision:=""

If (bpayAlt=1)
	OBJECT SET ENTERABLE:C238(sAltCo; True:C214)
	OBJECT SET ENTERABLE:C238(sAltAcct; True:C214)
	OBJECT SET ENTERABLE:C238(sAltPhone; True:C214)
	OBJECT SET ENTERABLE:C238(sAltZip; True:C214)
Else 
	OBJECT SET ENTERABLE:C238(sAltCo; False:C215)
	OBJECT SET ENTERABLE:C238(sAltAcct; False:C215)
	OBJECT SET ENTERABLE:C238(sAltPhone; False:C215)
	OBJECT SET ENTERABLE:C238(sAltZip; False:C215)
End if 