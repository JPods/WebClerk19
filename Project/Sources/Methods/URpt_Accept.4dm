//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-09-14T00:00:00, 11:44:26
// ----------------------------------------------------
// Method: URpt_Accept
// Description
// Modified: 09/14/16
// 
// 
//
// Parameters
// ----------------------------------------------------


C_BOOLEAN:C305($confirm)
C_BLOB:C604(reportDefinitionBlob)
SET BLOB SIZE:C606(reportDefinitionBlob; 0)
C_TEXT:C284($reportXML)
C_LONGINT:C283($result)
If (([UserReport:46]tableNum:3>0) & ([UserReport:46]tableNum:3<=Get last table number:C254))
	If ([UserReport:46]IsPrimary:15)
		<>aPrimeRpts{[UserReport:46]tableNum:3}:=Record number:C243([UserReport:46])
	End if 
	If (False:C215)
		$confirm:=Old:C35([UserReport:46]IsPrimary:15)
		
		Case of 
			: ([UserReport:46]IsPrimary:15)
				<>aPrimeRpts{[UserReport:46]tableNum:3}:=Record number:C243([UserReport:46])
			: (($confirm) & (Not:C34([UserReport:46]IsPrimary:15)))
				<>aPrimeRpts{[UserReport:46]tableNum:3}:=-1
				
		End case 
	End if 
End if 


If (([UserReport:46]Creator:6="GtSR") | (([UserReport:46]Creator:6="SuperReport")))
	[UserReport:46]Creator:6:="SuperReport"
	[UserReport:46]SavedInternal:18:=True:C214
	URpt_SetTypePop
	URpt_SetTypePrm
	$result:=SR_SaveReport(eSRWin; $reportXML; 0)  // third arg means it is a report
	// TEXT TO BLOB($reportXML;reportDefinitionBlob;UTF8 text without length)
	//  [UserReport]XMLblob:=reportDefinitionBlob
	// Saving the xml text as a reference. We are using the blob storage 
	// because the program identified [UserReport]XMLText as Alpha 255
	[UserReport:46]XMLText:40:=$reportXML
	
	If (False:C215)
		SET TEXT TO PASTEBOARD:C523($reportXML)
	End if 
End if 

SAVE RECORD:C53([UserReport:46])
CLEAR VARIABLE:C89(reportDefinitionBlob)


If (False:C215)  // old procedure, keep for a few months.
	// Modified by: William James (2013-08-19T00:00:00)
	// $result:=SR Get Area (eSRWin;$vReportBlob)
	[UserReport:46]ReportBlob:27:=$vReportBlob
	
	Case of 
		: ([UserReport:46]NumLines:10=-99)
			//  $result:=SR Main Table (reportDefinitionBlob;8;0;"aPrintBodyCount")
		: ([UserReport:46]NumLines:10<0)  //allow user to override with Print file selection
		: ([UserReport:46]NumLines:10>0)
			//  $result:=SR Main Table (eSRWin;8;0;"aPrintBodyCount")
		Else 
			//  $result:=SR Main Table (eSRWin;1;[UserReport]TableNum;"")
			// Else 
			//leave as set by user
			//report pict; report on file or mechanism; File or count; Variable with count
			//$2 -- -1 sh file choice; 0 Query main file; 1, set file ($3)  cnt in var ($4);
			//2, specify iteratins in $3, $4 - ""; 4, iterate by "varName" in $4;
			//8, literate by array size in $4 ("array name")
			
	End case 
	//  $result:=SR Set Modify (eSRWin;0)
	//[UserReport]RescFork:=vpReport
	SAVE RECORD:C53([UserReport:46])
	C_LONGINT:C283($result)
	
End if 