//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Pay_InitializeVars
	//Date: 03/11/03
	//Who: Bill
	//Description: Consolidate Variable setup
End if 
bCredit:=0
prntAcct:=[Customer:2]customerID:1
bApproved:=False:C215
pDateRcd:=Current date:C33
pDateDeposited:=Current date:C33
pCkNum:=""
pCreditCard:=[Customer:2]creditCardNum:53
If ((<>tcCCStoragePolicy#3) & (BLOB size:C605([Customer:2]creditCardBlob:117)>0))  //keep the card info
	pCreditCard:=CC_EncodeDecode(0; ""; ->[Customer:2]creditCardBlob:117)
End if 
pCreditCardLast4:=[Customer:2]creditCardNum:53
pDateExpire:=[Customer:2]creditCardExpir:54
pCVV:=[Customer:2]creditCardCVV:114

pvAddress1:=[Customer:2]address1:4
pvAddress2:=[Customer:2]address2:5
pvCity:=[Customer:2]city:6
pvState:=[Customer:2]state:7
pvZip:=[Customer:2]zip:8
pvCountry:=[Customer:2]country:9
pvCompany:=[Customer:2]company:2
prntAttn:=[Customer:2]nameFirst:73+(" "*(Num:C11([Customer:2]nameFirst:73#"")))+[Customer:2]nameLast:23
pvCompanyPay:=[Customer:2]company:2

pCCDateStr:=Date_StrMMYY([Customer:2]creditCardExpir:54)
pCardApprv:=""
pReferNum:=""
pBank:=""
pDescript:=""
pvProcessorTransID:=""
pvError:=""
vsReferNum:=""
vsRspnText:=""
pvCardExpire:=""
pCkNum:=""
pvStatus:=""
If ((<>aPayTypes<1) & (Size of array:C274(<>aPayTypes)>0))
	<>aPayTypes:=1
End if 
If (<>aPayTypes>0)
	pCCType:=<>aPayTypes{<>aPayTypes}
End if 
//
If (<>aPayAction>1)
	pvCardAction:=<>aPayAction{<>aPayAction}
Else 
	pvCardAction:=""
End if 