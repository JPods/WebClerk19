//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-30T06:00:00Z)
// Method: P_ClearVars
// Description 
// Parameters
// ----------------------------------------------------


// MustFixQQQZZZ: Bill James (2022-01-30T06:00:00Z)
// Shift this to an object,  print_o or entryEntity.printVar. etc....

//Ref: P_OrdHeadVars
// All P_ methods

// fix these
If (True:C214)
	
	MainAddress:=""
	RepAddress:=""
	AddressRep:=""
	
	CustAddress:=""
	AddressCustomer:=""
	AddressContact:=""
	
	ServiceAddress:=""
	AddressService:=""
	AddressBillTo:=""
	AddressShipTo:=""
	
	MfgName:=""
	MfgAddress:=""
	MfgLtrAttn:=""
	MfgPhone:=""
	MfgFAX:=""
	pvEmailEmployee:=""
	
	LtrDearContact:=""
	LtrAttn:=""
	
	
	
	JustAddress:=""
	DearContact:=""
	LtrAttn:=""
	LtrSignedBy:=""
	
	
	vShipper:=""
	vShipperID:=""
	vFrghtType:=""
	CustAddress:=""
	MainAddress:=""
	ShipAddress:=""
	pvDocPhone:=""
End if 

// document
pvShipper:=""
pvShiperID:=""
pvFreightType:=""

pvTermState:=""
pvRepCo:=""
pvRepAcct:=""
pvAddressiS:=""
pvAddressiB:=""
pvPhone:=""
pvPhoneCell:=""
pvFAX:=""
pvEmail:=""

pvPhoneiS:=""
pvPhoneiB:=""
pvPhoneDoc:=""
pvPhoneCo:=""
pvPhoneCell:=""

pvFAXCo:=""
pvFaxiS:=""
pvFaxiB:=""
pvFaxDoc:=""

pvEmailAddressDoc:=""
pvEmailAddressCo:=""
pvEmailAddressiB:=""
pvEmailAddressiS:=""

pvTimesPrnt:=""

// lines:
pvSeq:=""
pvItemNum:=""
pvAltItem:=""
pvDescription:=""
pvQtyOrd:=""
pvQtyShip:=""
pvQtyBL:=""
pvTaxable:=""
pvTax:=""
pvrTaxCost:=""
pvPricePt:=""
pvBasePrice:=""
pvUnitPrice:=""
pvDiscount:=""
pvExtPrice:=""
pvAmountBL:=""
pvBaseCost:=""
pvUnitCost:=""
pvExtCost:=""
pvUnitMeas:=""
pvLocation:=""
pvUse:=""
pvUnitWt:=""
pvExtWt:=""
pvLeadTime:=""
pvSerial:=""
pvCommRep:=""
pvCommSales:=""
pvRateRep:=""
pvRateSales:=""
//p_Royalty
pvReference:=""
pvRateCommt:=""
pvLnComment:=""
pvNameID:=""
pvLnProfile1:=""
pvLnProfile2:=""
pvLnProfile3:=""
pvShipOrdSt:=""
fExUnPrice:=""
fExUnExPrice:=""
fExUnCost:=""
fExUnExCost:=""
pvDateProm:=""
pvDateReq:=""
pvDateShip:=""
pvPrintThis:=""
//
pvQtyCancelled:=""
pvProfileReal1:=""
pvProfileReal2:=""
//
fExExtAmt:=0
fExExtTax:=0
fExExtShip:=0
fExExtTtl:=0
