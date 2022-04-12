//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: AuthWebService
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
//
C_TEXT:C284($theTallyMasterName)
If (Count parameters:C259=1)
	$theTallyMasterName:=$1
	//
	If (<>vSoapTrack=3)
		CREATE RECORD:C68([EventLog:75])
		[EventLog:75]dtEvent:1:=DateTime_Enter
		
		[EventLog:75]groupid:3:="WebTaxTest"  ///  -4
	End if 
	C_TEXT:C284(pvTaxRate; pvTaxStatus)
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="SOAP@"; *)
	QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8=$theTallyMasterName)
	If (Records in selection:C76([TallyMaster:60])=1)
		C_TEXT:C284($text2Convert; $scriptBefore; $scriptAfter)
		vText4:=[TallyMaster:60]script:9
		$thePath:=[TallyMaster:60]path:28
		$scriptBefore:=[TallyMaster:60]build:6
		$scriptAfter:=[TallyMaster:60]after:7
		$headerInfo:=[TallyMaster:60]template:29
		UNLOAD RECORD:C212([TallyMaster:60])
		If ($scriptBefore#"")
			ExecuteText(0; $scriptBefore)
		End if 
		//
		If (<>vSoapTrack=3)
			EventLogsMessage(UtilFillMarkerLine("Path")+$thePath+UtilFillMarkerLine("Start Input")+vText4+UtilFillMarkerLine("End Procedure")+theText)
		End if 
		
		C_LONGINT:C283($err)
		vText4:=TagsToText(vText4)
		If (<>vSoapTrack=3)
			EventLogsMessage(UtilFillMarkerLine("Converted Input")+vText4)
		End if 
		SoapProcess($thePath; vText4; $headerInfo)
		$Linecomment:="no connection"
		If ($scriptAfter#"")
			ExecuteText(0; $scriptAfter)
			If (<>vSoapTrack=3)
				EventLogsMessage(UtilFillMarkerLine("After End Script")+vText4)
			End if 
		End if 
		XMLArrayManagement(0)
	End if 
	C_TEXT:C284($Linecomment)
	UNLOAD RECORD:C212([TallyMaster:60])
	vText4:=""
	theText:=""
	If (<>vSoapTrack=3)
		If ([EventLog:75]idNum:5#0)
			SAVE RECORD:C53([EventLog:75])
		End if 
		ProcessTableOpen(Table:C252(->[EventLog:75]))
	End if 
Else 
	BEEP:C151
	BEEP:C151
End if 