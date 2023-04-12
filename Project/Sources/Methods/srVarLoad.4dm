//%attributes = {"publishedWeb":true}
//Procedure: srVarLoad
C_LONGINT:C283($1)
Case of 
	: ($1=0)
		srAcct:=""
		srCustomer:=""
		srPhone:=""
		srZip:=""
		srDisplayEmail:=""
	: ($1=Table:C252(->[Customer:2]))  //customer
		srAcct:=[Customer:2]customerID:1
		srCustomer:=[Customer:2]company:2
		srPhone:=[Customer:2]phone:13
		srZip:=[Customer:2]zip:8
		srDisplayEmail:=[Customer:2]email:81
	: ($1=Table:C252(->[Vendor:38]))
		srAcct:=[Vendor:38]vendorID:1
		srCustomer:=[Vendor:38]company:2
		srPhone:=[Vendor:38]phone:10
		srZip:=[Vendor:38]zip:8
		srDisplayEmail:=[Vendor:38]email:59
End case 
If ((allowAlerts_boo) & ($1#0))
	Alert_OPiP
End if 