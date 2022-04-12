//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-26T00:00:00, 09:34:21
// ----------------------------------------------------
// Method: P_PoHeadVars
// Description
// Modified: 08/26/13
// 
// 
//
// Parameters
// ----------------------------------------------------


P_ClearVars
pvTerms:=InfoTerms(process_o.cur.terms)
pvPhone:=Format_Phone(process_o.ents.Vendor.phone)
pvFAX:=Format_Phone(process_o.ents.Vendor.fax)
InfoRep(process_o.cur.salesNameID)
InfoShipper(process_o.cur.shipVia)
//infoAddresses (File(process_o.cur.);Full Name;ShipTo)
VendAddress:=PVar_AddressOnly(process_o.ent.Vendor)
ShipAddress:=PVar_AddressOnly(process_o.process_o.cur)
////
pvPhoneCo:=Format_Phone(process_o.ents.Vendor.phone)
pvFaxCo:=Format_Phone(process_o.ents.Vendor.fax)
pveMailAddressCo:=process_o.ents.Vendor.email
pvAddressiS:=""
pvAddressiB:=""
pvPhoneiS:=""
pvPhoneiB:=""
pvFaxiS:=""
pvFaxiB:=""
pvAddressiS:=""
pvAddressiB:=""
//If ([Proposal]ContactBillTo>0)
//QUERY([Contact];[Contact]UniqueID=[Proposal]ContactBillTo)
//End if 
pvPhoneDoc:=Prnt_ValuePriority(process_o.cur.phone; process_o.ents.Vendor.phone)
pvPhoneiB:=Prnt_ValuePriority(process_o.cur.phone; process_o.ents.Vendor.phone)
pvPhoneDoc:=Format_Phone(pvPhoneDoc)
pvPhoneiB:=Format_Phone(pvPhoneiB)
pvFaxDoc:=Prnt_ValuePriority(process_o.cur.fax; process_o.ents.Vendor.fax)
pvFaxiB:=Prnt_ValuePriority(process_o.cur.fax; process_o.ents.Vendor.fax)

pvFaxDoc:=Format_Phone(pvFaxDoc)
pvFAXi:=Format_Phone(pvFaxiB)
pveMailAddressDoc:=Prnt_ValuePriority(process_o.cur.email; process_o.ents.Vendor.email)
pveMailAddressiB:=pveMailAddressDoc  //Prnt_ValuePriority (process_o.cur.Email;process_o.ents.Vendor.Email)

pveMailAddressiB:=pveMailAddressi
pveMailAddressDoc:=pveMailAddressDoc

pvPhoneiS:=Prnt_ValuePriority(process_o.cur.phone; process_o.ents.Vendor.phone)
pvFaxiS:=Prnt_ValuePriority(process_o.cur.fax; process_o.ents.Vendor.fax)
pveMailAddressiS:=Prnt_ValuePriority(process_o.cur.email; process_o.ents.Vendor.email)
pveMailAddressiS:=pveMailAddressiS


$tempSecureLevel:=vWccSecurity
vWccSecurity:=0
WccExecuteTask("PrintHeader"; process_o.tableName)
vWccSecurity:=$tempSecureLevel
curLines:=0

QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=process_o.cur.idNum)
If (([UserReport:46]scriptBegin:5="rollin@") | ([UserReport:46]scriptBegin:5="//rollin@"))
	ORDER BY:C49([POLine:40]; [POLine:40]itemNum:2; >; [POLine:40]qtyOrdered:3; >)
	PoLnFillRays(Records in selection:C76([POLine:40]))
	myOK:=33
	PoLn_Rollin
Else 
	ORDER BY:C49([POLine:40]; [POLine:40]seq:21; >)
	PoLnFillRays(Records in selection:C76([POLine:40]))
End if 
If ((process_o.cur.currency#"") & (process_o.cur.currency#<>tcMONEYCHAR))
	If (vHere<2)
		Exch_GetCurr(process_o.cur.currency)
	End if 
	$k:=Size of array:C274(aPoItemNum)
	Exch_InitRays($k)
	$extExAmt:=0
	$extExTax:=0
	fExExtShip:=0
	For ($incLn; 1; $k)
		aExTaxOut{$incLn}:=Round:C94(aPOVATax{$incLn}*process_o.cur.exchangeRate; viExDisPrec)
		$extExTax:=$extExTax+aExTaxOut{$incLn}
		aExUnitPrc{$incLn}:=Round:C94(DiscountApply(aPoUnitCost{$incLn}; aPoDiscnt{$incLn}; viExConPrec)*process_o.cur.exchangeRate; viExDisPrec)
		$extExAmt:=$extExAmt+Round:C94(aExUnitPrc{$incLn}*aPoQtyOrder{$incLn}; viExDisPrec)
	End for 
	fExExtAmt:=$extExAmt
	fExExtTax:=$extExTax
	// <>exExtShip:=Round([Proposal]ShipTotal*process_o.cur.ExchangeRate;viExDisPrec)
	fExExtTtl:=$extExAmt+$extExTax  //+<>exExtShip
Else 
	fExExtAmt:=process_o.cur.amount
	fExExtTax:=process_o.cur.taxJurisdiction
	// <>exExtShip:=Round([Proposal]ShipTotal*process_o.cur.ExchangeRate;viExDisPrec)
	fExExtTtl:=process_o.cur.total  //+<>exExtShip
End if 