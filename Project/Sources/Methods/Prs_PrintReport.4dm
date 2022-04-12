//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/07/12, 15:55:44
// ----------------------------------------------------
// Method: Prs_PrintReport
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20140827_1536 
// Named selections preserve in memory the order of the selection and the current record of the selection.

Process_InitLocal
// Modified by: William James (2013-10-22T00:00:00)
//  ptCurTable:=(->[UserReport])
C_POINTER:C301($1)
C_LONGINT:C283($2; seniorProcess; $3; $reportRecordNum)
seniorProcess:=0
vWindowTitle:=""  //used in OLO_HereAndMenu to name window title
If (Count parameters:C259>0)
	<>ptCurTable:=$1
	If (Count parameters:C259>1)
		seniorProcess:=$2
		If (Count parameters:C259>2)
			$reportRecordNum:=$3
		End if 
	End if 
End if 

//USE SET("<>curReportSet")
//CLEAR SET("<>curReportSet")

// ### jwm ### 20140827_1536 
// Named selections preserve in memory the order of the selection and the current record of the selection.
// ???
USE NAMED SELECTION:C332("<>curReportSet")
CLEAR NAMED SELECTION:C333("<>curReportSet")
POST OUTSIDE CALL:C329(<>theProcessList)

GOTO RECORD:C242([UserReport:46]; $reportRecordNum)  //
//<>ptPrintTable:=Table([UserReport]TableNum)
Prnt_ReportOpts

