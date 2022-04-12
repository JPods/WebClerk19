//%attributes = {"publishedWeb":true}
//Procedure: P_PpHeadVars
If (False:C215)
	//01/21/03.prf
	//Added check for [Proposal]AddressBillTo (like in P_IvcHeadVars)
	VERSION_9919
	VERSION_9919_ISC
End if 
P_ClearVars
If ([Customer:2]customerID:1#[Proposal:42]customerID:1)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Proposal:42]customerID:1)
End if 
pvTerms:=InfoTerms([Proposal:42]terms:21)
Info_TermStment(->pvTermState)
InfoRep([Proposal:42]repID:7)
InfoShipper([Proposal:42]shipVia:18)
ShipAddress:=PVars_AddressFull("Proposal")
//TRACE
//01/21/03.prf BEGIN
If ([Proposal:42]addressBillTo:71="")
	CustAddress:=PVars_AddressFull("Customer")
	MainAddress:=CustAddress
Else 
	MainAddress:=PVars_AddressFull("Customer")
	CustAddress:=[Proposal:42]addressBillTo:71
End if 
//01/21/03.prf END
pvPayments:="Payments managed in Orders and Invoices"
pvPhone:=Format_Phone([Customer:2]phone:13)

pvPhoneCo:=Format_Phone([Customer:2]phone:13)
pvFAX:=Format_Phone([Customer:2]fax:66)
pvFaxCo:=Format_Phone([Customer:2]fax:66)
pveMailAddressCo:=[Customer:2]email:81

pvDocPhone:=Format_Phone([Proposal:42]phone:24)
pvPhoneDoc:=Format_Phone(pvPhoneDoc)
//////
If ([Proposal:42]country:17="")
	pvCountry:="US"
Else 
	pvCountry:=[Proposal:42]country:17
End if 
pvAddressiS:=""
pvAddressiB:=""
pvPhoneiS:=""
pvPhoneiB:=""
pvFaxiS:=""
pvFaxiB:=""
pvAddressiS:=""
pvAddressiB:=""
If ([Proposal:42]contactBillTo:73>0)
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Proposal:42]contactBillTo:73)
Else 
	REDUCE SELECTION:C351([Contact:13]; 0)
End if 
pvPhoneDoc:=Prnt_ValuePriority([Proposal:42]phone:24; [Contact:13]phone:30; [Customer:2]phone:13)
pvPhoneDoc:=Format_Phone(pvPhoneDoc)
pvFaxDoc:=Prnt_ValuePriority([Proposal:42]fax:67; [Contact:13]fax:31; [Customer:2]fax:66)
pvFaxDoc:=Format_Phone(pvFaxDoc)
pveMailAddressDoc:=Prnt_ValuePriority([Proposal:42]email:68; [Contact:13]email:35; [Customer:2]email:81)
pveMailAddressDoc:=pveMailAddressDoc
//
pvPhoneiB:=Prnt_ValuePriority([Contact:13]phone:30; [Customer:2]phone:13)
pvPhoneiB:=Format_Phone(pvPhoneiB)
pvFaxiB:=Prnt_ValuePriority([Contact:13]fax:31; [Customer:2]fax:66)
pvFaxiB:=Format_Phone(pvFaxiB)
//
pveMailAddressiB:=Prnt_ValuePriority([Contact:13]email:35; [Customer:2]email:81)
pveMailAddressiB:=pveMailAddressi
Case of 
	: (Record number:C243([Contact:13])>-1)
		BillAddress:=PVars_AddressFull("Contact")
	: ([Proposal:42]addressBillTo:71#"")
		BillAddress:=[Proposal:42]addressBillTo:71
	Else 
		BillAddress:=MainAddress
End case 
If ([Proposal:42]contactShipTo:63>0)
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Proposal:42]contactShipTo:63)
Else 
	REDUCE SELECTION:C351([Contact:13]; 0)
End if 
If (Records in selection:C76([Contact:13])=1)
	ShipAddress:=PVars_AddressFull("Contact")
End if 
pvPhoneiS:=Prnt_ValuePriority([Contact:13]phone:30; [Customer:2]phone:13)
pvPhoneiS:=Format_Phone(pvPhoneiS)
pvFaxiS:=Prnt_ValuePriority([Contact:13]fax:31; [Customer:2]fax:66)
pvFaxiS:=Format_Phone(pvFaxiS)
pveMailAddressiS:=Prnt_ValuePriority([Contact:13]email:35; [Customer:2]email:81)
pveMailAddressiS:=pveMailAddressiS
If (vHere>1)
	//  CHOPPED  ContactsLoad(-1)
End if 
//////
If (([Proposal:42]currency:55#"") & ([Proposal:42]currency:55#<>tcMONEYCHAR))
	If (vHere<2)
		Exch_GetCurr([Proposal:42]currency:55)
	End if 
	$k:=Size of array:C274(aPItemNum)
	Exch_InitRays($k)
	$extExAmt:=0
	$extExTax:=0
	fExExtShip:=0
	For ($incLn; 1; $k)
		aExTaxOut{$incLn}:=Round:C94(aPSaleTax{$incLn}*[Proposal:42]exchangeRate:54; viExDisPrec)
		$extExTax:=$extExTax+aExTaxOut{$incLn}
		aExUnitPrc{$incLn}:=Round:C94(DiscountApply(aPUnitPrice{$incLn}; aPDiscnt{$incLn}; viExConPrec)*[Proposal:42]exchangeRate:54; viExDisPrec)
		$extExAmt:=$extExAmt+Round:C94(aExUnitPrc{$incLn}*aPQtyOrder{$incLn}; viExDisPrec)
	End for 
	fExExtAmt:=$extExAmt
	fExExtTax:=$extExTax
	fExExtShip:=Round:C94([Proposal:42]shipTotal:31*[Proposal:42]exchangeRate:54; viExDisPrec)
	fExExtTtl:=$extExAmt+$extExTax+fExExtShip
Else 
	fExExtAmt:=[Proposal:42]amount:26
	fExExtTax:=[Proposal:42]salesTax:27
	fExExtShip:=[Proposal:42]shipTotal:31
	fExExtTtl:=[Proposal:42]total:32
End if 
If (<>vbDoOldVars=1)
	P_Old_ToP_VarsHeader
End if 

$tempSecureLevel:=vWccSecurity
vWccSecurity:=0
WccExecuteTask("PrintHeader"; Table:C252(->[Proposal:42]))
vWccSecurity:=$tempSecureLevel
curLines:=0
