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
	If (([UserReport:46]tableNum:3>0) & ([UserReport:46]tableNum:3<=Get last table number:C254))
		If (Records in selection:C76(Table:C252([UserReport:46]tableNum:3)->)=1)
			vHere:=2
		End if 
	End if 
End if 

Case of 
	: (([UserReport:46]creator:6="Mail") | ([UserReport:46]creator:6="Email"))  // ### jwm ### 20190118_1441
		//ALERT("Launching Mail Posting into its own process")
		//ExecuteText (0;[UserReport]ScriptLoop)    //executed in SMTP_Email
		TRACE:C157
		If (False:C215)  // ptCurTable=(->[CallReport]))
			// ### bj ### 20191204_2332   testing only remove in live
			// good for testing email in second process
			C_TEXT:C284($vtScript)
			$vtScript:="QUERY([Customer];[Customer]customerID=\""+[CallReport:34]customerID:1+"\")"+"\r"
			$vtScript:=$vtScript+"QUERY([UserReport];[UserReport]Name=\""+[UserReport:46]name:2+"\")"+"\r"
			$vtScript:=$vtScript+"QUERY([ItemSerial];[ItemSerial]UniqueID=1311)"+"\r"
			$vtScript:=$vtScript+"vHere:="+String:C10(vHere)+"\r"
			SMTP_Email($vtScript; "NewProcess")
		Else 
			SMTP_Email  //
		End if 
	: (([UserReport:46]creator:6="GTsR") | ([UserReport:46]creator:6="SuperReport"))  // ### jwm ### 20190118_1421
		SRE_Print
		
	: (([UserReport:46]creator:6="FRmk") | ([UserReport:46]creator:6="EDIx") | ([UserReport:46]creator:6="Execute") | ([UserReport:46]creator:6="Script"))
		If ([UserReport:46]scriptBegin:5#"")
			ExecuteText(0; [UserReport:46]scriptBegin:5)
			vtSearch:=[UserReport:46]scriptBegin:5
			$error:=0
		Else 
			C_TIME:C306($FileID)
			C_LONGINT:C283($error)
			$FileID:=Open document:C264([UserReport:46]template:7)
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
		If (([UserReport:46]scriptExecute:4) & ([UserReport:46]scriptBegin:5#""))
			jsetDefaultFile(Table:C252([UserReport:46]tableNum:3))  //      ptCurFile:=File([UserReport]ReportonFile)
			ExecuteText(0; [UserReport:46]scriptBegin:5)
		End if 
		Case of 
			: ([UserReport:46]creator:6="Brow@")  // ### jwm ### 20190118_1442
				LWCBrowserDisplay([UserReport:46]template:7)
			: ([UserReport:46]creator:6="Clip@")  // ### jwm ### 20190118_1442
				If (Position:C15(Folder separator:K24:12; [UserReport:46]template:7)>0)
					$thePath:=[UserReport:46]template:7
				Else 
					$thePath:=Storage:C1525.folder.jitQRsF+[UserReport:46]template:7
				End if 
				If (HFS_Exists($thePath)=1)
					Txt_4D2Doc($thePath; ""; False:C215; True:C214; True:C214)
					theText:=""
					ALERT:C41("Document of Clipboard")
				Else 
					ALERT:C41("Document path incorrect: "+"\r"+$thePath)
				End if 
			: (([UserReport:46]printFax:19) & (<>allowFAX))
				Case of 
					: (([UserReport:46]creator:6="GTsR") | ([UserReport:46]creator:6="SuperReport"))  // ### jwm ### 20190118_1421
						//FAX_Print(Table([UserReport]tableNum); "SRE")
					: (([UserReport:46]creator:6="4D@") | ([UserReport:46]creator:6="JITA") | ([UserReport:46]creator:6="QuickReport"))  // ### jwm ### 20190118_1421
						//FAX_Print(Table([UserReport]tableNum); "QRpt")
					: (([UserReport:46]creator:6="4com") | ([UserReport:46]creator:6="Fax@"))
						//FAX_Print(Table([UserReport]tableNum); "Doc")
					: ((Records in selection:C76([UserReport:46])=0) & (Records in selection:C76([Letter:20])=1))
						ALERT:C41("Do letters.")
					Else 
						ALERT:C41("Format "+[UserReport:46]creator:6+" not currently supported.")
				End case 
				
			: (([UserReport:46]creator:6="4D@") | ([UserReport:46]creator:6="JITA") | ([UserReport:46]creator:6="QuickReport"))  // ### jwm ### 20190118_1421
				Prnt_QR
				
			: ([UserReport:46]creator:6="JITM")
				jAlertMessage(9201)
			: (([UserReport:46]creator:6="Text-Out") | ([UserReport:46]creator:6="TxtO") | ([UserReport:46]creator:6="Text@"))
				TIOO_ReadFile(->[UserReport:46]template:7; <>cptNilPoint)
			: (([UserReport:46]creator:6="EDIO") | ([UserReport:46]creator:6="EDI-Out") | ([UserReport:46]creator:6="EDI Out"))
				EDI_OutMakeFile([UserReport:46]tableNum:3; [UserReport:46]template:7)
				
			: (([UserReport:46]creator:6="EDI In") | ([UserReport:46]creator:6="EDI-In") | ([UserReport:46]creator:6="EDII"))
				EDI_InTestFiles
			Else 
				
				ConsoleMessage("Undefined print option: "+[UserReport:46]creator:6)
				
		End case 
		
		If (([UserReport:46]scriptExecute:4) & ([UserReport:46]scriptEnd:38#""))
			ExecuteText(0; [UserReport:46]scriptEnd:38)
		End if 
End case 
If (vhere<2)
	Wcc_ReduceSelection(1)
End if 
