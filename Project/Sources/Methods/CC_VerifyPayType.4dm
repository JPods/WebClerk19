//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-11-24T00:00:00, 09:36:43
// ----------------------------------------------------
// Method: CC_VerifyPayType
// Description
// Modified: 11/24/16
// 
// 
//
// Parameters
// ----------------------------------------------------



//    CC_ReturnCardType

If (False:C215)
	//Date: 04/17/02
	//Who: Janani, Arkware
	//Description: Included the method which is called from diaMakePay form repeatedly
	VERSION_960
End if 
pCardApprv:="Pend"

If (<>aPayTypes>0)
	pCCType:=<>aPayTypes{<>aPayTypes}
End if 
Case of 
	: (allowAlerts_boo=False:C215)
		// drop out if on web
	: (pCreditCard="")
		// Modified by: williamjames (111216 checked for <= length protection)
	: (<>aPayTypes{<>aPayTypes}="")
		
	: ((<>aPayTypes{<>aPayTypes}[[1]]="A") & (<>aTndClass{<>aPayTypes}=<>ciTCCrdtCrd))
		If (pCreditCard[[1]]#"3")
			BEEP:C151
			BEEP:C151
			ALERT:C41("Payment type doesn't match card number!")
		End if 
	: ((<>aPayTypes{<>aPayTypes}[[1]]="V") & (<>aTndClass{<>aPayTypes}=<>ciTCCrdtCrd))
		If (pCreditCard[[1]]#"4")
			BEEP:C151
			BEEP:C151
			ALERT:C41("Payment type doesn't match card number!")
		End if 
	: ((<>aPayTypes{<>aPayTypes}[[1]]="M") & (<>aTndClass{<>aPayTypes}=<>ciTCCrdtCrd))
		If (pCreditCard[[1]]#"5")
			BEEP:C151
			BEEP:C151
			ALERT:C41("Payment type doesn't match card number!")
		End if 
	: ((<>aPayTypes{<>aPayTypes}[[1]]="D") & (<>aTndClass{<>aPayTypes}=<>ciTCCrdtCrd))
		If (pCreditCard[[1]]#"6")
			BEEP:C151
			BEEP:C151
			ALERT:C41("Payment type doesn't match card number!")
		End if 
End case 



//If ($1=$2)
////v1:="Address"
////v2:="Zip"
//If (optKey=0)
////pCkNum:=[Customer]Zip
////pBank:=[Customer]Address1
//
//End if 
//Else 
////v1:="Bank"
////v2:="Check#"
//If (optKey=0)
//pCkNum:=""
//pBank:=""
//pCardApprv:=""
//End if 
//End if 