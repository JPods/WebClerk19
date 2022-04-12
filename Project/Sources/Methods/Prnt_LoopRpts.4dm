//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/07/12, 16:57:49
// ----------------------------------------------------
// Method: Prnt_LoopRpts
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($i; $k; $err; $processNum)
$k:=Size of array:C274(aRptLines)
C_TEXT:C284(vtEmailBody; vtEmailSubject; vtEmailPath)
For ($i; 1; $k)
	C_POINTER:C301($ptTable)
	GOTO RECORD:C242([UserReport:46]; aRptRecs{aRptLines{$i}})
	If (([UserReport:46]tableNum:3>0) & ([UserReport:46]tableNum:3<=Get last table number:C254))
		$ptTable:=Table:C252([UserReport:46]tableNum:3)
		If (vHere>1)
			C_LONGINT:C283($vHereTemp)
			$vHereTemp:=vHere
			Prnt_ReportOpts(vHere)
			vHere:=$vHereTemp
		Else 
			CREATE SET:C116($ptTable->; "<>curReportSet")
			<>ptPrintTable:=Table:C252([UserReport:46]tableNum:3)
			$reportRecNum:=aRptRecs{aRptLines{$i}}
			$processNum:=New process:C317("Prs_PrintReport"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+Table name:C256(<>ptPrintTable); <>ptPrintTable; Current process:C322; $reportRecNum)
			DELAY PROCESS:C323(Current process:C322; 180)
		End if 
	End if 
End for 
//
//

