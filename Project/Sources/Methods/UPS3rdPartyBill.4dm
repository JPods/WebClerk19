//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 2016-09-15T00:00:00, 12:02:04
// ----------------------------------------------------
// Method: UPS3rdPartyBill
// Description
// Modified: 09/15/16
// 
// 
//
// Parameters
// ----------------------------------------------------


// Script cleaned 160802
// Script N1_11_Bill3rdParty 20151016
// Bill 3rd Party Address
// How to handle account On File  
// 'On File' must be contact connected to Customer account
// TallyMaster script called from Accept orders
// ? Call TallyMaster from EDI ?
// vText  - N1_11 segment
// vText1 - Bill 3rd Party Address
// B30 - ShipTo // No Address Found
// B31 - Customer address
// B32 - Customer Contact Address
// B33 - Other Contact Address
// updated country code lookup
// changed order of lookup to  Contacts then Customer

viContinue:=1
vText:=""
// If not not Bill 3rd party bill to Functional Devices
vt3rdCompany:="Functional Devices"
vt3rdAttention:="Jerry Davis"
vt3rdAddress1:="101 Commerce Dr"
vt3rdAddress2:=""
vt3rdCity:="Sharpsville"
vt3rdState:="IN"
vt3rdZip:="46068"
vt3rdPhone:="7658835538"
vt3rdFax:="7658837505"
vt3rdCountry:="US"
vt3rdType:=""
vtServiceType:=""

// carriers service type
READ ONLY:C145([Carrier:11])
QUERY:C277([Carrier:11]; [Carrier:11]carrierid:10=[Order:3]shipVia:13; *)
QUERY:C277([Carrier:11]; [Carrier:11]active:6=True:C214; *)
QUERY:C277([Carrier:11])
If (Records in selection:C76([Carrier:11])>0)
	FIRST RECORD:C50([Carrier:11])
	vtServiceType:=[Carrier:11]serviceType:34
End if 
UNLOAD RECORD:C212([Carrier:11])
READ WRITE:C146([Carrier:11])

If ([Order:3]upsBillingOption:89="Bill 3rd Party@")
	
	
	If (viContinue=1)  // Search Contacts
		// Search Customer Contacts
		QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Order:3]customerID:1; *)
		QUERY:C277([Contact:13];  & ; [Contact:13]upsBillingOption:49=[Order:3]upsBillingOption:89; *)
		QUERY:C277([Contact:13];  & ; [Contact:13]upsReceiverAcct:50=[Order:3]upsReceiverAcct:90; *)
		QUERY:C277([Contact:13];  & ; [Contact:13]type:73="B3P"; *)  // LOOK IN NEW TYPE FIELD .. .AZM 2020-05-07
		If (vtServiceType#"PARCEL")
			QUERY:C277([Contact:13];  & ; [Contact:13]shipVia:26=[Order:3]shipVia:13; *)
		End if 
		QUERY:C277([Contact:13])
		
		If (Records in selection:C76([Contact:13])>0)
			vt3rdType:="B32 "
		End if 
		
		// Search all Contacts except when account is "on file"
		If (Records in selection:C76([Contact:13])=0)
			// Account = "On File" must be linked to Customer 
			If ([Order:3]upsReceiverAcct:90#"On@File")
				QUERY:C277([Contact:13]; [Contact:13]upsBillingOption:49=[Order:3]upsBillingOption:89; *)
				QUERY:C277([Contact:13];  & ; [Contact:13]upsReceiverAcct:50=[Order:3]upsReceiverAcct:90; *)
				QUERY:C277([Contact:13];  & ; [Contact:13]type:73="B3P"; *)  // LOOK IN NEW TYPE FIELD .. .AZM 2020-05-07
				If (vtServiceType#"PARCEL")
					QUERY:C277([Contact:13];  & ; [Contact:13]shipVia:26=[Order:3]shipVia:13; *)
				End if 
				QUERY:C277([Contact:13])
				If (Records in selection:C76([Contact:13])>0)
					vt3rdType:="B33 "
				End if 
			End if 
		End if 
		
		If (Records in selection:C76([Contact:13])>0)
			viContinue:=0  // address found
			FIRST RECORD:C50([Contact:13])
			vt3rdCompany:=Substring:C12([Contact:13]company:23; 1; 35)
			vt3rdCompany:=Txt_Clean(vt3rdCompany; " ")
			vt3rdAttention:=Txt_Clean([Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4; " ")
			vt3rdAddress1:=Txt_Clean([Contact:13]address1:6; " ")
			vt3rdAddress2:=Txt_Clean([Contact:13]address2:7; " ")
			If (vt3rdAddress2#"")
				vt3rdAddress2:="*"+vt3rdAddress2
			End if 
			vt3rdCity:=Txt_Clean([Contact:13]city:8; " ")
			vt3rdState:=Txt_Clean([Contact:13]state:9; " ")
			vt3rdZip:=Txt_Clean([Contact:13]zip:11; " ")
			vt3rdPhone:=Txt_Clean([Contact:13]phone:30; ""; "")
			vt3rdFax:=Txt_Clean([Contact:13]fax:31; ""; "")
			
			vt3rdCountry:=Txt_Clean([Contact:13]country:12; " ")
			
			//=======================================================
			// Begin Country Code Lookup
			//=======================================================
			
			If (Length:C16(vt3rdCountry)#2)
				QUERY:C277([GenericChild2:91]; [GenericChild2:91]a02:29=vt3rdCountry)
				viRecords:=Records in selection:C76([GenericChild2:91])
				If (viRecords>0)
					FIRST RECORD:C50([GenericChild2:91])
					vt3rdCountry:=[GenericChild2:91]a01:28
				Else 
					ALERT:C41("Valid Country Code Not Found")
					vt3rdCountry:="US"
				End if 
				REDUCE SELECTION:C351([GenericChild2:91]; 0)
				vt3rdCountry:=Uppercase:C13(vt3rdCountry)
			End if 
			
		End if 
		
	End if 
	
	If (viContinue=1)  // Address not found Search Customer
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1; *)
		QUERY:C277([Customer:2];  & ; [Customer:2]upsBillingOption:96=[Order:3]upsBillingOption:89; *)
		QUERY:C277([Customer:2];  & ; [Customer:2]upsReceiverAcct:97=[Order:3]upsReceiverAcct:90; *)
		If (vtServiceType#"PARCEL")
			QUERY:C277([Customer:2];  & ; [Customer:2]shipVia:12=[Order:3]shipVia:13; *)
		End if 
		QUERY:C277([Customer:2])
		
		If (Records in selection:C76([Customer:2])=1)  // should only have one customer account that matches
			viContinue:=0  // address found
			vt3rdType:="B31 "
			FIRST RECORD:C50([Customer:2])
			
			vtBillTo:="Bill To Third Party"
			vtAccount:=[Order:3]upsReceiverAcct:90
			
			//Set Bill 3rd Party Address
			
			vt3rdCompany:=Substring:C12([Customer:2]company:2; 1; 35)
			vt3rdCompany:=Txt_Clean(vt3rdCompany; " ")
			vt3rdAttention:=Txt_Clean([Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23; " ")
			vt3rdAddress1:=Txt_Clean([Customer:2]address1:4; " ")
			vt3rdAddress2:=Txt_Clean([Customer:2]address2:5; " ")
			If (vt3rdAddress2#"")
				vt3rdAddress2:="*"+vt3rdAddress2
			End if 
			vt3rdCity:=Txt_Clean([Customer:2]city:6; " ")
			vt3rdState:=Txt_Clean([Customer:2]state:7; " ")
			vt3rdZip:=Txt_Clean([Customer:2]zip:8; " ")
			vt3rdPhone:=Txt_Clean([Customer:2]phone:13; " ")
			vt3rdFax:=Txt_Clean([Customer:2]fax:66; " ")
			
			vt3rdCountry:=Txt_Clean([Customer:2]country:9; " ")  /// check this logic
			
			//=======================================================
			// Begin Country Code Lookup
			//=======================================================
			
			If (Length:C16(vt3rdCountry)#2)
				QUERY:C277([GenericChild2:91]; [GenericChild2:91]a02:29=vt3rdCountry)
				viRecords:=Records in selection:C76([GenericChild2:91])
				If (viRecords>0)
					FIRST RECORD:C50([GenericChild2:91])
					vt3rdCountry:=[GenericChild2:91]a01:28
				Else 
					ALERT:C41("Valid Country Code Not Found")
					vt3rdCountry:="US"
				End if 
				REDUCE SELECTION:C351([GenericChild2:91]; 0)
				vt3rdCountry:=Uppercase:C13(vt3rdCountry)
			End if 
			
		Else 
			If (vHere>=2)
				// if Input Layout restore selected Customer for this order
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
			End if 
		End if 
	End if   // continue
	
	
	If (viContinue=1)  // Address not found Not Customer and Not Contact
		vt3rdType:="B30 "  // NO ADDRESS FOUND
		vt3rdCompany:=Substring:C12([Order:3]company:15; 1; 35)
		vt3rdCompany:=Txt_Clean(vt3rdCompany; " ")
		vt3rdAttention:=Txt_Clean([Order:3]attention:44; " ")
		vt3rdAddress1:=Txt_Clean([Order:3]address1:16; " ")
		vt3rdAddress2:=Txt_Clean([Order:3]address2:17; " ")
		If (vt3rdAddress2#"")
			vt3rdAddress2:="*"+vt3rdAddress2
		End if 
		vt3rdCity:=Txt_Clean([Order:3]city:18; " ")
		vt3rdState:=Txt_Clean([Order:3]state:19; " ")
		vt3rdZip:=Txt_Clean([Order:3]zip:20; " ")
		vt3rdPhone:=Txt_Clean([Order:3]phone:67; " ")
		vt3rdFax:=Txt_Clean([Order:3]fax:81; " ")
		
		vt3rdCountry:=Txt_Clean([Order:3]country:21; " ")
		vt3rdCountry:=Substring:C12([Order:3]country:21; 1; 2)
		
		Case of 
			: ([Order:3]country:21="United States")
				vt3rdCountry:="US"
				
			: (vt3rdCountry="USA")
				vt3rdCountry:="US"
				
			: (vt3rdCountry="US")
				vt3rdCountry:="US"
				
			: (Length:C16([Order:3]country:21)#2)
				QUERY:C277([GenericChild2:91]; [GenericChild2:91]a02:29=[Order:3]country:21)
				viRecords:=Records in selection:C76([GenericChild2:91])
				If (viRecords>0)
					FIRST RECORD:C50([GenericChild2:91])
					vt3rdCountry:=[GenericChild2:91]a01:28
				Else 
					ALERT:C41("Valid Country Code Not Found")
					vt3rdCountry:="US"
				End if 
				
				REDUCE SELECTION:C351([GenericChild2:91]; 0)
				vt3rdCountry:=Uppercase:C13(vt3rdCountry)
				
			Else 
				vt3rdCountry:="US"
		End case 
		
	End if   // continue
	
End if   // Bill 3rd Party

// N1*BT*JCM Johnson Controls Milwaukee*92*8466
// N3*507 East Michigan Street 
// N4*Milwaukee*WI*53202*US

// ITS 940 EDI
vText:=""
vText:=vText+"N1*11*"+vt3rdCompany+Storage:C1525.char.crlf
vText:=vText+"N3*"+vt3rdAddress1+vt3rdAddress2+Storage:C1525.char.crlf
vText:=vText+"N4*"+vt3rdCity+"*"+vt3rdState+"*"+vt3rdZip+"*"+vt3rdCountry+Storage:C1525.char.crlf

viCount:=viCount+3  // add 3 to segment count

//==========
// Debug
//==========
vText1:=""
vt3rdAddress2:=Txt_Clean(vt3rdAddress2; " ")
If (vt3rdAddress2#"")
	vt3rdAddress2:="\r"+vt3rdAddress2
End if 

vText1:=vText1+vt3rdCompany+Storage:C1525.char.crlf
vText1:=vText1+vt3rdAddress1+vt3rdAddress2+Storage:C1525.char.crlf
vText1:=vText1+vt3rdCity+", "+vt3rdState+" "+vt3rdZip+" "+vt3rdCountry+Storage:C1525.char.crlf

[Order:3]addressShipFrom:72:=vText1

// Clear Old Bill 3rd Party Code
[Order:3]profile5:104:=Preg Replace("B3[0-9] "; ""; [Order:3]profile5:104; Regex Multi Line+Regex Ignore Case)
// Set New Bill 3rd Party Code
[Order:3]profile5:104:=vt3rdType+[Order:3]profile5:104
// Save Record([Order])

//SET TEXT TO PASTEBOARD (vText1)
vtResult:=""
Case of 
	: (vt3rdType="B30 ")
		vtResult:="Error: "+vt3rdType+" Ship To Address\r\r"
		
	: (vt3rdType="B31 ")
		vtResult:="Success: "+vt3rdType+" Customer Address\r\r"
		
	: (vt3rdType="B32 ")
		vtResult:="Success: "+vt3rdType+" Customer's Contact Address\r\r"
		
	: (vt3rdType="B33 ")
		vtResult:="Success: "+vt3rdType+" Other Contact Address\r\r"
		
End case 

vText1:=vtResult+vText1

If (allowAlerts_boo)
	ALERT:C41(vText1)
End if 

// End Script N1_11.4D 