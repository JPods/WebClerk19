
XML_Response:=[SyncRelation:103]Comment:29

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
		
		//ALERT( vtCode + " - "+vtDescription+<>vCR+<>vCR+"Transit Days = " + vtDays)
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
End if 