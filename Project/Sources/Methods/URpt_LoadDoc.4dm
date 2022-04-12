//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-07-04T00:00:00, 18:53:53
// ----------------------------------------------------
// Method: URpt_LoadDoc
// Description
// Modified: 07/04/13
// 
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($myOK; $result)
C_TEXT:C284($vtDocName)
$vtDocName:=Select document:C905(Storage:C1525.folder.jitQRsF; "*"; "Find Report Document"; 8)
If (OK=1)
	If (Test path name:C476(document)#1)
		ALERT:C41("No document selected.")
	Else 
		C_TEXT:C284($vtDocName)
		// $vtDocName:=HFS_ShortName (document)
		// is already the shortname
		[UserReport:46]template:7:=document
		[UserReport:46]savedInternal:18:=True:C214
		If ([UserReport:46]name:2="")
			[UserReport:46]name:2:=$vtDocName
		End if 
		Case of 
			: (Position:C15(".xml"; document)>0)
				[UserReport:46]xmlText:40:=Document to text:C1236(document; "UTF-8")  // ### jwm ### 20190626_1530 added UTF-8 encoding
				C_TEXT:C284($reportXML)
				$reportXML:=[UserReport:46]xmlText:40
				[UserReport:46]creator:6:="SuperReport"
				$err:=SR_LoadReport(eSRWin; $reportXML; 1)
			: (Position:C15(".4qr"; document)>0)
				DOCUMENT TO BLOB:C525(document; [UserReport:46]reportBlob:27)
				[UserReport:46]creator:6:="QuickReport"
			Else 
				DOCUMENT TO BLOB:C525(document; [UserReport:46]reportBlob:27)
				[UserReport:46]creator:6:="Other"
				ALERT:C41("Set the type of report.")
		End case 
		SAVE RECORD:C53([UserReport:46])
	End if 
End if 
URpt_SetTypePrm
doSearch:=1
