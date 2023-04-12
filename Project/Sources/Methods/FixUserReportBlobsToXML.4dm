//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/17/19, 02:14:11
// ----------------------------------------------------
// Method: FixUserReportBlobsToXML
// Description
// 
//
// Parameters
// ----------------------------------------------------


// ### bj ### 20190207_2132
If (False:C215)  // script version
	LOAD RECORD:C52([UserReport:46])
	vi8:=BLOB size:C605([UserReport:46]xmlblob:22)
	vi9:=BLOB size:C605([UserReport:46]reportBlob:27)
	vi10:=0
	vText7:="XMLblob: "+String:C10(vi8)+"\r"+"ReportBlob: "+String:C10(vi9)
	ConsoleLog(vText7)
	ALERT:C41(vText7)
	If (vi8>1000)
		CONFIRM:C162("From XMLblob to XMLText, size: "+String:C10(vi8))
		If (OK=1)
			vi1:=SR_ConvertReportToXML([UserReport:46]xmlblob:22; vText11; [UserReport:46]name:2)
			[UserReport:46]xmlText:40:=vText11
			[UserReport:46]status:33:="Blob to xml"
			SAVE RECORD:C53([UserReport:46])
			TEXT TO DOCUMENT:C1237(Storage:C1525.folder.jitF+[UserReport:46]name:2+".xml"; vText11)
			vi10:=1
		Else 
			vi10:=0
		End if 
	End if 
	If (vi10=0)
		vi8:=BLOB size:C605([UserReport:46]reportBlob:27)
		If (vi8>1000)
			CONFIRM:C162("From ReportBlob to XMLText, size: "+String:C10(vi8))
			If (OK=1)
				vi1:=SR_ConvertReportToXML([UserReport:46]reportBlob:27; vText11; [UserReport:46]name:2)
				[UserReport:46]xmlText:40:=vText11
				[UserReport:46]status:33:="Blob to xml"
				SAVE RECORD:C53([UserReport:46])
				TEXT TO DOCUMENT:C1237(Storage:C1525.folder.jitF+[UserReport:46]name:2+".xml"; vText11)
			End if 
		End if 
	End if 
End if 




CONFIRM:C162("Fix SuperReports from blobs to xml."+"\r"+"Multiple runs may be necessary to clear all.")
If (OK=1)
	
	QUERY:C277([UserReport:46]; [UserReport:46]name:2="Credit Memo@")
	
	CREATE EMPTY SET:C140([UserReport:46]; "current")
	QUERY:C277([UserReport:46]; [UserReport:46]creator:6="GTSR"; *)
	QUERY:C277([UserReport:46];  | ; [UserReport:46]creator:6="SuperReport")
	ORDER BY:C49([UserReport:46]; [UserReport:46]name:2)
	C_LONGINT:C283($incRec; $cntRec)
	$cntRec:=Records in selection:C76([UserReport:46])
	FIRST RECORD:C50([UserReport:46])
	C_TEXT:C284($vtXML)
	For ($incRec; 1; $cntRec)
		// $vtXML:=URprt_LoadSuperReport 
		C_LONGINT:C283($viXMLText; $viXMLBlob; $viReportBlob; $viResource)
		$viXMLText:=Length:C16([UserReport:46]xmlText:40)
		$viXMLBlob:=BLOB size:C605([UserReport:46]xmlblob:22)
		$viReportBlob:=BLOB size:C605([UserReport:46]reportBlob:27)
		//$viResource:=Picture size([UserReport]RescFork)
		
		// clear any data from 
		//If ((Picture size([UserReport]RescFork)>0) & (BLOB size([UserReport]ReportBlob)=0))
		// if there is not a ReportBlob, else skip
		//[UserReport]ReportBlob:=SR Report To BLOB ([UserReport]RescFork)
		
		//End if 
		
		If (False:C215)  //Picture size([UserReport]RescFork)>0)
			// this is used no where and should be eliminated
			// it has not been used since version 13
			//C_PICTURE($emptyPicture)
			//[UserReport]RescFork:=$emptyPicture
			SAVE RECORD:C53([UserReport:46])
			FLUSH CACHE:C297
			ADD TO SET:C119([UserReport:46]; "current")
		End if 
		
		If ((Length:C16([UserReport:46]xmlText:40)<1000) & (BLOB size:C605([UserReport:46]reportBlob:27)>2000))
			$result:=SR_ConvertReportToXML([UserReport:46]reportBlob:27; $reportXML; [UserReport:46]name:2)
			[UserReport:46]xmlText:40:=$reportXML
			[UserReport:46]status:33:="Blob to xml"
			SAVE RECORD:C53([UserReport:46])
			TEXT TO DOCUMENT:C1237(Storage:C1525.folder.jitF+[UserReport:46]name:2+".xml"; $reportXML)
			
			
			FLUSH CACHE:C297
			ADD TO SET:C119([UserReport:46]; "current")
			// TEXT TO DOCUMENT(Storage.folder.jitExports+"PO13.xml";[UserReport]XMLText)
			// ### bj ### 20190205_1733  keep the blob
			If (False:C215)
				If (BLOB size:C605([UserReport:46]xmlblob:22)>0)
					SET BLOB SIZE:C606([UserReport:46]xmlblob:22; 0)
					ADD TO SET:C119([UserReport:46]; "current")
					SAVE RECORD:C53([UserReport:46])
					FLUSH CACHE:C297
				End if 
			End if 
		End if 
		If (False:C215)
			If (BLOB size:C605([UserReport:46]reportBlob:27)>0)
				SET BLOB SIZE:C606([UserReport:46]reportBlob:27; 0)
				SAVE RECORD:C53([UserReport:46])
				FLUSH CACHE:C297
				ADD TO SET:C119([UserReport:46]; "current")
			End if 
		End if 
		FLUSH CACHE:C297
		ADD TO SET:C119([UserReport:46]; "current")
		// Ref: URpt_Accept
		// Using the XMLblob but convert to [UserReport]XMLText in 2017
		NEXT RECORD:C51([UserReport:46])
	End for 
	REDUCE SELECTION:C351([UserReport:46]; 0)
	USE SET:C118("current")
	CLEAR SET:C117("current")
	// ProcessTableOpen (Table(->[UserReport]))
	
End if 

