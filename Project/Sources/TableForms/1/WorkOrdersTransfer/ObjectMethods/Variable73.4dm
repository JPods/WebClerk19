If (Self:C308->>0)
	// ALL RECORDS([DivisionDefault])
	// DB_ShowCurrentSelection (->[DivisionDefault])
	// Else 
	jPopUpArray(Self:C308; ->iLo80String2)
	//
	// If (iLoText2="Receive")
	// DSSetMachineID (iLo80String2)
	// End if 
End if 
//QUERY([DefaultSetup];[DefaultSetup]VariableName="siteID";*)
//QUERY([DefaultSetup];&[DefaultSetup]Value=iLo80String2)