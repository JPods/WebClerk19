//%attributes = {"publishedWeb":true}
//Method: Sr_CustContacts
REDUCE SELECTION:C351([QQQVendor:38]; 0)
REDUCE SELECTION:C351([QQQCustomer:2]; 0)
REDUCE SELECTION:C351([QQQContact:13]; 0)
REDUCE SELECTION:C351([Lead:48]; 0)
ptPrime:=(->[Control:1])  //deactivate the New button
viFindCustChkbx:=8
jCenterWindow(472; 359; 1)
DIALOG:C40([QQQCustomer:2]; "FindCustConLead")
CLOSE WINDOW:C154
TRACE:C157
If (myOK=1)  //single click
	Case of 
		: (aCustType{aRecNum}="C")
			GOTO RECORD:C242([QQQCustomer:2]; aRecNum{aRecNum})
			REDUCE SELECTION:C351([QQQVendor:38]; 0)
			REDUCE SELECTION:C351([QQQContact:13]; 0)
			REDUCE SELECTION:C351([Lead:48]; 0)
		: (aCustType{aRecNum}="v")
			GOTO RECORD:C242([QQQVendor:38]; aRecNum{aRecNum})
			REDUCE SELECTION:C351([QQQCustomer:2]; 0)
			REDUCE SELECTION:C351([QQQContact:13]; 0)
			REDUCE SELECTION:C351([Lead:48]; 0)
		: (aCustType{aRecNum}="l")
			GOTO RECORD:C242([Lead:48]; aRecNum{aRecNum})
			REDUCE SELECTION:C351([QQQCustomer:2]; 0)
			REDUCE SELECTION:C351([QQQContact:13]; 0)
			REDUCE SELECTION:C351([QQQVendor:38]; 0)
		: (aCustType{aRecNum}="i")
			GOTO RECORD:C242([QQQContact:13]; aRecNum{aRecNum})
			REDUCE SELECTION:C351([QQQCustomer:2]; 0)
			REDUCE SELECTION:C351([Lead:48]; 0)
			REDUCE SELECTION:C351([QQQVendor:38]; 0)
	End case 
	myOK:=2
End if 