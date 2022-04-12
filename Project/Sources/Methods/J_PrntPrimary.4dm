//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 11/19/13, 10:27:50
// ----------------------------------------------------
// Method: J_PrntPrimary
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_BOOLEAN:C305($doReport; doCurFile)
MESSAGES OFF:C175
KeyModifierCurrent
C_LONGINT:C283(<>Intel; $curRecordNum)
<>Intel:=0
$doPrimary:=True:C214
$curRecordNum:=-1
If (vHere>1)
	$doPrimary:=(RecordAcceptTest(booAccept; ptCurTable))  //jStartup0  
	If ($doPrimary)
		AcceptPrint
	End if 
	$curRecordNum:=Record number:C243(ptCurTable->)
End if 
If ($doPrimary)
	Case of 
		: (ptCurTable=(->[Invoice:26]))
			If ([Invoice:26]primaryForm:89#"")
				QUERY:C277([UserReport:46]; [UserReport:46]name:2=[Invoice:26]primaryForm:89)
				If (Records in selection:C76([UserReport:46])>0)
					FIRST RECORD:C50([UserReport:46])
					$doPrimary:=False:C215
				End if 
			End if 
		: (ptCurTable=(->[Order:3]))
			If ([Order:3]primaryForm:111#"")
				QUERY:C277([UserReport:46]; [UserReport:46]name:2=[Order:3]primaryForm:111)
				If (Records in selection:C76([UserReport:46])>0)
					FIRST RECORD:C50([UserReport:46])
					$doPrimary:=False:C215
				End if 
			End if 
		: (ptCurTable=(->[Proposal:42]))
			If ([Proposal:42]primaryForm:80#"")
				QUERY:C277([UserReport:46]; [UserReport:46]name:2=[Proposal:42]primaryForm:80)
				If (Records in selection:C76([UserReport:46])>0)
					FIRST RECORD:C50([UserReport:46])
					$doPrimary:=False:C215
				End if 
			End if 
		: (ptCurTable=(->[PO:39]))
			If ([PO:39]primaryForm:76#"")
				QUERY:C277([UserReport:46]; [UserReport:46]name:2=[PO:39]primaryForm:76)
				If (Records in selection:C76([UserReport:46])>0)
					FIRST RECORD:C50([UserReport:46])
					$doPrimary:=False:C215
				End if 
			End if 
	End case 
End if 

Case of 
	: ($doPrimary=False:C215)  // if the [Record] has a value that was found, use that [UserReport]
		// [UserReport] already selected
	: (<>aPrimeRpts{Table:C252(ptCurTable)}<0)  //  if a value was not found or there was no value and there was no primary report, protest 
		If (allowAlerts_boo)
			ALERT:C41("No Primary Report defined")
		End if 
	Else   // ($doPrimary)
		GOTO RECORD:C242([UserReport:46]; <>aPrimeRpts{Table:C252(ptCurTable)})
End case 

//  ????  check on authority level

If (Record number:C243([UserReport:46])>-1)  // execute if possible
	If (vHere>1)
		P_vHereBegin
		C_LONGINT:C283($vHereTemp)
		$vHereTemp:=vHere
		Prnt_ReportOpts(vHere)
		vHere:=$vHereTemp
		P_vHereEnd
	Else 
		C_LONGINT:C283($reportRecNum; $processNum)
		If (([UserReport:46]tableNum:3>0) & ([UserReport:46]tableNum:3<=Get last table number:C254))
			//  <>ptPrintTable:=ptCurTable  // should always match
			<>ptPrintTable:=Table:C252([UserReport:46]tableNum:3)
			// CREATE SET(<>ptPrintTable->;"<>curReportSet")
			// ### jwm ### 20140828_0924
			// ???
			COPY NAMED SELECTION:C331(<>ptPrintTable->; "<>curReportSet")
			$reportRecNum:=Record number:C243([UserReport:46])
			$processNum:=New process:C317("Prs_PrintReport"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+Table name:C256(<>ptPrintTable); <>ptPrintTable; Current process:C322; $reportRecNum)
			DELAY PROCESS:C323(Current process:C322; 180)
		End if 
	End if 
End if 