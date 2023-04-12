//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-13T00:00:00, 14:27:05
// ----------------------------------------------------
// Method: SMTP_Email
// Description
// Modified: 11/13/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283(<>viDeBugMode; vHere)
C_TEXT:C284($1; $2)
If (Count parameters:C259=2)
	// $2 is just a filler
	C_LONGINT:C283($viprocess)
	$viprocess:=New process:C317("SMTP_Email"; <>tcPrsMemory; "sendemail"; $1)
Else 
	If (Count parameters:C259=1)
		If ($1="[TallyMaster]Name-@")
			Execute_TallyMaster(Substring:C12($1; 20); "emailScript")
		Else 
			ExecuteText(0; $1)
		End if 
	End if 
	If (<>viDeBugMode>0)
		ConsoleLog("launch")
	End if 
	If (False:C215)
		//use this procedure to locate attachments
		vtEmailSubject:="This is the subject"
		vtEmailBody:=[UserReport:46]template:7
		vtEmailSender:="bill@wineops.com"
		vtEmailSenderID:="employeeID"
		vtEmailPath:=""
		myDocName:=UtilDocumentLocate
		vtEmailPath:=myDocName
		vtEmailReceiver:="1"+[Customer:2]fax:66+"@maxemail.com"
	End if 
	
	ARRAY TEXT:C222(aTCP; 7)
	C_TEXT:C284(vtEmailSenderOverRide_Tag; vtEmailSenderOverRide)
	C_POINTER:C301($ptFile)
	
	If (vHere=0)  //  being called from a process without coming from an input layout
		vHere:=1
		If (([UserReport:46]tableNum:3>0) & ([UserReport:46]tableNum:3<=Get last table number:C254))
			If (Records in selection:C76(Table:C252([UserReport:46]tableNum:3)->)=1)
				vHere:=2
			End if 
		End if 
	End if 
	
	$ptFile:=Table:C252([UserReport:46]tableNum:3)
	If (vHere>1)  // if the current record is not to change
		
		If (([UserReport:46]scriptExecute:4) & ([UserReport:46]scriptBegin:5#""))  // once per session
			ExecuteText(0; [UserReport:46]scriptBegin:5)
		End if 
		
		///  zzzqqq
		SMTP_EmailBuild(Table:C252([UserReport:46]tableNum:3); True:C214)
		//ExecuteText (0;[UserReport]ScriptLoop)
		
		C_LONGINT:C283($err)
		SMTP_SendMsg
		
		If (<>viDeBugMode>0)
			ConsoleLog("[UserReport]ScriptEnd_20: "+Substring:C12([UserReport:46]scriptEnd:38; 1; 20))
		End if 
		If ([UserReport:46]scriptEnd:38#"")  // once per session
			ExecuteText(0; [UserReport:46]scriptEnd:38)
		End if 
	Else 
		//TRACE
		C_TEXT:C284(vtEmailSenderOverRide; vtEmailSenderOverRide_Tag; vtEmailSenderID)
		CREATE SET:C116(Table:C252([UserReport:46]tableNum:3)->; "<>curSelSet")
		UNLOAD RECORD:C212(Table:C252([UserReport:46]tableNum:3)->)
		<>vlRecordID:=Record number:C243([UserReport:46])
		<>prcControl:=4
		<>ptCurTable:=(->[UserReport:46]tableNum:3)
		UNLOAD RECORD:C212([UserReport:46])
		<>processAlt:=New process:C317("Email_Governor"; <>tcPrsMemory; Table name:C256(->[UserReport:46]); vtEmailSenderOverRide; vtEmailSenderOverRide_Tag; vtEmailSenderID)
	End if 
	ARRAY TEXT:C222(aTCP; 0)
	UNLOAD RECORD:C212([TallyResult:73])
	vtEmailSenderOverRide:=""
	vtEmailSenderOverRide_Tag:=""
End if 
