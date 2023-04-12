//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-10-29T00:00:00, 07:56:00
// ----------------------------------------------------
// Method: Prnt_ReportOpts
// Description
// Modified: 10/29/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305(noDialog)
C_LONGINT:C283($1; $vHereTemp)
If (Count parameters:C259>0)
	$vHereTemp:=$1
	vHere:=$vHereTemp
Else 
	vHere:=1
	If (([Report:46]tableNum:3>0) & ([Report:46]tableNum:3<=Get last table number:C254))
		If (Records in selection:C76(Table:C252([Report:46]tableNum:3)->)=1)
			vHere:=2
		End if 
	End if 
End if 

Case of 
	: (([Report:46]creator:6="Mail") | ([Report:46]creator:6="Email"))  // ### jwm ### 20190118_1441
		//ALERT("Launching Mail Posting into its own process")
		//ExecuteText (0;[UserReport]ScriptLoop)    //executed in SMTP_Email
		TRACE:C157
		If (False:C215)  // ptCurTable=(->[CallReport]))
			// ### bj ### 20191204_2332   testing only remove in live
			// good for testing email in second process
			C_TEXT:C284($vtScript)
			$vtScript:="QUERY([Customer];[Customer]customerID=\""+[Call:34]customerID:1+"\")"+"\r"
			$vtScript:=$vtScript+"QUERY([UserReport];[UserReport]Name=\""+[Report:46]name:2+"\")"+"\r"
			$vtScript:=$vtScript+"QUERY([ItemSerial];[ItemSerial]UniqueID=1311)"+"\r"
			$vtScript:=$vtScript+"vHere:="+String:C10(vHere)+"\r"
			SMTP_Email($vtScript; "NewProcess")
		Else 
			SMTP_Email  //
		End if 
	: (([Report:46]creator:6="GTsR") | ([Report:46]creator:6="SuperReport"))  // ### jwm ### 20190118_1421
		SRE_Print
		
	: (([Report:46]creator:6="FRmk") | ([Report:46]creator:6="EDIx") | ([Report:46]creator:6="Execute") | ([Report:46]creator:6="Script"))
		If ([Report:46]scriptBegin:5#"")
			ExecuteText(0; [Report:46]scriptBegin:5)
			vtSearch:=[Report:46]scriptBegin:5
			$error:=0
		Else 
			C_TIME:C306($FileID)
			C_LONGINT:C283($error)
			$FileID:=Open document:C264([Report:46]template:7)
			C_LONGINT:C283($error)
			If (OK=1)
				C_TEXT:C284($FRText)
				RECEIVE PACKET:C104($FileID; $FRText)  //get the whole doc
				CLOSE DOCUMENT:C267($FileID)
				$error:=0
				ExecuteText(0; $FRText)
			Else 
				ALERT:C41("Document failed to Open. Error = "+String:C10(Error))
				$error:=-1
			End if 
		End if 
		
	Else   // actions above have the begin and end scripts integrated into them
		If (([Report:46]scriptExecute:4) & ([Report:46]scriptBegin:5#""))
			jsetDefaultFile(Table:C252([Report:46]tableNum:3))  //      ptCurFile:=File([UserReport]ReportonFile)
			ExecuteText(0; [Report:46]scriptBegin:5)
		End if 
		Case of 
			: ([Report:46]creator:6="Brow@")  // ### jwm ### 20190118_1442
				LWCBrowserDisplay([Report:46]template:7)
			: ([Report:46]creator:6="Clip@")  // ### jwm ### 20190118_1442
				If (Position:C15(Folder separator:K24:12; [Report:46]template:7)>0)
					$thePath:=[Report:46]template:7
				Else 
					$thePath:=Storage:C1525.folder.jitQRsF+[Report:46]template:7
				End if 
				If (HFS_Exists($thePath)=1)
					Txt_4D2Doc($thePath; ""; False:C215; True:C214; True:C214)
					theText:=""
					ALERT:C41("Document of Clipboard")
				Else 
					ALERT:C41("Document path incorrect: "+"\r"+$thePath)
				End if 
			: (([Report:46]printFax:19) & (<>allowFAX))
				Case of 
					: (([Report:46]creator:6="GTsR") | ([Report:46]creator:6="SuperReport"))  // ### jwm ### 20190118_1421
						//FAX_Print(Table([UserReport]tableNum); "SRE")
					: (([Report:46]creator:6="4D@") | ([Report:46]creator:6="JITA") | ([Report:46]creator:6="QuickReport"))  // ### jwm ### 20190118_1421
						//FAX_Print(Table([UserReport]tableNum); "QRpt")
					: (([Report:46]creator:6="4com") | ([Report:46]creator:6="Fax@"))
						//FAX_Print(Table([UserReport]tableNum); "Doc")
					: ((Records in selection:C76([Report:46])=0) & (Records in selection:C76([Letter:20])=1))
						ALERT:C41("Do letters.")
					Else 
						ALERT:C41("Format "+[Report:46]creator:6+" not currently supported.")
				End case 
				
			: (([Report:46]creator:6="4D@") | ([Report:46]creator:6="JITA") | ([Report:46]creator:6="QuickReport"))  // ### jwm ### 20190118_1421
				Prnt_QR
				
			: ([Report:46]creator:6="JITM")
				jAlertMessage(9201)
			: (([Report:46]creator:6="Text-Out") | ([Report:46]creator:6="TxtO") | ([Report:46]creator:6="Text@"))
				TIOO_ReadFile(->[Report:46]template:7; <>cptNilPoint)
			: (([Report:46]creator:6="EDIO") | ([Report:46]creator:6="EDI-Out") | ([Report:46]creator:6="EDI Out"))
				//EDI_OutMakeFile([Report]tableNum; [Report]template)
				ALERT:C41("suspended feature")
				
			: (([Report:46]creator:6="EDI In") | ([Report:46]creator:6="EDI-In") | ([Report:46]creator:6="EDII"))
				//EDI_InTestFiles
				ALERT:C41("suspended feature")
			Else 
				
				ConsoleLog("Undefined print option: "+[Report:46]creator:6)
				
		End case 
		
		If (([Report:46]scriptExecute:4) & ([Report:46]scriptEnd:38#""))
			ExecuteText(0; [Report:46]scriptEnd:38)
		End if 
End case 
If (vhere<2)
	Wcc_ReduceSelection(1)
End if 
