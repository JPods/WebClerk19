//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-09-15T00:00:00, 22:38:40
// ----------------------------------------------------
// Method: AddressOrderFill
// Description
// Modified: 09/15/13
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $fillTo; $vtAction)

If (Count parameters:C259=1)
	$vtAction:=$1
Else 
	$vtAction:=""
End if 


// ### bj ### 20200102_1513
Case of 
	: ((([Customer:2]customerID2nd:128#"") & ($vtAction="CustomersID2nd")) | ($vtAction=""))
		[Order:3]customerID:1:=[Customer:2]customerID:1
		PUSH RECORD:C176([Customer:2])
		C_TEXT:C284($vtext)
		$vtext:=[Customer:2]customerID2nd:128
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=$vtext)
		[Order:3]billToCompany:76:=[Customer:2]company:2
		[Order:3]billToAttention:92:=[Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23
		[Order:3]billToPhone:93:=[Customer:2]phone:13
		[Order:3]billToFAX:94:=[Customer:2]fax:66
		[Order:3]billToAddress1:95:=[Customer:2]address1:4
		[Order:3]billToAddress2:96:=[Customer:2]address2:5
		[Order:3]billToCity:97:=[Customer:2]city:6
		[Order:3]billToState:98:=[Customer:2]state:7
		[Order:3]billToZip:99:=[Customer:2]zip:8
		[Order:3]billToCountry:100:=[Customer:2]country:9
		[Order:3]billToEmail:101:=[Customer:2]email:81
		UNLOAD RECORD:C212([Customer:2])
		// reduce selection([Customer];0)
		POP RECORD:C177([Customer:2])
		
		
		
	: ($vtAction="billtofromCustomer")
		
		[Order:3]customerID:1:=[Customer:2]customerID:1
		[Order:3]billToCompany:76:=[Customer:2]company:2
		[Order:3]billToAttention:92:=[Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23
		[Order:3]billToPhone:93:=[Customer:2]phone:13
		[Order:3]billToFAX:94:=[Customer:2]fax:66
		[Order:3]billToAddress1:95:=[Customer:2]address1:4
		[Order:3]billToAddress2:96:=[Customer:2]address2:5
		[Order:3]billToCity:97:=[Customer:2]city:6
		[Order:3]billToState:98:=[Customer:2]state:7
		[Order:3]billToZip:99:=[Customer:2]zip:8
		[Order:3]billToCountry:100:=[Customer:2]country:9
		[Order:3]billToEmail:101:=[Customer:2]email:81
		
		
		
		
	: ($vtAction="shiptofromCustomer")
		
		[Order:3]company:15:=[Customer:2]company:2
		[Order:3]address1:16:=[Customer:2]address1:4
		[Order:3]address2:17:=[Customer:2]address2:5
		[Order:3]city:18:=[Customer:2]city:6
		[Order:3]state:19:=[Customer:2]state:7
		[Order:3]zip:20:=[Customer:2]zip:8
		[Order:3]country:21:=[Customer:2]country:9
		[Order:3]attention:44:=[Customer:2]nameFirst:73+(" "*Num:C11([Customer:2]nameFirst:73#""))+[Customer:2]nameLast:23
		[Order:3]taxJuris:43:=[Customer:2]taxJuris:65
		[Order:3]phone:67:=[Customer:2]phone:13
		[Order:3]shipVia:13:=[Customer:2]shipVia:12
		[Order:3]zone:14:=[Customer:2]zone:57
		[Order:3]phone:67:=[Customer:2]phone:13
		[Order:3]fax:81:=[Customer:2]fax:66
		[Order:3]email:82:=[Customer:2]email:81
		//05/17/02.prf Added 3 fields for UPS export 
		//05/24/02 janani added the prepaid option to UPSBillingOption 
		[Order:3]upsResidential:88:=[Customer:2]upsResidential:95
		[Order:3]upsBillingOption:89:=[Customer:2]upsBillingOption:96
		[Order:3]upsReceiverAcct:90:=[Customer:2]upsReceiverAcct:97
		If (Length:C16([Order:3]upsBillingOption:89)=0)
			//If (allowAlerts_boo)
			//ALERT("The Ship Bill Option for this Customer is blank...setting the Order to Pr
			//End if 
			[Order:3]upsBillingOption:89:="Prepaid & Add"
		End if 
		
	: ($vtAction="billtofromContact")
		[Order:3]contactBillTo:87:=[Contact:13]idNum:28
		[Order:3]billToCompany:76:=[Contact:13]company:23
		[Order:3]billToAttention:92:=[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4
		[Order:3]billToPhone:93:=[Contact:13]phone:30
		[Order:3]billToFAX:94:=[Contact:13]fax:31
		[Order:3]billToAddress1:95:=[Contact:13]address1:6
		[Order:3]billToAddress2:96:=[Contact:13]address2:7
		[Order:3]billToCity:97:=[Contact:13]city:8
		[Order:3]billToState:98:=[Contact:13]state:9
		[Order:3]billToZip:99:=[Contact:13]zip:11
		[Order:3]billToCountry:100:=[Contact:13]country:12
		[Order:3]billToEmail:101:=[Contact:13]email:35
		
		
		
	: ($vtAction="shiptofromContact")
		
		[Order:3]contactShipTo:78:=[Contact:13]idNum:28
		[Order:3]shipVia:13:=[Contact:13]shipVia:26
		[Order:3]company:15:=[Contact:13]company:23
		[Order:3]address1:16:=[Contact:13]address1:6
		[Order:3]address2:17:=[Contact:13]address2:7
		[Order:3]city:18:=[Contact:13]city:8
		[Order:3]state:19:=[Contact:13]state:9
		[Order:3]zip:20:=[Contact:13]zip:11
		[Order:3]country:21:=[Contact:13]country:12
		[Order:3]attention:44:=[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4
		[Order:3]zone:14:=[Contact:13]zone:27
		[Order:3]taxJuris:43:=[Contact:13]taxJuris:24
		[Order:3]contactShipTo:78:=[Contact:13]idNum:28
		If ([Contact:13]address1:6#"")
			If ([Contact:13]phone:30="")
				[Order:3]phone:67:=[Customer:2]phone:13
			Else 
				[Order:3]phone:67:=[Contact:13]phone:30
			End if 
			If ([Contact:13]fax:31="")
				[Order:3]fax:81:=[Customer:2]fax:66
			Else 
				[Order:3]fax:81:=[Contact:13]fax:31
			End if 
			If ([Contact:13]email:35="")
				[Order:3]email:82:=[Customer:2]email:81
			Else 
				[Order:3]email:82:=[Contact:13]email:35
			End if 
		End if 
		//05/17/02.prf Added 3 fields for UPS export   
		//05/24/02 janani added the prepaid option to UPSBillingOption  
		[Order:3]upsResidential:88:=[Contact:13]upsResidential:48
		[Order:3]upsBillingOption:89:=[Contact:13]upsBillingOption:49
		[Order:3]upsReceiverAcct:90:=[Contact:13]upsReceiverAcct:50
		If (Length:C16([Order:3]upsBillingOption:89)=0)
			//If (allowAlerts_boo)
			//ALERT("The Ship Bill Option for the selected Contact is
			// blank...setting the "+"Order to Prepaid")
			//End if 
			[Order:3]upsBillingOption:89:="Prepaid & Add"
		End if 
		//  Put  the formating in the form  jFormatPhone(->[Order]phone)
		Find Ship Zone(->[Order:3]zip:20; ->[Order:3]zone:14; ->[Order:3]shipVia:13; ->[Order:3]country:21; ->[Order:3]siteID:106)
	: ($vtAction="shiptofromVendor")
		[Order:3]company:15:=[Vendor:38]company:2
		[Order:3]attention:44:=[Vendor:38]nameFirst:85+" "+[Vendor:38]nameLast:86
		[Order:3]phone:67:=[Vendor:38]phone:10
		[Order:3]fax:81:=[Vendor:38]fax:13
		[Order:3]address1:16:=[Vendor:38]address1:4
		[Order:3]address2:17:=[Vendor:38]address2:5
		[Order:3]city:18:=[Vendor:38]city:6
		[Order:3]state:19:=[Vendor:38]state:7
		[Order:3]zip:20:=[Vendor:38]zip:8
		[Order:3]country:21:=[Vendor:38]country:9
		[Order:3]email:82:=[Vendor:38]email:59
		
	: ($vtAction="billtofromVendor")
		[Order:3]billToCompany:76:=[Vendor:38]company:2
		[Order:3]billToAttention:92:=[Vendor:38]nameFirst:85+" "+[Vendor:38]nameLast:86
		[Order:3]billToPhone:93:=[Vendor:38]phone:10
		[Order:3]billToFAX:94:=[Vendor:38]fax:13
		[Order:3]billToAddress1:95:=[Vendor:38]address1:4
		[Order:3]billToAddress2:96:=[Vendor:38]address2:5
		[Order:3]billToCity:97:=[Vendor:38]city:6
		[Order:3]billToState:98:=[Vendor:38]state:7
		[Order:3]billToZip:99:=[Vendor:38]zip:8
		[Order:3]billToCountry:100:=[Vendor:38]country:9
		[Order:3]billToEmail:101:=[Vendor:38]email:59
		
	: ($vtAction="shiptofromRep")
		[Order:3]company:15:=[Rep:8]company:2
		[Order:3]attention:44:=[Rep:8]nameFirst:25+" "+[Rep:8]nameLast:27
		[Order:3]phone:67:=[Rep:8]phone:10
		[Order:3]fax:81:=[Rep:8]fax:20
		[Order:3]address1:16:=[Rep:8]address1:4
		[Order:3]address2:17:=[Rep:8]address2:5
		[Order:3]city:18:=[Rep:8]city:6
		[Order:3]state:19:=[Rep:8]state:7
		[Order:3]zip:20:=[Rep:8]zip:8
		[Order:3]country:21:=[Rep:8]country:9
		[Order:3]email:82:=[Rep:8]email:22
		
		
	: ($vtAction="billtofromRep")
		[Order:3]billToCompany:76:=[Rep:8]company:2
		[Order:3]billToAttention:92:=[Rep:8]nameFirst:25+" "+[Rep:8]nameLast:27
		[Order:3]billToPhone:93:=[Rep:8]phone:10
		[Order:3]billToFAX:94:=[Rep:8]fax:20
		[Order:3]billToAddress1:95:=[Rep:8]address1:4
		[Order:3]billToAddress2:96:=[Rep:8]address2:5
		[Order:3]billToCity:97:=[Rep:8]city:6
		[Order:3]billToState:98:=[Rep:8]state:7
		[Order:3]billToZip:99:=[Rep:8]zip:8
		[Order:3]billToCountry:100:=[Rep:8]country:9
		[Order:3]billToEmail:101:=[Rep:8]email:22
		
End case 