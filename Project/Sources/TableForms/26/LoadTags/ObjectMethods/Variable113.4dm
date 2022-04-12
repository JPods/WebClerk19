// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/21/11, 12:56:51
// ----------------------------------------------------
// Method: Object Method: [Invoice].LoadTags.iLo40String1
// Description
// Modified: 09/21/11
// Structure: CE11r6yn_07.4DB
// New 34 character Fedex barcode
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20150323_1658 new FedEx case statement with error message

//trackID

//###_jwm_strip out leading brace and W
If (iLo40String1#"")
	If (iLo40String1[[1]]="{")
		iLo40String1:=Substring:C12(iLo40String1; 2)
	End if 
	If (iLo40String1[[1]]="W")  //Airborne to DHL
		iLo40String1:=Substring:C12(iLo40String1; 2)
	End if 
	//iLo40String1:=Replace string(iLo40String1;;"")  //barcode strip lead
	//iLo40String1:=Replace string(iLo40String1;"W";"")
	
	//###_jwm_### 20070821
	
	If (iLo40String1[[1]]="Q")  //EasyShip to DHL
		iLo40String1:=Substring:C12(iLo40String1; 2)
	End if 
End if 

If ([Invoice:26]shipVia:5="FedEx@")  //FedEx Barcode to trackID
	vi3:=Length:C16(iLo40String1)
	// ### jwm ### 20150323_1658 new case statement with error message
	Case of 
		: (vi3=34)
			iLo40String1:=Substring:C12(iLo40String1; 21; 14)
			//###_jwm_### 20110921 New 34 character FedEx Barcode format for Express packages effective October 2011
		: (vi3=33)
			iLo40String1:=Substring:C12(iLo40String1; 20; 14)
			//### jwm ### 20120629_1057 in case barcode scanner drops a character
		: (vi3=32)
			iLo40String1:=Substring:C12(iLo40String1; 17; 12)
			// old FedEx Express
		: (vi3=22)
			iLo40String1:=Substring:C12(iLo40String1; 8; 15)
			// old FedEx Ground
		: (vi3=14)
			// standard 14 length FedEx Barcode
		: ((vi3=12) & (iLo40String1="Not Assigned"))
			// barcode not assigned
		: ((vi3=12) & ([Invoice:26]shipVia:5="@Freight@"))
			// FedEx Freight
		Else 
			ALERT:C41("ERROR: Invalid FedEx Tracking Number - "+String:C10(vi3)+" Characters")
	End case 
	
	If (False:C215)  // ### jwm ### 20150323_1655 old method no warning message
		//###_jwm_### 20110921 New 34 character FedEx Barcode format for Express packages effective October 2011
		If (vi3=34)
			iLo40String1:=Substring:C12(iLo40String1; 21; 14)
		End if 
		//### jwm ### 20120629_1057 in case barcode scanner drops a character
		If (vi3=33)
			iLo40String1:=Substring:C12(iLo40String1; 20; 14)
		End if 
		
		If (vi3=32)
			iLo40String1:=Substring:C12(iLo40String1; 17; 12)
		End if 
		
		If (vi3=22)
			iLo40String1:=Substring:C12(iLo40String1; 8; 15)
		End if 
	End if 
	
End if 

$k:=Size of array:C274(aShipSel)
For ($i; 1; $k)
	aPKtrackID{aShipSel{$i}}:=iLo40String1
End for 
doSearch:=5

If (False:C215)
	//trackID
	
	//###_jwm_strip out leading brace and W
	If (iLo40String1[[1]]="{")
		iLo40String1:=Substring:C12(iLo40String1; 2)
	End if 
	If (iLo40String1[[1]]="W")  //Airborne to DHL
		iLo40String1:=Substring:C12(iLo40String1; 2)
	End if 
	//iLo40String1:=Replace string(iLo40String1;;"")//barcode strip lead
	//iLo40String1:=Replace string(iLo40String1;"W";"")
	
	$k:=Size of array:C274(aShipSel)
	For ($i; 1; $k)
		aPKtrackID{aShipSel{$i}}:=iLo40String1
	End for 
	doSearch:=5
	
End if 