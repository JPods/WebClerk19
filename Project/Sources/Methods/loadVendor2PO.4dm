//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/04/09, 11:45:25
// ----------------------------------------------------
// Method: loadVendor2PO
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (([PO:39]vendorID:1#[Vendor:38]vendorID:1) | (Is new record:C668([PO:39])))
	[PO:39]vendorID:1:=[Vendor:38]vendorID:1
	[PO:39]idVendor:75:=[Vendor:38]id:98
	[PO:39]attnVend:37:=[Vendor:38]attention:55
	[PO:39]terms:17:=[Vendor:38]terms:30
	[PO:39]vendorCompany:39:=[Vendor:38]company:2
	[PO:39]vendorPhone:77:=[Vendor:38]phone:10
	[PO:39]vendorFax:78:=[Vendor:38]fax:13
	[PO:39]vendorEmail:79:=[Vendor:38]email:59
	[PO:39]lng:72:=[Vendor:38]lng:94
	[PO:39]lat:88:=[Vendor:38]lat:104
	If ([Vendor:38]portPostingOrders:88=0)
		[Vendor:38]portPostingOrders:88:=80
	End if 
	[PO:39]obSync:80:=New object:C1471
End if 
//
//If ([PO]DomainSO="")
//[PO]DomainSO:=[Vendor]Domain

//End if 
If (allowAlerts_boo)
	srVarLoad(Table:C252(->[Vendor:38]))
	//  Put  the formating in the form  jFormatPhone(->[Vendor]phone; ->[Vendor]fax; ->srPhone)
	If (([Vendor:38]currency:69#"") & (Size of array:C274(aPOLineAction)=0) & (Is new record:C668([PO:39])))
		[PO:39]currency:46:=[Vendor:38]currency:69
		$error:=Exch_GetCurr([PO:39]currency:46)
		[PO:39]exchangeRate:45:=vrExRate
		Exch_FillRays
		UNLOAD RECORD:C212([Currency:61])
	End if 
End if 
//