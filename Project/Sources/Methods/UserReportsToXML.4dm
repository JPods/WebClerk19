//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/21/20, 14:33:38
// ----------------------------------------------------
// Method: UserReportsToXML
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284(reportXML)
C_LONGINT:C283(viXMLText; viXMLBlob; viReportBlob; viResource)
viXMLText:=Length:C16([UserReport:46]xmlText:40)
viXMLBlob:=BLOB size:C605([UserReport:46]xmlblob:22)
viReportBlob:=BLOB size:C605([UserReport:46]reportBlob:27)
//viResource:=Picture size([UserReport]RescFork)
C_LONGINT:C283(viUseThis)
viUseThis:=Num:C11(Request:C163("Sizes 1 XMLText: "+String:C10(viXMLText)+"; 2 XMLblob: "+String:C10(viXMLBlob)+"; 3 ReportBlob: "+String:C10(viReportBlob)+"; 4 RescFork: "+String:C10(viResource); "0"))
// clear any data from 

Case of 
	: (viUseThis=0)
		// do nothing
	: (viUseThis=1)  // XMLText
		reportXML:=[UserReport:46]xmlText:40
	: (viUseThis=2)  //  XMLblob
		vi5:=SR_ConvertReportToXML([UserReport:46]xmlblob:22; reportXML; [UserReport:46]name:2)
		[UserReport:46]xmlText:40:=reportXML
		[UserReport:46]status:33:="XMLBlob to xml"
		
	: (viUseThis=3)  //  ReportBlob
		vi5:=SR_ConvertReportToXML([UserReport:46]reportBlob:27; reportXML; [UserReport:46]name:2)
		[UserReport:46]xmlText:40:=reportXML
		[UserReport:46]status:33:="ReportBlob to xml"
		SAVE RECORD:C53([UserReport:46])
		TEXT TO DOCUMENT:C1237(Storage:C1525.folder.jitF+[UserReport:46]name:2+".xml"; reportXML)
		
	: (viUseThis=4)  //  RescFork
		//[UserReport]XMLblob:=SR Report To BLOB ([UserReport]RescFork)
		vi5:=SR_ConvertReportToXML([UserReport:46]xmlblob:22; reportXML; [UserReport:46]name:2)
		[UserReport:46]xmlText:40:=reportXML
		[UserReport:46]status:33:="RescFork to xml"
End case 
If ((viUseThis>0) & (viUseThis<5))
	vi5:=SR_LoadReport(eSRWin; reportXML; 1)  // third arg means it is a report
	SRE_VarByFile(eSRWin)
End if 
