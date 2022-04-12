//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-30T06:00:00Z)
// Method: P_OrdHeadVars
// Description 
// Parameters
// ----------------------------------------------------
P_ClearVars



pvPhone:=Format_Phone([Customer:2]phone:13)
pvFAX:=Format_Phone([Customer:2]fax:66)
pvDocPhone:=Format_Phone([Order:3]phone:67)
pvTerms:=InfoTerms([Order:3]terms:23)
Info_TermStment(->pvTermState)
InfoRep([Order:3]repID:8)
InfoShipper([Order:3]shipVia:13)
ShipAddress:=PVars_AddressFull("Order")
//
If ([Order:3]country:21="")
	pvCountry:="US"
Else 
	pvCountry:=[Order:3]country:21
End if 
//01/21/03.prf BEGIN

//PVars_AddressFull (->[Customer];->MainAddress)
//CustAddress:=MainAddress

If ([Order:3]addressBillTo:71="")
	CustAddress:=PVars_AddressFull("Customer")
	MainAddress:=CustAddress
Else 
	MainAddress:=PVars_AddressFull("Customer")
	CustAddress:=[Order:3]addressBillTo:71
End if 
//01/21/03.prf END

If ([Order:3]mfrID:52#"")
	PVars_Manufacturer
End if 
If (vHere<2)
	Pro_FillArray(-9; 3; [Order:3]idNum:2; "")
	Pro_FillArray(-8)  //Sort
End if 
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
//

If ([Order:3]contactBillTo:87>0)
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Order:3]contactBillTo:87)
Else 
	REDUCE SELECTION:C351([Contact:13]; 0)
End if 
Case of 
	: (Record number:C243([Contact:13])>-1)
		BillAddress:=PVars_AddressFull("Contact")
	: ([Order:3]addressBillTo:71#"")
		BillAddress:=[Order:3]addressBillTo:71
	Else 
		BillAddress:=MainAddress
End case 
pvPayments:=PayMethodAmounts(->[Order:3]; " "; "No payments received"; "Query")
pvPhoneDoc:=Prnt_ValuePriority([Order:3]phone:67; [Contact:13]phone:30; [Customer:2]phone:13)
pvPhoneiB:=Prnt_ValuePriority([Contact:13]phone:30; [Customer:2]phone:13)
pvPhoneCo:=Format_Phone([Customer:2]phone:13)
pvPhoneDoc:=Format_Phone(pvPhoneDoc)
pvPhoneiB:=Format_Phone(pvPhoneiB)
pvFaxDoc:=Prnt_ValuePriority([Order:3]fax:81; [Contact:13]fax:31; [Customer:2]fax:66)
pvFaxiB:=Prnt_ValuePriority([Contact:13]fax:31; [Customer:2]fax:66)
pvFaxCo:=Format_Phone([Customer:2]fax:66)
pvFaxDoc:=Format_Phone(pvFaxDoc)
pvFaxiB:=Format_Phone(pvFaxiB)
pveMailAddressDoc:=Prnt_ValuePriority([Order:3]email:82; [Contact:13]email:35; [Customer:2]email:81)
pveMailAddressiB:=Prnt_ValuePriority([Contact:13]email:35; [Customer:2]email:81)
pveMailAddressCo:=[Customer:2]email:81
pveMailAddressDoc:=pveMailAddressDoc
pveMailAddressiB:=pveMailAddressiB
If ([Order:3]contactShipTo:78>0)
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Order:3]contactShipTo:78)
Else 
	REDUCE SELECTION:C351([Contact:13]; 0)
End if 
pvPhoneiS:=Prnt_ValuePriority([Contact:13]phone:30; [Customer:2]phone:13)
pvFaxiS:=Prnt_ValuePriority([Contact:13]fax:31; [Customer:2]fax:66)
pveMailAddressiS:=Prnt_ValuePriority([Contact:13]email:35; [Customer:2]email:81)
pveMailAddressiS:=pveMailAddressiS

If (([Order:3]currency:69#"") & ([Order:3]currency:69#<>tcMONEYCHAR))
	If (vHere<2)
		Exch_GetCurr([Order:3]currency:69)
	End if 
	C_LONGINT:C283($incLn; $k)
	QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
	ORDER BY:C49([OrderLine:49]; [OrderLine:49]seq:30)
	$k:=Records in selection:C76([OrderLine:49])
	Exch_InitRays($k)
	$extExAmt:=0
	$extExTax:=0
	fExExtShip:=0
	FIRST RECORD:C50([OrderLine:49])
	For ($incLn; 1; $k)
		aExTaxOut{$incLn}:=Round:C94([OrderLine:49]salesTax:15*[Order:3]exchangeRate:68; viExDisPrec)
		$extExTax:=$extExTax+aExTaxOut{$incLn}
		aExUnitPrc{$incLn}:=Round:C94(DiscountApply([OrderLine:49]unitPrice:9; [OrderLine:49]discount:10; viExConPrec)*[Order:3]exchangeRate:68; viExDisPrec)
		$extExAmt:=$extExAmt+Round:C94(aExUnitPrc{$incLn}*[OrderLine:49]qty:6; viExDisPrec)
		NEXT RECORD:C51([OrderLine:49])
	End for 
	fExExtAmt:=$extExAmt
	fExExtTax:=$extExTax
	fExExtShip:=Round:C94([Order:3]shipTotal:30*[Order:3]exchangeRate:68; viExDisPrec)
	fExExtTtl:=$extExAmt+$extExTax+fExExtShip
Else 
	fExExtAmt:=[Order:3]amount:24
	fExExtTax:=[Order:3]salesTax:28
	fExExtShip:=[Order:3]shipTotal:30
	fExExtTtl:=[Order:3]total:27
End if 
C_BOOLEAN:C305(vbDoPageCount)
//  If (vbDoPageCount)
[Order:3]timesPrinted:39:=[Order:3]timesPrinted:39+1
// End if 
pvTimesPrnt:="- "+String:C10([Order:3]timesPrinted:39)+" -"
SAVE RECORD:C53([Order:3])
//
P_Old_ToP_VarsHeader
$tempSecureLevel:=vWccSecurity
vWccSecurity:=0
WccExecuteTask("PrintHeader"; Table:C252(->[Order:3]))
vWccSecurity:=$tempSecureLevel
curLines:=0



