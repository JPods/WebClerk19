Case of 
	: (Before:C29)
		C_TEXT:C284(iLoText1; iLoText2; iLoText3; iLoText4; iLoText5; iLoText6; iLoText7; iLoText8; iLoText9; iLoText10; iLoText11; iLoText12; iLoText13; iLoText14; iLoText15)
		TRACE:C157
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]Purpose:3="SOAP@"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]Name:8="SOAP_Credit")
		iLoText7:=[TallyMaster:60]Path:28
		iLoText4:=[TallyMaster:60]Build:6
		iLoText5:=[TallyMaster:60]After:7
		iLoText1:=[TallyMaster:60]Script:9
		iLoText2:=""
		iLoText3:=""
		UNLOAD RECORD:C212([TallyMaster:60])
End case 