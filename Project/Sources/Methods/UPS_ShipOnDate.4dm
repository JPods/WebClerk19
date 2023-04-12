//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 04/17/17, 14:52:06
// ----------------------------------------------------
// Method: UPS_ShipOnDate
// Description
// 
//
// Parameters
// ----------------------------------------------------


//Script UPS_ShipOnDate 20160617

//Write UPS TimeInTransit Request from Order

//Declare variables
C_TEXT:C284(HTTP_URL; HTTP_Protocol; HTTP_Host; HTTP_Path; XML_Response)
C_TEXT:C284(vtRequestMethod; vtHeaders; vtPath; vtcrlf; vtOptions)
C_LONGINT:C283(HTTP_Port; HTTP_TimeOut; vlIndex; vlError)
C_LONGINT:C283(vlSocket; vlTimeoutAt; vlBytesSend; vlPosition; HTTP_TestMode)
C_BLOB:C604(HTTP_Data; vxResponse; vxIncomingBlob; vxOutGoingBlob)

HTTP_Path:=""

If (([Order:3]country:21="US") | ([Order:3]country:21="USA") | ([Order:3]country:21="United States"))
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
		If (allowAlerts_boo)
			jMessageWindow("Valid Country Code Not Found")
		End if 
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

QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8="TimeInTransit"; *)
QUERY:C277([TallyMaster:60];  & ; [TallyMaster:60]purpose:3="UPS"; *)
QUERY:C277([TallyMaster:60])

If (Records in selection:C76([TallyMaster:60])=1)
	
	//vText:=[TallyMaster]Script
	//SET BLOB SIZE(blobPageOut;0)  //must be initialized 
	//myErr:=WC_PageSendWithTags (0;"";0;->vText)
	//vText:=BLOB to text(blobPageOut;Mac text without length )  //  -> vText
	vText:=TagsToText([TallyMaster:60]script:9)
	HTTPSendText:=vText  // formatted Request to send
	[TallyMaster:60]build:6:=vText
	vText:=""
	SAVE RECORD:C53([TallyMaster:60])
	
	// Initiate a new request
	
	NTK_DeleteRequest  // clear existing values
	
	//HTTPClient_URL:="https://wwwcie.ups.com/ups.app/xml/TimeInTransit"//set URL Test Environment
	HTTPClient_URL:="https://onlinetools.ups.com/ups.app/xml/TimeInTransit"  //set URL Production Environment
	
	//Set the default properties (url and empty data/blob )
	//Parse HTTPClient_URL into HTTP_URL,HTTP_Protocol,HTTP_Host,HTTP_Path,HTTP_Port
	NTK_SetURL(HTTPClient_URL)
	SET BLOB SIZE:C606(HTTP_Data; 0)
	HTTP_TimeOut:=20  //seconds
	
	SET BLOB SIZE:C606(HTTP_Data; 0)  // initialize blob
	TEXT TO BLOB:C554(HTTPSendText; HTTP_Data; Mac text without length:K22:10; *)  // convert text to blob for sending
	
	// Send the request
	
	//vlError:=WC_Request ("POST";->vxResponse)   //### jwm ### does not work from script
	//HTTP_Data is empty when calling internal method
	
	//=============================================
	// custom WC_Request Post only pointers removed
	//=============================================
	
	vtRequestMethod:="POST"
	vlError:=-1
	
	// Clear the response blob
	SET BLOB SIZE:C606(vxResponse; 0)
	
	vtPath:=HTTP_Path
	
	// Build the HTTP headers
	vtcrlf:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
	vtHeaders:=vtRequestMethod+" "+vtPath+" HTTP/1.1"+vtcrlf
	vtHeaders:=vtHeaders+"User-Agent: WebClerk-CommerceExpert HTTP Client"+vtcrlf
	vtHeaders:=vtHeaders+"Host: "+HTTP_Host+vtcrlf
	vtHeaders:=vtHeaders+"Accept: */*"+vtcrlf
	vtHeaders:=vtHeaders+"Connection: close"+vtcrlf
	
	// For a POST request we need to add a content-length header
	vtHeaders:=vtHeaders+"Content-Length: "+String:C10(BLOB size:C605(HTTP_Data))+vtcrlf
	vtHeaders:=vtHeaders+"Content-Type: application/x-www-form-urlencoded"+vtcrlf
	
	// Important: the headers must end with a blank line
	vtHeaders:=vtHeaders+vtcrlf
	
	//Append data to headers as text debugging by removing copy to Blob
	vtHeaders:=vtHeaders+BLOB to text:C555(HTTP_Data; Mac text without length:K22:10)  //### jwm ###
	
	// Convert the headers and data to a blob
	TEXT TO BLOB:C554(vtHeaders; vxOutGoingBlob; Mac text without length:K22:10)
	
	vtOptions:="connect-timeout="+String:C10(HTTP_TimeOut)
	
	If (HTTP_Protocol="https")
		vtOptions:=vtOptions+" ssl=true"
	End if 
	
	// Set the timeout and open a connection
	vlSocket:=TCP Open(HTTP_Host; HTTP_Port; vtOptions)
	
	If (vlSocket#0)
		SET BLOB SIZE:C606(vxIncomingBlob; 0)
		// Send the request
		vlBytesSend:=TCP Send Blob(vlSocket; vxOutGoingBlob)
		vlTimeoutAt:=Milliseconds:C459+(HTTP_TimeOut*1000)
		
		// Get the response (wait until the connection is closed)
		While ((TCP Get State(vlSocket)#TCP Connection Closed) & (Milliseconds:C459<vlTimeoutAt))
			If (TCP Receive Blob(vlSocket; vxIncomingBlob)>0)
				COPY BLOB:C558(vxIncomingBlob; vxResponse; 0; BLOB size:C605(vxResponse); BLOB size:C605(vxIncomingBlob))
			Else 
				DELAY PROCESS:C323(Current process:C322; 1)
			End if 
		End while 
		// Close the connection
		TCP Close(vlSocket)
		vlError:=BLOB size:C605(vxResponse)
	End if 
	
	//===========================
	//End of Custom Request
	//===========================
	
	HTTPClient_Response:=BLOB to text:C555(vxResponse; Mac text without length:K22:10)
	
	[TallyMaster:60]after:7:=HTTPClient_Response
	
	SAVE RECORD:C53([TallyMaster:60])
	
	If (HTTPClient_Response="")
		ConsoleLog("ERROR: NO RESPONSE")
		vText:=HTTPClient_Response
	Else 
		
		vlStart:=Position:C15("<?xml"; HTTPClient_Response)  // find beginning of XML response
		XML_Response:=Substring:C12(HTTPClient_Response; vlStart)  //get xml response without header
		
		vlError:=Position:C15("ERROR"; XML_Response)  //test response for error message
		If (vlError#0)
			ConsoleLog("UPS Request generated an Error")
		End if 
		
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
		
		If (OK=0)
			ConsoleLog("ERROR: XML Respnse could not be parsed")
		Else 
			vFound:=DOM Find XML element:C864(Struct_Ref; "/TimeInTransitResponse/TransitResponse")  // find transit response
			If (OK=0)
				ConsoleLog("ERROR: TimeInTransitResponse Not Found")
			Else 
				
				DOM GET XML ELEMENT NAME:C730(vFound; value)
				//jMessagewindow("The name of the element is: \""+value+"\"")
				//Count the number of Service Summaries in the Transit Response
				vi2:=DOM Count XML elements:C726(vFound; "ServiceSummary")
				//jMessagewindow("Count of ServiceSummary child elements = "+String(vi2))
				
				//Find first Service Summary
				vSummaryRef:=DOM Find XML element:C864(vFound; "TransitResponse/ServiceSummary")
				
				If (OK=0)  // not found
					ConsoleLog("ERROR: TransitResponse/ServiceSummary Not Found")
				Else 
					
					vText:=""  // initialize vText
					For (vi1; 1; vi2)
						
						vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/Service/Code")
						If (OK=1)
							DOM GET XML ELEMENT VALUE:C731(vRef; vtCode)
							APPEND TO ARRAY:C911(atCode; vtCode)
						Else 
							ConsoleLog("ERROR: ServiceSummary/Service/Code Not Found")
						End if 
						
						vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/Service/Description")
						If (OK=1)
							DOM GET XML ELEMENT VALUE:C731(vRef; vtDescription)
							APPEND TO ARRAY:C911(atDescription; vtDescription)
						Else 
							ConsoleLog("ERROR: ServiceSummary/Service/Description Not Found")
						End if 
						
						vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/Guaranteed/Code")
						If (OK=1)
							DOM GET XML ELEMENT VALUE:C731(vRef; vtGuaranteed)
							APPEND TO ARRAY:C911(atGuaranteed; vtGuaranteed)
						Else 
							ConsoleLog("ERROR: ServiceSummary/Guaranteed/Code Not Found")
						End if 
						
						vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/EstimatedArrival/BusinessTransitDays")
						If (OK=1)
							DOM GET XML ELEMENT VALUE:C731(vRef; vtBusinessTransitDays)
							APPEND TO ARRAY:C911(atBusinessTransitDays; vtBusinessTransitDays)
						Else 
							ConsoleLog("ERROR: ServiceSummary/EstimatedArrival/BusinessTransitDays Not Found")
						End if 
						
						vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/EstimatedArrival/Time")
						If (OK=1)
							DOM GET XML ELEMENT VALUE:C731(vRef; vtMyTime)
							APPEND TO ARRAY:C911(atTime; vtMyTime)
						Else 
							ConsoleLog("ERROR: ServiceSummary/EstimatedArrival/Time Not Found")
						End if 
						
						vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/EstimatedArrival/PickupDate")
						If (OK=1)
							DOM GET XML ELEMENT VALUE:C731(vRef; vtPickupDate)
							APPEND TO ARRAY:C911(atPickupDate; vtPickupDate)
						Else 
							ConsoleLog("ERROR: ServiceSummary/EstimatedArrival/PickupDate Not Found")
						End if 
						
						vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/EstimatedArrival/PickupTime")
						If (OK=1)
							DOM GET XML ELEMENT VALUE:C731(vRef; vtPickupTime)
							APPEND TO ARRAY:C911(atPickupTime; vtPickupTime)
						Else 
							ConsoleLog("ERROR: ServiceSummary/EstimatedArrival/PickupTime Not Found")
						End if 
						
						vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/EstimatedArrival/Date")
						If (OK=1)
							DOM GET XML ELEMENT VALUE:C731(vRef; vtDate)
							APPEND TO ARRAY:C911(atDate; vtDate)
						Else 
							ConsoleLog("ERROR: ServiceSummary/EstimatedArrival/Date Not Found")
						End if 
						
						vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/EstimatedArrival/DayOfWeek")
						If (OK=1)
							DOM GET XML ELEMENT VALUE:C731(vRef; vtDayOfWeek)
							APPEND TO ARRAY:C911(atDayOfWeek; vtDayOfWeek)
						Else 
							ConsoleLog("ERROR: ServiceSummary/EstimatedArrival/DayOfWeek Not Found")
						End if 
						
						vRef:=DOM Find XML element:C864(vSummaryRef; "ServiceSummary/EstimatedArrival/CustomerCenterCutoff")
						If (OK=1)
							DOM GET XML ELEMENT VALUE:C731(vRef; vtCustomerCenterCutoff)
							APPEND TO ARRAY:C911(atCustomerCenterCutoff; vtCustomerCenterCutoff)
						Else 
							ConsoleLog("ERROR: ServiceSummary/EstimatedArrival/CustomerCenterCutoff Not Found")
						End if 
						
						//jMessagewindow( vtCode + " - "+vtDescription+"\r"+"\r"+"Transit Days = " + vtDays)
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
						//jMessagewindow(vText)
						
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
							jMessageWindow(vtMessage)
						End if 
					Else 
						If (allowAlerts_boo)
							jMessageWindow("No Carrier Code Found for: "+[Order:3]shipVia:13+"\r"+"\r"+"!!! This Service May Not B Valid For This Address !!!")
						End if 
					End if 
					
				End if   // ServiceSummary
				
			End if   // TransitResponse
			
			
			
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
			If (OK=0)
				ConsoleLog("ERROR: /TimeInTransitResponse/TransitToList Not Found")
			Else 
				DOM GET XML ELEMENT NAME:C730(vFound; value)
				//jMessagewindow("The name of the element is: \""+value+"\"")
				//Count the number of Service Summaries in the Transit Response
				vi2:=DOM Count XML elements:C726(vFound; "Candidate")
				//jMessagewindow("Count of ServiceSummary child elements = "+String(vi2))
				
				//Find first Service Summary
				vSummaryRef:=DOM Find XML element:C864(vFound; "TransitToList/Candidate")
				
				If (OK=0)
					ConsoleLog("ERROR: TransitToList/Candidate Not Found")
				Else 
					
					vText:="UPS Could not find your address and suggests the following"+vtcrlf+vtcrlf  // initialize vText
					For (vi1; 1; vi2)
						
						vRef:=DOM Find XML element:C864(vSummaryRef; "Candidate/AddressArtifactFormat/PoliticalDivision2")
						If (OK=1)
							DOM GET XML ELEMENT VALUE:C731(vRef; vtCity)
							APPEND TO ARRAY:C911(atCity; vtCity)
						Else 
							ConsoleLog("ERROR: Candidate/AddressArtifactFormat/PoliticalDivision2 Not Found")
						End if 
						
						vRef:=DOM Find XML element:C864(vSummaryRef; "Candidate/AddressArtifactFormat/PoliticalDivision1")
						If (OK=1)  //international shipments do not return PoliticalDivision1
							DOM GET XML ELEMENT VALUE:C731(vRef; vtState)
							APPEND TO ARRAY:C911(atState; vtState)
						Else 
							vtState:=""
						End if 
						
						vRef:=DOM Find XML element:C864(vSummaryRef; "Candidate/AddressArtifactFormat/Country")
						If (OK=1)
							DOM GET XML ELEMENT VALUE:C731(vRef; vtCountry)
							APPEND TO ARRAY:C911(atCountry; vtCountry)
						Else 
							ConsoleLog("ERROR: Candidate/AddressArtifactFormat/Country Not Found")
						End if 
						
						vRef:=DOM Find XML element:C864(vSummaryRef; "Candidate/AddressArtifactFormat/CountryCode")
						If (OK=1)
							DOM GET XML ELEMENT VALUE:C731(vRef; vtCountryCode)
							APPEND TO ARRAY:C911(atCountryCode; vtCountryCode)
						Else 
							ConsoleLog("ERROR: Candidate/AddressArtifactFormat/CountryCode Not Found")
						End if 
						
						vRef:=DOM Find XML element:C864(vSummaryRef; "Candidate/AddressArtifactFormat/PostcodePrimaryLow")
						If (OK=1)
							DOM GET XML ELEMENT VALUE:C731(vRef; vtZipLow)
							APPEND TO ARRAY:C911(atZipLow; vtZipLow)
						Else 
							ConsoleLog("ERROR: Candidate/AddressArtifactFormat/PostcodePrimaryLow Not Found")
						End if 
						
						vRef:=DOM Find XML element:C864(vSummaryRef; "Candidate/AddressArtifactFormat/PostcodePrimaryHigh")
						
						If (OK=1)
							DOM GET XML ELEMENT VALUE:C731(vRef; vtZipHigh)
							APPEND TO ARRAY:C911(atZipHigh; vtZipHigh)
						Else 
							ConsoleLog("ERROR: Candidate/AddressArtifactFormat/PostcodePrimaryHigh Not Found")
						End if 
						
						//jMessagewindow( vtCode + " - "+vtDescription+"\r"+"\r"+"Transit Days = " + vtDays)
						vText:=vText+String:C10(vi1)+". "+vtCity+" "+vtState+" "+vtCountryCode+" "+vtZipLow+vtcrlf
						
						//Next Candidate
						vSummaryRef:=DOM Get next sibling XML element:C724(vSummaryRef)
						
					End for 
					If (allowAlerts_boo)
						jMessageWindow(vText)
					End if 
					
				End if   //TransitToList/Candidate
				
			End if   ///TimeInTransitResponse/TransitToList
			
		End if   //XML_Response  This may need to go after DOM CLOSE XML ???
		
		DOM CLOSE XML:C722(Struct_Ref)
		
		//SET TEXT TO PASTEBOARD (vText)
		
	End if   // NO RESPONSE
	
	vText:="<TransitResponse>"+"\r"+"\r"+vText+"</TransitResponse>"
	
	vText1:="(?s)(<TransitResponse>.*</TransitResponse>)"
	
	If (Preg Match(vText1; [Order:3]commentProcess:12)=1)
		If (allowAlerts_boo)
			jMessageWindow("Match Found")
		End if 
		//Preg Replace(find;replace;subject)
		[Order:3]commentProcess:12:=Preg Replace(vText1; vText; [Order:3]commentProcess:12)
	Else 
		[Order:3]commentProcess:12:=[Order:3]commentProcess:12+"\r"+vText
	End if 
	
	// ### jwm ### 20170417_1458 need to update comment input field if in Input layout.
	
	// SAVE RECORD([Order])  // ### jwm ### 20170417_1456 commented out should save order through normal process
	
	//[Order]CommentProcess := [Order]CommentProcess + "\r" + "\r" + vText
	
	
Else 
	ConsoleLog("UPS TimeInTransit TallyMaster not Found")
End if 

UNLOAD RECORD:C212([TallyMaster:60])
