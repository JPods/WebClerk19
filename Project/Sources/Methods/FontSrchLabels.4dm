//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)  //1=srch, 2=modify, 3=locked
C_TEXT:C284(lbOrdNum; lbMfgOrd; lbCustPo; lbName)
OBJECT SET ENABLED:C1123(bNewRec; True:C214)
Case of 
	: ($1=1)  //searching
		OBJECT SET FONT STYLE:C166(lbCustomer; 5)
		OBJECT SET FONT STYLE:C166(lbPhone; 1)
		OBJECT SET FONT STYLE:C166(lbAcct; 5)
		OBJECT SET FONT STYLE:C166(lbZip; 1)
		OBJECT SET FONT STYLE:C166(lbName; 1)
		OBJECT SET ENTERABLE:C238(srCustomer; True:C214)
		If (Record number:C243(ptCurTable->)=-3)  //new record
			OBJECT SET ENTERABLE:C238(srAcct; True:C214)
		Else 
			If (<>tcDefaultLockAcctNbr)
				OBJECT SET ENTERABLE:C238(srAcct; False:C215)
				OBJECT SET FONT STYLE:C166(lbAcct; 6)
			Else 
				OBJECT SET ENTERABLE:C238(srAcct; True:C214)
			End if 
		End if 
		OBJECT SET ENTERABLE:C238(srPhone; True:C214)
		OBJECT SET ENTERABLE:C238(srZip; True:C214)
		OBJECT SET ENTERABLE:C238(srName; True:C214)
		//  SET ENTERABLE([Customer]FAX;True)
	: ($1=2)  //entering
		OBJECT SET FONT STYLE:C166(lbCustomer; 4)
		OBJECT SET FONT STYLE:C166(lbPhone; 0)
		OBJECT SET FONT STYLE:C166(lbAcct; 4)
		OBJECT SET FONT STYLE:C166(lbZip; 0)
		OBJECT SET FONT STYLE:C166(lbName; 0)
		OBJECT SET ENTERABLE:C238(srCustomer; True:C214)
		If (Record number:C243(ptCurTable->)=-3)  //new record
			OBJECT SET ENTERABLE:C238(srAcct; True:C214)
		Else 
			If (<>tcDefaultLockAcctNbr)
				OBJECT SET ENTERABLE:C238(srAcct; False:C215)
				OBJECT SET FONT STYLE:C166(lbAcct; 6)
			Else 
				OBJECT SET ENTERABLE:C238(srAcct; True:C214)
			End if 
		End if 
		OBJECT SET ENTERABLE:C238(srPhone; True:C214)
		OBJECT SET ENTERABLE:C238(srZip; True:C214)
		OBJECT SET ENTERABLE:C238(srName; True:C214)
		//   SET ENTERABLE([Customer]FAX;True)
	: ($1=3)  //locked
		OBJECT SET FONT STYLE:C166(lbCustomer; 6)
		OBJECT SET FONT STYLE:C166(lbPhone; 2)
		OBJECT SET FONT STYLE:C166(lbAcct; 6)
		OBJECT SET FONT STYLE:C166(lbZip; 2)
		OBJECT SET FONT STYLE:C166(lbName; 2)
		OBJECT SET ENTERABLE:C238(srName; True:C214)
		OBJECT SET ENTERABLE:C238(srCustomer; False:C215)
		// ### bj ### 20190923_0942
		//OBJECT SET RGB COLORS(srCustomer;0x0000;0x000000EE)
		OBJECT SET ENTERABLE:C238(srAcct; False:C215)
		//OBJECT SET RGB COLORS(srAcct;0x0000;0x000000EE)
		OBJECT SET ENTERABLE:C238(srPhone; False:C215)
		//OBJECT SET RGB COLORS(srPhone;0x0000;0x000000EE)
		OBJECT SET ENTERABLE:C238(srZip; False:C215)
		//OBJECT SET RGB COLORS(srZip;0x0000;0x000000EE)
		OBJECT SET ENABLED:C1123(bNewRec; False:C215)
		OBJECT SET RGB COLORS:C628(bNewRec; 0x0000; Background color none:K23:10)
		
		//  SET ENTERABLE([Customer]FAX;False)
End case 
If ((ptCurTable=(->[PO:39])) | (ptCurTable=(->[QQQPOLine:40])) | (ptCurTable=(->[QQQVendor:38])))
	lbCustomer:="Vendor"
Else 
	lbCustomer:="Customer"
End if 