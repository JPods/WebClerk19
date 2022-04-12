//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-08T00:00:00, 22:03:46
// ----------------------------------------------------
// Method: P_IvcHeadVars
// Description
// Modified: 08/08/13
// 
// 
//
// Parameters
// ----------------------------------------------------

ARRAY LONGINT:C221(aProOrRec; 0)  // ### jwm ### 20190703_1530

P_ClearVars
If ([Customer:2]customerID:1#[Invoice:26]customerID:3)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
End if 
Case of 
	: ([Invoice:26]idNumOrder:1=1)
		Pro_FillArray(0)
	: (([Order:3]idNum:2#[Invoice:26]idNumOrder:1) & (vHere<2))
		QUERY:C277([Order:3]; [Order:3]idNum:2=[Invoice:26]idNumOrder:1)
		Pro_FillArray(-9; 3; [Order:3]idNum:2; "")
		Pro_FillArray(-8)  //sort
End case 
C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aProOrRec)
If ($k>0)
	For ($i; 1; $k)
		vProName:=vProName+aProOrName{$i}+"\r"
		vProValue:=vProValue+aProOrValue{$i}+"\r"
	End for 
Else 
	vProName:=""
	vProValue:=""
End if 

curLines:=0
pvPayments:=PayMethodAmounts(->[Invoice:26]; " "; "No payments received"; "Query")
pvTerms:=InfoTerms([Invoice:26]terms:24)
Info_TermStment(->pvTermState)
InfoRep([Invoice:26]repID:22)
InfoShipper([Invoice:26]shipVia:5)
ShipAddress:=PVars_AddressFull("Invoice")
If ([Invoice:26]addressBillTo:67="")
	CustAddress:=PVars_AddressFull("Customer")
	MainAddress:=CustAddress
Else 
	MainAddress:=PVars_AddressFull("Customer")
	CustAddress:=[Invoice:26]addressBillTo:67
End if 
If ([Invoice:26]country:13="")
	pvCountry:="US"
Else 
	pvCountry:=[Invoice:26]country:13
End if 
pvPhone:=Format_Phone([Customer:2]phone:13)
pvFAX:=Format_Phone([Customer:2]fax:66)
pvDocPhone:=Format_Phone([Invoice:26]phone:54)
////
pvAddressiS:=""
pvAddressiB:=""
pvPhoneiS:=""
pvPhoneiB:=""
pvFaxiS:=""
pvFaxiB:=""
pvAddressiS:=""
pvAddressiB:=""
If ([Invoice:26]contactBillTo:79>0)
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Invoice:26]contactBillTo:79)
Else 
	REDUCE SELECTION:C351([Contact:13]; 0)
End if 
pvPhoneDoc:=Prnt_ValuePriority([Invoice:26]phone:54; [Contact:13]phone:30; [Customer:2]phone:13)
pvPhoneiB:=Prnt_ValuePriority([Contact:13]phone:30; [Customer:2]phone:13)
pvPhoneCo:=Format_Phone([Customer:2]phone:13)
pvPhoneDoc:=Format_Phone(pvPhoneDoc)
pvPhoneiB:=Format_Phone(pvPhoneiB)
pvFaxDoc:=Prnt_ValuePriority([Invoice:26]fax:75; [Contact:13]fax:31; [Customer:2]fax:66)
pvFaxiB:=Prnt_ValuePriority([Contact:13]fax:31; [Customer:2]fax:66)
pvFaxCo:=Format_Phone([Customer:2]fax:66)
pvFaxDoc:=Format_Phone(pvFaxDoc)
pvFaxiB:=Format_Phone(pvFaxiB)
pveMailAddressDoc:=Prnt_ValuePriority([Invoice:26]email:76; [Contact:13]email:35; [Customer:2]email:81)
pveMailAddressiB:=Prnt_ValuePriority([Contact:13]email:35; [Customer:2]email:81)
pveMailAddressCo:=[Customer:2]email:81
pveMailAddressiB:=pveMailAddressi
pveMailAddressDoc:=pveMailAddressDoc
Case of 
	: (Record number:C243([Contact:13])>-1)
		BillAddress:=PVars_AddressFull("Contact")
	: ([Invoice:26]addressBillTo:67#"")
		BillAddress:=[Invoice:26]addressBillTo:67
	Else 
		BillAddress:=MainAddress
End case 

BillAddress:=Txt_ClearExtraReturns(BillAddress)


If ([Invoice:26]contactShipTo:72>0)
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Invoice:26]contactShipTo:72)
Else 
	REDUCE SELECTION:C351([Contact:13]; 0)
End if 
pvPhoneiS:=Prnt_ValuePriority([Contact:13]phone:30; [Customer:2]phone:13)
pvFaxiS:=Prnt_ValuePriority([Contact:13]fax:31; [Customer:2]fax:66)
pveMailAddressiS:=Prnt_ValuePriority([Contact:13]email:35; [Customer:2]email:81)
pveMailAddressiS:=pveMailAddressiS
If (vHere>1)
	//  CHOPPED  ContactsLoad(-1)
End if 
If (([Invoice:26]currency:62#"") & ([Invoice:26]currency:62#<>tcMONEYCHAR))
	If (vHere<2)
		Exch_GetCurr([Invoice:26]currency:62)
	End if 
	C_LONGINT:C283($incLn; $k)
	QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]idNumInvoice:1=[Invoice:26]idNum:2)
	$k:=Records in selection:C76([InvoiceLine:54])
	Exch_InitRays($k)
	$extExAmt:=0
	$extExTax:=0
	fExExtShip:=0
	FIRST RECORD:C50([InvoiceLine:54])
	For ($incLn; 1; $k)
		aExTaxOut{$incLn}:=Round:C94([InvoiceLine:54]salesTax:15*[Invoice:26]exchangeRate:61; viExDisPrec)
		$extExTax:=$extExTax+aExTaxOut{$incLn}
		aExUnitPrc{$incLn}:=Round:C94(DiscountApply([InvoiceLine:54]unitPrice:9; [InvoiceLine:54]discount:10; viExConPrec)*[Invoice:26]exchangeRate:61; viExDisPrec)
		$extExAmt:=$extExAmt+Round:C94(aExUnitPrc{$incLn}*[InvoiceLine:54]qty:7; viExDisPrec)
		NEXT RECORD:C51([InvoiceLine:54])
	End for 
	fExExtAmt:=$extExAmt
	fExExtTax:=$extExTax
	fExExtShip:=Round:C94([Invoice:26]shipTotal:20*[Invoice:26]exchangeRate:61; viExDisPrec)
	fExExtTtl:=$extExAmt+$extExTax+fExExtShip
	fExBalance:=Round:C94([Invoice:26]balanceDue:44*[Invoice:26]exchangeRate:61; viExDisPrec)
Else 
	fExExtAmt:=[Invoice:26]amount:14
	fExExtTax:=[Invoice:26]salesTax:19
	fExExtShip:=[Invoice:26]shipTotal:20
	fExExtTtl:=[Invoice:26]total:18
	fExBalance:=[Invoice:26]balanceDue:44
End if 
C_BOOLEAN:C305(vbDoPageCount)
// If (vbDoPageCount)
[Invoice:26]timesPrinted:51:=[Invoice:26]timesPrinted:51+1
// End if 
SAVE RECORD:C53([Invoice:26])
pvTimesPrnt:="- "+String:C10([Invoice:26]timesPrinted:51)+" -"
//infoAddresses (File([Invoice]);Full Name;ShipTo)
//
P_Old_ToP_VarsHeader


//
$tempSecureLevel:=vWccSecurity
vWccSecurity:=0
WccExecuteTask("PrintHeader"; Table:C252(->[Invoice:26]))
vWccSecurity:=$tempSecureLevel

