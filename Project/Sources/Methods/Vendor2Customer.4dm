//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Vendor2Customer
	//Date: 03/11/03
	//Who: Bill
	//Description: convert vendor to customer record
	//See VendorFromCustTable for opposite action
End if 

C_LONGINT:C283($1; $checkAcct)
C_BOOLEAN:C305($doConvert)
$doConvert:=False:C215
If (Count parameters:C259=1)
	$checkAcct:=$1  //> 0 will test, 1 will suppress alert
Else 
	$checkAcct:=1
End if 
If ($checkAcct>0)  //greater than 0 will test
	If ([Vendor:38]dunsNumber:66="")
		REDUCE SELECTION:C351([Customer:2]; 0)
	Else 
		QUERY:C277([Customer:2]; [Customer:2]dunsNumber:86=[Vendor:38]dunsNumber:66)
	End if 
	If (Records in selection:C76([Customer:2])=0)
		If ([Vendor:38]customerIDCustTable:83="")
			REDUCE SELECTION:C351([Customer:2]; 0)
		Else 
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Vendor:38]customerIDCustTable:83)
		End if 
		If (Records in selection:C76([Customer:2])=0)
			$doConvert:=True:C214
		Else 
			If ($checkAcct=1)
				ALERT:C41("Matching customerID exists.")
			End if 
		End if 
	Else 
		If ($checkAcct=1)
			ALERT:C41("Matching Duns number exists.")
		End if 
	End if 
Else 
	$doConvert:=True:C214
End if 
If ($doConvert)  //See VendorFromCustTable for opposite action
	CREATE RECORD:C68([Customer:2])
	DB_InitCustomer
	[Customer:2]division:70:=Storage:C1525.default.division
	[Customer:2]mfrLocationid:67:=0
	[Customer:2]email:81:=[Vendor:38]email:59
	//
	[Customer:2]company:2:=[Vendor:38]company:2
	[Customer:2]address1:4:=[Vendor:38]address1:4
	[Customer:2]address2:5:=[Vendor:38]address2:5
	[Customer:2]city:6:=[Vendor:38]city:6
	[Customer:2]state:7:=[Vendor:38]state:7
	[Customer:2]zip:8:=[Vendor:38]zip:8
	[Customer:2]country:9:=[Vendor:38]country:9
	[Customer:2]phone:13:=[Vendor:38]phone:10
	[Customer:2]phonePrefix:68:=[Vendor:38]phonePrefix:11
	[Customer:2]phoneSuffix:69:=[Vendor:38]phoneSuffix:12
	Find Ship Zone(->[Customer:2]zip:8; ->[Customer:2]zone:57; ->[Customer:2]shipVia:12; ->[Customer:2]country:9; ->[Customer:2]siteID:106)
	[Customer:2]repID:58:=""
	[Customer:2]salesNameID:59:=[Vendor:38]buyer:56
	[Customer:2]dateOpened:14:=Current date:C33
	[Customer:2]prospect:17:="Vendor"
	[Customer:2]profile1:26:=[Vendor:38]profile1:33
	[Customer:2]profile2:27:=[Vendor:38]profile2:34
	[Customer:2]profile3:28:=[Vendor:38]profile3:35
	[Customer:2]profile4:29:=[Vendor:38]profile4:36
	[Customer:2]profile5:30:=""
	[Customer:2]profile6:31:=False:C215
	[Customer:2]profile7:32:=False:C215
	[Customer:2]comment:15:="Transfer from Vendors "+String:C10(Current date:C33)
	[Customer:2]actionDate:61:=!00-00-00!
	[Customer:2]action:60:=""
	[Customer:2]adSource:62:=""
	[Customer:2]taxJuris:65:=Substring:C12([Vendor:38]state:7; 1; 3)
	[Customer:2]fax:66:=[Vendor:38]fax:13
	If (([Vendor:38]attention:55#"") & ([Vendor:38]nameLast:86=""))
		Parse_UnWanted(process_o.entry_o.attention)
	Else 
		[Customer:2]nameFirst:73:=[Vendor:38]nameFirst:85
		[Customer:2]nameLast:23:=[Vendor:38]nameLast:86
		
	End if 
	
	
	[Customer:2]dunsNumber:86:=[Vendor:38]dunsNumber:66
	[Customer:2]currency:89:=[Vendor:38]currency:69
	[Customer:2]alertMessage:79:=[Vendor:38]alertMessage:70
	[Vendor:38]customerIDCustTable:83:=[Customer:2]customerID:1
	SAVE RECORD:C53([Vendor:38])
	SAVE RECORD:C53([Customer:2])
	UNLOAD RECORD:C212([Vendor:38])
End if 


