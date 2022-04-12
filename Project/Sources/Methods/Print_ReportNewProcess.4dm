//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-10-22T00:00:00, 09:27:08
// ----------------------------------------------------
// Method: Print_ReportNewProcess
// Description
// Modified: 10/22/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($reportRecNum; $processNum)
If (vHere>1)
	//CREATE EMPTY SET(ptCurTable->;"<>curReportSet")
	//ADD TO SET(ptCurTable->;"<>curReportSet")
	// ### jwm ### 20140828_2023
	// ???
	COPY NAMED SELECTION:C331(ptCurTable->; "curSelect")  // save current Selection
	ONE RECORD SELECT:C189(ptCurTable->)  // get just the current Record
	COPY NAMED SELECTION:C331(ptCurTable->; "<>curReportSet")  // save the selection for printing
	USE NAMED SELECTION:C332("curSelect")  // restore the previous selection
	CLEAR NAMED SELECTION:C333("curSelect")  // clear memory
Else 
	// CREATE SET(ptCurTable->;"<>curReportSet")
	COPY NAMED SELECTION:C331(ptCurTable->; "<>curReportSet")
End if 
<>ptPrintTable:=Table:C252([UserReport:46]tableNum:3)
$reportRecNum:=Record number:C243([UserReport:46])
If ($reportRecNum>-1)
	$processNum:=New process:C317("Prs_PrintReport"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+Table name:C256(<>ptPrintTable); <>ptPrintTable; Current process:C322; $reportRecNum)
	DELAY PROCESS:C323(Current process:C322; 180)
End if 