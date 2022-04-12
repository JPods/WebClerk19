//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/25/07, 11:40:21
// ----------------------------------------------------
// Method: ShipmentTracking
// Description
// 
//
// Parameters
// ----------------------------------------------------
//
vText1:=""
Case of 
	: (ptCurTable=(->[Invoice:26]))
		If (vHere=1)
			vi4:=Records in selection:C76([Invoice:26])
			FIRST RECORD:C50([Invoice:26])
			For (vi3; 1; vi4)
				QUERY:C277([LoadTag:88]; [LoadTag:88]invoiceNum:19=[Invoice:26]invoiceNum:2)
				SELECTION TO ARRAY:C260([LoadTag:88]trackingid:7; aQueryFieldNames)
				vi2:=Size of array:C274(aQueryFieldNames)
				NEXT RECORD:C51([Invoice:26])
				For (vi1; 1; vi2)
					vText1:=vText1+"\r"+aQueryFieldNames{vi1}
				End for 
			End for 
			UNLOAD RECORD:C212([Invoice:26])
		Else 
			QUERY:C277([LoadTag:88]; [LoadTag:88]invoiceNum:19=[Invoice:26]invoiceNum:2)
			SELECTION TO ARRAY:C260([LoadTag:88]trackingid:7; aQueryFieldNames)
			vi2:=Size of array:C274(aQueryFieldNames)
			For (vi1; 1; vi2)
				vText1:=vText1+"\r"+aQueryFieldNames{vi1}
			End for 
		End if 
	: (ptCurTable=(->[Order:3]))
		If (vHere=1)
			vi4:=Records in selection:C76([Order:3])
			FIRST RECORD:C50([Order:3])
			For (vi3; 1; vi4)
				QUERY:C277([LoadTag:88]; [LoadTag:88]orderNum:29=[Order:3]orderNum:2)
				SELECTION TO ARRAY:C260([LoadTag:88]trackingid:7; aQueryFieldNames)
				vi2:=Size of array:C274(aQueryFieldNames)
				NEXT RECORD:C51([Order:3])
				For (vi1; 1; vi2)
					vText1:=vText1+"\r"+aQueryFieldNames{vi1}
				End for 
			End for 
			UNLOAD RECORD:C212([Order:3])
		Else 
			QUERY:C277([LoadTag:88]; [LoadTag:88]orderNum:29=[Order:3]orderNum:2)
			SELECTION TO ARRAY:C260([LoadTag:88]trackingid:7; aQueryFieldNames)
			vi2:=Size of array:C274(aQueryFieldNames)
			For (vi1; 1; vi2)
				vText1:=vText1+"\r"+aQueryFieldNames{vi1}
			End for 
		End if 
	: (ptCurTable=(->[Customer:2]))
		vi1:=Num:C11(Request:C163("Number of TrackingID's per customer."; "10"))
		If (vHere=1)
			vi4:=Records in selection:C76([Customer:2])
			FIRST RECORD:C50([Customer:2])
			For (vi3; 1; vi4)
				QUERY:C277([LoadTag:88]; [LoadTag:88]customerID:23=[Customer:2]customerID:1)
				SELECTION TO ARRAY:C260([LoadTag:88]trackingid:7; aQueryFieldNames)  //;[LoadTag]DTShipOn;iLoLongInt1)
				vi2:=Size of array:C274(aQueryFieldNames)
				NEXT RECORD:C51([Order:3])
				For (vi1; 1; vi2)
					vText1:=vText1+"\r"+aQueryFieldNames{vi1}
				End for 
			End for 
			UNLOAD RECORD:C212([Order:3])
		Else 
			QUERY:C277([LoadTag:88]; [LoadTag:88]orderNum:29=[Order:3]orderNum:2)
			SELECTION TO ARRAY:C260([LoadTag:88]trackingid:7; aQueryFieldNames)
			vi2:=Size of array:C274(aQueryFieldNames)
			For (vi1; 1; vi2)
				vText1:=vText1+"\r"+aQueryFieldNames{vi1}
			End for 
		End if 
End case 

If (vText1#"")
	SET TEXT TO PASTEBOARD:C523(vText1)
	Case of 
		: ([Invoice:26]shipVia:5="@UPS@")
			OPEN URL:C673("http://www.ups.com/WebTracking/track?loc=en_US")
		: ([Invoice:26]shipVia:5="@fedex@")
			OPEN URL:C673("http://www.fedex.com/us/pckgenvlp/track/index.html?link=1&lid=//Track&hbxrootmenu"+"id=//Track&hbxrootmenuorientation=down")
	End case 
End if 
