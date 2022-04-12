//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/26/09, 09:24:17
// ----------------------------------------------------
// Method: Email_Governor
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284(vtEmailSenderOverRide)
C_TEXT:C284($1; $2; $3; vtEmailSenderID)
If (Count parameters:C259>3)
	vtEmailSenderOverRide_Tag:=$2
	vtEmailSenderOverRide:=$1
	vtEmailSenderID:=$3
End if 
GOTO RECORD:C242([UserReport:46]; <>vlRecordID)
vHere:=1
If (([UserReport:46]tableNum:3>0) & ([UserReport:46]tableNum:3<=Get last table number:C254))
	If (Records in selection:C76(Table:C252([UserReport:46]tableNum:3)->)=1)
		vHere:=2
	End if 
End if 
$viProcess:=Current process:C322
SET MENU BAR:C67(1; $viProcess; *)
Process_InitLocal
vWebClerkPath:=""
<>prcControl:=0
USE SET:C118("<>curSelSet")
CLEAR SET:C117("<>curSelSet")
myOK:=1
<>vlRecordID:=-1
C_LONGINT:C283(<>vEmailPerSend; <>vEmailDelay)
If ((<>vEmailPerSend<1) | (<>vEmailPerSend>30))
	<>vEmailPerSend:=30
End if 
If ((<>vEmailDelay<20) | (<>vEmailDelay>1000))
	<>vEmailDelay:=10
End if 
If (Records in selection:C76([UserReport:46])=1)
	$ptCurTable:=Table:C252([UserReport:46]tableNum:3)
	
	// Modified by: William James (2013-11-08T00:00:00)
	
	If (([UserReport:46]scriptExecute:4) & ([UserReport:46]scriptBegin:5#""))  // once per session
		ExecuteText(0; [UserReport:46]scriptBegin:5)
	End if 
	C_TEXT:C284($theBody; vtEmailBody)
	C_TEXT:C284($theSubject; vtEmailSubject)
	C_TEXT:C284($theAttached; vtEmailPath; vtEmailOptOut)
	//
	If (vtEmailBody="")
		vtEmailBody:=[UserReport:46]template:7
	End if 
	$theBody:=vtEmailBody
	If (vtEmailSubject="")
		vtEmailSubject:=[UserReport:46]name:2
	End if 
	$theSubject:=vtEmailSubject
	$theAttached:=vtEmailPath
	$optOut:=""
	//
	$cntRec2Send:=Records in selection:C76($ptCurTable->)
	FIRST RECORD:C50($ptCurTable->)
	$doLogClose:=False:C215
	If ($cntRec2Send>0)
		C_TEXT:C284($logRec)
		C_TIME:C306($logDoc)
		//ThermoInitExit ("Emailing:  "+String($cntRec2Send);$cntRec2Send;True)
		C_LONGINT:C283($theDT)
		$theDT:=DateTime_Enter
		For ($incRec2Send; 1; $cntRec2Send)
			vtEmailBody:=$theBody
			vtEmailSubject:=$theSubject
			vtEmailPath:=$theAttached
			//Thermo_Update ($incRec2Send)
			SMTP_EmailBuild($ptCurTable)
			If ([UserReport:46]scriptLoop:34#"")
				ExecuteText(0; [UserReport:46]scriptLoop:34)
			End if 
			If (vtEmailOptOut="")
				SMTP_SendMsg($ptCurTable)  // (->aTCP{1};->aTCP{2};->aTCP{3};->aTCP{4};->aTCP{5};->aTCP{6})
			End if 
			NEXT RECORD:C51($ptCurTable->)
			$vResult:=Mod:C98($incRec2Send; <>vEmailPerSend)
			If ($vResult=0)
				BEEP:C151
				DELAY PROCESS:C323(Current process:C322; (<>vEmailDelay*60))
				BEEP:C151
				BEEP:C151
			End if 
		End for 
		
		If (([UserReport:46]scriptExecute:4) & ([UserReport:46]scriptEnd:38#""))  // once per session
			ExecuteText(0; [UserReport:46]scriptEnd:38)
		End if 
		
		
	End if 
	vText1:=""
	vText2:=""
	vText3:=""
	vText4:=""
	vText5:=""
End if 




