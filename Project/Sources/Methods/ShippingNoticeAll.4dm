//%attributes = {}
//Email Shipping Notice All 20140710.4d
//Author James W. Medlen
//New format for All confirmations
//Customers OptOut applies to Invoices Email address
//updated for batch process

// Initailize arrays and variaibles 
ARRAY TEXT:C222(atEmail; 0)

vHere:=2  //force single pass email
viSent:=0
<>ShowEmailDialog:=0
viLinesShipped:=0
viNoTracking:=0

QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)

//Verify that shipping Notice can be sent
QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2; *)
QUERY:C277([InvoiceLine:54];  & ; [InvoiceLine:54]qty:7>0; *)
QUERY:C277([InvoiceLine:54])
CREATE SET:C116([InvoiceLine:54]; "LinesShipped")
viLinesShipped:=Records in selection:C76([InvoiceLine:54])
//Include invoice lines with Qty Backlogged
QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2; *)
QUERY:C277([InvoiceLine:54];  & ; [InvoiceLine:54]qtyBackLogged:8>0; *)
QUERY:C277([InvoiceLine:54])
CREATE SET:C116([InvoiceLine:54]; "LinesBackLogged")
CREATE EMPTY SET:C140([InvoiceLine:54]; "LinesReported")
UNION:C120("LinesShipped"; "LinesBackLogged"; "LinesReported")
USE SET:C118("LinesReported")
CLEAR SET:C117("LinesShipped")
CLEAR SET:C117("LinesBackLogged")
CLEAR SET:C117("LinesReported")

//Check for LoadTags without Tracking Numbers
QUERY:C277([LoadTag:88]; [LoadTag:88]invoiceNum:19=[Invoice:26]invoiceNum:2; *)
QUERY:C277([LoadTag:88];  & ; [LoadTag:88]trackingid:7="Not Assigned"; *)
QUERY:C277([LoadTag:88])

viNoTracking:=Records in selection:C76([LoadTag:88])

//restore selection of all LoadTags for this invoice
QUERY:C277([LoadTag:88]; [LoadTag:88]invoiceNum:19=[Invoice:26]invoiceNum:2; *)
QUERY:C277([LoadTag:88])

If (([Invoice:26]profile5:84#"@ASN@") & ([Invoice:26]dateInvoiced:35>=(Current date:C33-365)) & (viLinesShipped>0) & (viNoTracking=0))
	
	QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Invoice:26]customerID:3; *)
	QUERY:C277([Contact:13];  & ; [Contact:13]keyTags:14="@EMC@"; *)
	QUERY:C277([Contact:13];  & ; [Contact:13]optOut:51=""; *)
	QUERY:C277([Contact:13];  & ; [Contact:13]email:35#""; *)
	QUERY:C277([Contact:13])
	vi2:=Records in selection:C76([Contact:13])
	If (vi2>0)
		FIRST RECORD:C50([Contact:13])
		For (vi1; 1; vi2)
			viSent:=Find in array:C230(atEmail; [Contact:13]email:35)
			If ((viSent=-1) & ([Contact:13]email:35#""))
				variable1:=[Contact:13]email:35
				APPEND TO ARRAY:C911(atEmail; [Contact:13]email:35)
				// Execute_TallyMaster ("ShippingNoticeOne";"Email";3)
				ShippingNoticeOne
			End if 
			NEXT RECORD:C51([Contact:13])
		End for 
	End if 
	
	viSent:=Find in array:C230(atEmail; [Invoice:26]email:76)
	If ((viSent=-1) & ([Invoice:26]email:76#"") & ([Customer:2]optOut:98=""))
		variable1:=[Invoice:26]email:76
		APPEND TO ARRAY:C911(atEmail; [Invoice:26]email:76)
		//Execute_TallyMaster ("ShippingNoticeOne";"Email";3)
		ShippingNoticeOne
	End if 
	
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
	If (Records in selection:C76([Customer:2])=1)
		viSent:=Find in array:C230(atEmail; [Customer:2]email:81)
		If ((viSent=-1) & ([Customer:2]email:81#"") & ([Customer:2]optOut:98=""))
			variable1:=[Customer:2]email:81
			// Execute_TallyMaster ("ShippingNoticeOne";"Email";3)
			ShippingNoticeOne
		End if 
	End if 
	UNLOAD RECORD:C212([Customer:2])
	
	//Send copy to Sales Person
	If ([Invoice:26]salesNameID:23#"")
		QUERY:C277([Employee:19]; [Employee:19]nameID:1=[Invoice:26]salesNameID:23)
		If ([Employee:19]email:16#"")
			variable1:=[Employee:19]email:16
			// Execute_TallyMaster ("ShippingNoticeOne";"Email";3)
			ShippingNoticeOne
			QUERY:C277([Employee:19]; [Employee:19]nameID:1=Current user:C182)
		End if 
	End if 
	
	vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
	vtMyDate:=String:C10(Current date:C33; 4)
	vtMyName:=Current user:C182
	
	// No email address
	If (Size of array:C274(atEmail)=0)
		If ([Invoice:26]profile5:84#"@ASN@")
			[Invoice:26]profile5:84:=[Invoice:26]profile5:84+"ASN "
			vtMyText:="ASN Email Not Sent - No Email address"+"\r"
			vtComment:=vtMyDate+": "+vtMyTime+"; "+vtMyName+" - "+vtMyText
			[Invoice:26]commentProcess:73:=vtComment+[Invoice:26]commentProcess:73
			SAVE RECORD:C53([Invoice:26])
		End if 
	End if 
	
End if   //End verify

If (Caps lock down:C547)
	vText:=""
	vText:=vText+"viLinesShipped = "+String:C10(viLinesShipped)+"\r"
	vText:=vText+"viNoTracking = "+String:C10(viNoTracking)+"\r"
	vText:=vText+"[Invoice]Profile5 = "+[Invoice:26]profile5:84+"\r"
	vText:=vText+"Size of Array(atEmail) = "+String:C10(Size of array:C274(atEmail))+"\r"
	vText:=vText+"viSent = "+String:C10(viSent)+"\r"
	ALERT:C41(vText)
End if 

vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
vtMyDate:=String:C10(Current date:C33; 4)
vtMyName:=Current user:C182

// No Lines Shipped
If (viLinesShipped=0)
	If ([Invoice:26]profile5:84#"@ASN@")
		[Invoice:26]profile5:84:=[Invoice:26]profile5:84+"ASN "
		vtMyText:="ASN Email Not Sent - No Lines Shipped"+"\r"
		vtComment:=vtMyDate+": "+vtMyTime+"; "+vtMyName+" - "+vtMyText
		[Invoice:26]commentProcess:73:=vtComment+[Invoice:26]commentProcess:73
		SAVE RECORD:C53([Invoice:26])
	End if 
End if 

// Tracking Not Assigned
If ((viNoTracking>0) & ([Invoice:26]shipVia:5#"Pick Up"))
	If ([Invoice:26]profile5:84#"@TNA@")
		[Invoice:26]profile5:84:=[Invoice:26]profile5:84+"TNA "
		vtMyText:="ERROR: ASN Email Not Sent - Tracking Not Assigned"+"\r"
		vtComment:=vtMyDate+": "+vtMyTime+"; "+vtMyName+" - "+vtMyText
		[Invoice:26]commentProcess:73:=vtComment+[Invoice:26]commentProcess:73
		SAVE RECORD:C53([Invoice:26])
	End if 
End if 

ARRAY TEXT:C222(atEmail; 0)

