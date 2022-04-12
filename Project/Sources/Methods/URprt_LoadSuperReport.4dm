//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-21T00:00:00, 16:36:33
// ----------------------------------------------------
// Method: URprt_LoadSuperReport
// Description
// Modified: 08/21/13
// 
// 
//
// Parameters
// ----------------------------------------------------

//   SEE 
// FixUserReportBlobs to convert from blobs to xml
C_TEXT:C284($0; $reportXML)
If ([UserReport:46]XMLText:40#"")
	$reportXML:=[UserReport:46]XMLText:40
	// ### bj ### 20190116_1907
Else 
	If (BLOB size:C605([UserReport:46]XMLblob:22)>0)
		$reportXML:=BLOB to text:C555([UserReport:46]XMLblob:22; UTF8 text without length:K22:17)
		[UserReport:46]XMLText:40:=$reportXML
		[UserReport:46]Status:33:="Blob to xml"
		SAVE RECORD:C53([UserReport:46])
		FLUSH CACHE:C297
		// Ref: URpt_Accept
		// Using the XMLblob but convert to [UserReport]XMLText in 2017
	Else 
		C_TEXT:C284($reportXML)
		//If ((Picture size([UserReport]RescFork)>0) & (BLOB size([UserReport]ReportBlob)=0))
		// if there is not a ReportBlob, else skip
		//[UserReport]ReportBlob:=SR Report To BLOB ([UserReport]RescFork)
		//End if 
		If (BLOB size:C605([UserReport:46]ReportBlob:27)>0)
			$result:=SR_ConvertReportToXML([UserReport:46]ReportBlob:27; $reportXML; [UserReport:46]Name:2)
			[UserReport:46]XMLText:40:=$reportXML
			[UserReport:46]Status:33:="Blob to xml"
			SAVE RECORD:C53([UserReport:46])
			FLUSH CACHE:C297
		End if 
	End if 
End if 
$0:=$reportXML