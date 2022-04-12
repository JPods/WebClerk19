//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-09-16T00:00:00, 12:30:57
// ----------------------------------------------------
// Method: WebServiceSandBox
// Description
// Modified: 09/16/16
// 
// 
//
// Parameters
// ----------------------------------------------------

//  JWM account lookup
//  UPSBill3rdPartyLookup

// this method manages a communications exchange based on:

//  - records in hand, either start with a current selection or [TallyMaster]Script
//  - Template   // [TallyMaster]HeadAdder
//  - SyncRelationship Record  
//  - TallyMasters to parse response  [TallyMaster]Build or After


// Script cleaned 20160802

//Script UPS_ShipOnDate 20160617

//Write UPS TimeInTransit Request from Order

//Declare variables
C_TEXT:C284(HTTP_URL; HTTP_Protocol; HTTP_Host; HTTP_Path; XML_Response)
C_TEXT:C284(vtRequestMethod; vtHeaders; vtPath; vtcrlf; vtOptions)
C_LONGINT:C283(HTTP_Port; HTTP_TimeOut; vlIndex; vlError)
C_LONGINT:C283(vlSocket; vlTimeoutAt; vlBytesSend; vlPosition; HTTP_TestMode)
C_BLOB:C604(HTTP_Data; vxResponse; vxIncomingBlob; vxOutGoingBlob)

// Convert this to a TallyMaster to set a set of records/data needed
//  ######################   Begin Get Data    ###################### 

If (([Order:3]country:21="US") | ([Order:3]country:21="USA") | ([Order:3]country:21="United States") | ([Order:3]country:21=""))
	vText1:=Substring:C12([Order:3]zip:20; 1; 5)
Else 
	vText1:=[Order:3]zip:20
End if 
//=======================================================
// Begin Country Code Lookup
//=======================================================
viLength:=Length:C16([Order:3]country:21)
If (viLength#2)
	QUERY:C277([GenericChild2:91]; [GenericChild2:91]a02:29=[Order:3]country:21)
	viRecords:=Records in selection:C76([GenericChild2:91])
	If (viRecords=1)
		vText2:=[GenericChild2:91]a01:28
	Else 
		// ALERT("Valid Country Code Not Found")
		vText2:=[Order:3]country:21
	End if 
Else 
	vText2:=Substring:C12([Order:3]country:21; 1; 2)
End if 
REDUCE SELECTION:C351([GenericChild2:91]; 0)
vText2:=Uppercase:C13(vText2)
vText3:=String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33); "00")+String:C10(Day of:C23(Current date:C33); "00")

//TEMPORARY FIX FOR UPS BEING CLOSED
If (Current date:C33=!2012-01-02!)
	vText3:=String:C10(Year of:C25(Current date:C33+1))+String:C10(Month of:C24(Current date:C33+1); "00")+String:C10(Day of:C23(Current date:C33+1); "00")
End if 

//  ######################   END Get Data    ###################### 


//  ######################   Begin Get Template    ###################### 

QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8="TimeInTransitUPS"; *)  // is a template, not a procedure
QUERY:C277([TallyMaster:60];  & ; [TallyMaster:60]purpose:3="WebService"; *)
QUERY:C277([TallyMaster:60])


If (Records in selection:C76([TallyMaster:60])=1)
	
	//       *******   Begin Convert Data into format required by host    ******* 
	
	HTTPSendText:=TagsToText([TallyMaster:60]template:29)  // changed from Script
	
	//[TallyMaster]Build:=HTTPSendText
	
	//  SAVE RECORD([TallyMaster])  // BJ dislike this
	
	//       *******   End Convert Data into format required by host    ******* 
	
	//  ######################   End Get Template    ###################### 
	
	//  ######################   Begin Get SyncyRelationship    ###################### 
	
	
	If (True:C214)
		
		WebServiceSynRelationCall([TallyMaster:60]name:8; HTTPSendText)
		
		
	Else 
		QUERY:C277([SyncRelation:103]; [SyncRelation:103]name:8="TimeInTransitUPS")
		
		//      *******   Set communications variables    ******* 
		NTK_DeleteRequest  // clear existing values
		SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
		SET BLOB SIZE:C606(HTTP_Data; 0)  // initialize blob
		TEXT TO BLOB:C554(HTTPSendText; HTTP_Data; Mac text without length:K22:10; *)  // convert text to blob for sending
		
		//Set the default properties (url and empty data/blob )
		//Parse HTTPClient_URL into HTTP_URL,HTTP_Protocol,HTTP_Host,HTTP_Path,HTTP_Port
		
		If ([SyncRelation:103]testMode:37)
			HTTPClient_URL:=[SyncRelation:103]partner2URL:33
			// HTTPClient_URL:="https://wwwcie.ups.com/ups.app/xml/TimeInTransit"  //set URL Test Environment
			NTK_SetURL(HTTPClient_URL)  // get the protocol
			// HTTP_Protocol
			// HTTP_Host
			// HTTP_Path
			HTTP_Port:=[SyncRelation:103]portTest:34  // override
		Else 
			HTTPClient_URL:=[SyncRelation:103]partner1URL:2
			// HTTPClient_URL:="https://onlinetools.ups.com/ups.app/xml/TimeInTransit"  //set URL Production Environment
			NTK_SetURL(HTTPClient_URL)  // get the protocol
			// HTTP_Protocol
			// HTTP_Host
			// HTTP_Path
			HTTP_Port:=[SyncRelation:103]portProduction:9  // override
		End if 
		HTTP_TimeOut:=[SyncRelation:103]timeOut:16
		HTTP_TimeOut:=20  //seconds
		
		
		If ([SyncRelation:103]requestMethod:38="Get")
			$error:=WC_Request("Get")  //Sends Blob: HTTP_Data Passes "Get" or "Post"
		Else 
			$error:=WC_Request("Post")  //Sends Blob: HTTP_Data Passes "Get" or "Post"
		End if 
	End if 
	
	
	HTTPClient_Response:=BLOB to text:C555(HTTP_IncomingBlob; Mac text without length:K22:10)
	
	//       *******   End communications variables    ******* 
	
	
	
	//  ######################   End Get SyncyRelationship    ###################### 
	
	
	
	
	If (Length:C16(HTTPClient_Response)>0)
		
		vlStart:=Position:C15("<?xml"; HTTPClient_Response)  // find beginning of XML response
		XML_Response:=Substring:C12(HTTPClient_Response; vlStart)  //get xml response without header
		
		vlError:=Position:C15("ERROR"; XML_Response)  //test response for error message
		If (vlError#0)
			If (allowAlerts_boo)
				ALERT:C41("UPS Request generated an Error")
			End if 
		Else 
			//===========================
			//Begin parsing XML response
			//===========================
			
			C_TEXT:C284(vtCode; vtDescription; vtGuaranteed; vtBusinessTransitDays; vtMyTime)
			C_TEXT:C284(vtPickupDvte; vtPickupTime; vtDvte; vtDayOfWeek; vtCustomerCenterCutoff)
			
			ARRAY TEXT:C222(atCode; 0)
			ARRAY TEXT:C222(atDescription; 0)
			ARRAY TEXT:C222(atGuaranteed; 0)
			ARRAY TEXT:C222(atBusinessTransitDays; 0)
			ARRAY TEXT:C222(atTime; 0)
			ARRAY TEXT:C222(atPickupDate; 0)
			ARRAY TEXT:C222(atPickupTime; 0)
			ARRAY TEXT:C222(atDate; 0)
			ARRAY TEXT:C222(atDayOfWeek; 0)
			ARRAY TEXT:C222(atCustomerCenterCutoff; 0)
			
			C_TEXT:C284(vtCode; vtDescription; vtGuaranteed; vtBusinessTransitDays; vtMyTime)
			C_TEXT:C284(vtPickupDate; vtPickupTime; vtDate; vtDayOfWeek; vtCustomerCenterCutoff)
			
			//===========================
			//Check for Service Summary
			//===========================
			
			Struct_Ref:=DOM Parse XML variable:C720(XML_Response)  //get reference to XML response
			vFound:=DOM Find XML element:C864(Struct_Ref; "/TimeInTransitResponse/TransitResponse")  // find transit response
			If (OK=1)
				DOM GET XML ELEMENT NAME:C730(vFound; value)
				//ALERT("The name of the element is: \""+value+"\"")
				//Count the number of Service Summaries in the Transit Response
				vi2:=DOM Count XML elements:C726(vFound; "ServiceSummary")
				//Alert("Count of ServiceSummary child elements = "+String(vi2))
				
				//Find first Service Summary
				vSummaryRef:=DOM Find XML element:C864(vFound; "TransitResponse/ServiceSummary")
				
				vText:=""  // initialize vText
				For (vi1; 1; vi2)
					
					vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/Service/Code")
					DOM GET XML ELEMENT VALUE:C731(vRef; vtCode)
					APPEND TO ARRAY:C911(atCode; vtCode)
					
					vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/Service/Description")
					DOM GET XML ELEMENT VALUE:C731(vRef; vtDescription)
					APPEND TO ARRAY:C911(atDescription; vtDescription)
					
					vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/Guaranteed/Code")
					DOM GET XML ELEMENT VALUE:C731(vRef; vtGuaranteed)
					APPEND TO ARRAY:C911(atGuaranteed; vtGuaranteed)
					
					vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/EstimatedArrival/BusinessTransitDays")
					DOM GET XML ELEMENT VALUE:C731(vRef; vtBusinessTransitDays)
					APPEND TO ARRAY:C911(atBusinessTransitDays; vtBusinessTransitDays)
					
					vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/EstimatedArrival/Time")
					DOM GET XML ELEMENT VALUE:C731(vRef; vtMyTime)
					APPEND TO ARRAY:C911(atTime; vtMyTime)
					
					vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/EstimatedArrival/PickupDate")
					DOM GET XML ELEMENT VALUE:C731(vRef; vtPickupDate)
					APPEND TO ARRAY:C911(atPickupDate; vtPickupDate)
					
					vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/EstimatedArrival/PickupTime")
					DOM GET XML ELEMENT VALUE:C731(vRef; vtPickupTime)
					APPEND TO ARRAY:C911(atPickupTime; vtPickupTime)
					
					vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/EstimatedArrival/Date")
					DOM GET XML ELEMENT VALUE:C731(vRef; vtDate)
					APPEND TO ARRAY:C911(atDate; vtDate)
					
					vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/EstimatedArrival/DayOfWeek")
					DOM GET XML ELEMENT VALUE:C731(vRef; vtDayOfWeek)
					APPEND TO ARRAY:C911(atDayOfWeek; vtDayOfWeek)
					
					vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/EstimatedArrival/CustomerCenterCutoff")
					DOM GET XML ELEMENT VALUE:C731(vRef; vtCustomerCenterCutoff)
					APPEND TO ARRAY:C911(atCustomerCenterCutoff; vtCustomerCenterCutoff)
					
					//ALERT( vtCode + " - "+vtDescription+"\r"+"\r"+"Transit Days = " + vtDays)
					vText:=vText+"Service Code:   "+vtCode+vtcrlf
					vText:=vText+"Description:    "+vtDescription+vtcrlf
					vText:=vText+"Guaranteed:     "+vtGuaranteed+vtcrlf
					vText:=vText+"Business Days:  "+vtBusinessTransitDays+vtcrlf
					vText:=vText+"Pickup Date:    "+vtPickupDate+vtcrlf
					vText:=vText+"Pickup Time:    "+vtPickupTime+vtcrlf
					vText:=vText+"Arrival Date:   "+vtDate+vtcrlf
					vText:=vText+"Arrival Time:   "+vtMyTime+vtcrlf
					vText:=vText+"Day Of Week:    "+vtDayOfWeek+vtcrlf
					vText:=vText+"Center Cutoff:  "+vtCustomerCenterCutoff+vtcrlf+vtcrlf
					//Alert(vText)
					
					//Next Service Summary
					vSummaryRef:=DOM Get next sibling XML element:C724(vSummaryRef)
					
				End for 
				
				//==============================================
				// lookup orders shipping decode ship on date
				//==============================================
				
				QUERY:C277([Carrier:11]; [Carrier:11]carrierid:10=[Order:3]shipVia:13; *)
				QUERY:C277([Carrier:11];  & ; [Carrier:11]active:6=True:C214; *)
				QUERY:C277([Carrier:11])
				
				vi6:=Find in array:C230(atCode; [Carrier:11]carrierCode:41)
				If (vi6>0)
					viBusinessDays:=Num:C11(atBusinessTransitDays{vi6})
					vdShipOnDate:=[Order:3]dateNeeded:5
					While (viBusinessDays>0)
						vdshipOnDate:=vdShipOnDate-1
						If ((Day number:C114(vdshipOnDate)#7) & (Day number:C114(vdshipOnDate)#1))
							viBusinessDays:=viBusinessDays-1
						End if 
					End while 
					
					[Order:3]dateShipOn:31:=vdShipOnDate
					
					SAVE RECORD:C53([Order:3])
					
					vtMessage:=""
					vtMessage:=vtMessage+"Service = "+atDescription{vi6}+vtcrlf
					vtMessage:=vtMessage+"Business Days = "+atBusinessTransitDays{vi6}+vtcrlf
					vtMessage:=vtMessage+"Ship on date = "+String:C10(vdShipOnDate)+vtcrlf
					If (allowAlerts_boo)
						ALERT:C41(vtMessage)
					End if 
				Else 
					If (allowAlerts_boo)
						ALERT:C41("No Carrier Code Found for: "+[Order:3]shipVia:13+"\r"+"\r"+"!!! This Service May Not B Valid For This Address !!!")
					End if 
				End if 
				
				
			End if 
			
			//===========================
			//Check for Address List
			//===========================
			
			ARRAY TEXT:C222(atCity; 0)
			ARRAY TEXT:C222(atState; 0)
			ARRAY TEXT:C222(atCountry; 0)
			ARRAY TEXT:C222(atCountryCode; 0)
			ARRAY TEXT:C222(atZipLow; 0)
			ARRAY TEXT:C222(atZipHigh; 0)
			
			C_TEXT:C284(vtCity; vtState; vtCountry; vtCountry; vtCountryCode; vtZipLow; vtZipHigh)
			
			vFound:=DOM Find XML element:C864(Struct_Ref; "/TimeInTransitResponse/TransitToList")  // find transit response
			If (OK=1)
				DOM GET XML ELEMENT NAME:C730(vFound; value)
				//ALERT("The name of the element is: \""+value+"\"")
				//Count the number of Service Summaries in the Transit Response
				vi2:=DOM Count XML elements:C726(vFound; "Candidate")
				//Alert("Count of ServiceSummary child elements = "+String(vi2))
				
				//Find first Service Summary
				vSummaryRef:=DOM Find XML element:C864(vFound; "TransitToList/Candidate")
				
				vText:="UPS Could not find your address and suggests the following"+vtcrlf+vtcrlf  // initialize vText
				For (vi1; 1; vi2)
					
					vRef:=DOM Find XML element:C864(vSummaryRef; "Candidate/AddressArtifactFormat/PoliticalDivision2")
					DOM GET XML ELEMENT VALUE:C731(vRef; vtCity)
					APPEND TO ARRAY:C911(atCity; vtCity)
					
					vRef:=DOM Find XML element:C864(vSummaryRef; "Candidate/AddressArtifactFormat/PoliticalDivision1")
					If (OK=1)  //international shipments do not return PoliticalDivision1
						DOM GET XML ELEMENT VALUE:C731(vRef; vtState)
						APPEND TO ARRAY:C911(atState; vtState)
					Else 
						vtState:=""
					End if 
					
					vRef:=DOM Find XML element:C864(vSummaryRef; "Candidate/AddressArtifactFormat/Country")
					DOM GET XML ELEMENT VALUE:C731(vRef; vtCountry)
					APPEND TO ARRAY:C911(atCountry; vtCountry)
					
					vRef:=DOM Find XML element:C864(vSummaryRef; "Candidate/AddressArtifactFormat/CountryCode")
					DOM GET XML ELEMENT VALUE:C731(vRef; vtCountryCode)
					APPEND TO ARRAY:C911(atCountryCode; vtCountryCode)
					
					vRef:=DOM Find XML element:C864(vSummaryRef; "Candidate/AddressArtifactFormat/PostcodePrimaryLow")
					DOM GET XML ELEMENT VALUE:C731(vRef; vtZipLow)
					APPEND TO ARRAY:C911(atZipLow; vtZipLow)
					
					vRef:=DOM Find XML element:C864(vSummaryRef; "Candidate/AddressArtifactFormat/PostcodePrimaryHigh")
					DOM GET XML ELEMENT VALUE:C731(vRef; vtZipHigh)
					APPEND TO ARRAY:C911(atZipHigh; vtZipHigh)
					
					//ALERT( vtCode + " - "+vtDescription+"\r"+"\r"+"Transit Days = " + vtDays)
					vText:=vText+String:C10(vi1)+". "+vtCity+" "+vtState+" "+vtCountryCode+" "+vtZipLow+vtcrlf
					
					//Next Candidate
					vSummaryRef:=DOM Get next sibling XML element:C724(vSummaryRef)
					
				End for 
				If (allowAlerts_boo)
					ALERT:C41(vText)
				End if 
			End if 
			
			DOM CLOSE XML:C722(Struct_Ref)
			
			//SET TEXT TO PASTEBOARD (vText)
			
			vText:="<TransitResponse>"+"\r"+"\r"+vText+"</TransitResponse>"
			
			vText1:="(?s)(<TransitResponse>.*</TransitResponse>)"
			
			If (Preg Match(vText1; [Order:3]commentProcess:12)=1)
				If (allowAlerts_boo)
					ALERT:C41("Match Found")
				End if 
				//Preg Replace(find;replace;subject)
				[Order:3]commentProcess:12:=Preg Replace(vText1; vText; [Order:3]commentProcess:12)
			Else 
				[Order:3]commentProcess:12:=[Order:3]commentProcess:12+"\r"+vText
			End if 
			
			SAVE RECORD:C53([Order:3])
			
			//[Order]CommentProcess := [Order]CommentProcess + "\r" + "\r" + vText
			
		End if 
	End if 
Else 
	If (allowAlerts_boo)
		ALERT:C41("UPS TimeInTransit TallyMaster not Found")
	End if 
End if 

UNLOAD RECORD:C212([SyncRelation:103])
UNLOAD RECORD:C212([TallyMaster:60])