//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: P_Old_ToP_VarsHeader
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 

// 
// MustFixQQQZZZ: Bill James (2022-01-30T06:00:00Z)
// Fix all variables in the print items of SuperReport, scripts, etc....
// get rid of <>vars
// Look at making a process_o.obGeneral.printVars



p_TermState:=pvTermState
p_RepCo:=pvRepCo
p_RepAcct:=pvRepAcct
p_Phone:=pvPhone
p_FAX:=pvFAX
p_DocPhone:=pvDocPhone
p_AddressiS:=pvAddressiS
p_AddressiB:=pvAddressiB
p_PhoneiS:=pvPhoneiS
p_PhoneiB:=pvPhoneiB
p_FaxiS:=pvFaxiS
p_FaxiB:=pvFaxiB
p_AddressiS:=pvAddressiS
p_AddressiB:=pvAddressiB
p_PhoneDoc:=pvPhoneDoc
p_PhoneiB:=pvPhoneiB
p_PhoneCo:=pvPhoneCo
p_PhoneDoc:=pvPhoneDoc
p_PhoneiB:=pvPhoneiB
p_FaxDoc:=pvFaxDoc
p_FAXiB:=pvFAXiB
p_FAXCo:=pvFAXCo
p_FaxDoc:=pvFaxDoc
p_FAXiB:=pvFAXiB
p_eMailAddressDoc:=pveMailAddressDoc
p_eMailAddressiB:=pveMailAddressiB
p_eMailAddressCo:=pveMailAddressCo
p_eMailAddressiB:=pveMailAddressiB
p_eMailAddressDoc:=pveMailAddressDoc
p_PhoneiS:=pvPhoneiS
p_FAXiS:=pvFAXiS
p_eMailAddressiS:=pveMailAddressiS
p_eMailAddressiS:=pveMailAddressiS
p_TimesPrnt:=pvTimesPrnt
C_TEXT:C284(<>tc_FullCo)
If (<>tc_FullCo="")
	<>tc_Division:=Storage:C1525.default.division
	<>tc_Address1:=Storage:C1525.default.address1
	<>tc_Address2:=Storage:C1525.default.address2
	<>tc_City:=Storage:C1525.default.city
	<>tc_State:=Storage:C1525.default.state
	<>tc_Zip:=Storage:C1525.default.zip
	<>tc_Country:=Storage:C1525.default.country
	<>tc_FOB:=Storage:C1525.default.fob
	<>tc_Phone:=Storage:C1525.default.phone
	<>tc_FAX:=Storage:C1525.default.fax
	<>tc_FullCo:=Storage:C1525.default.address
End if 