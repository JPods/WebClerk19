//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-07-12T00:00:00, 15:01:47
// ----------------------------------------------------
// Method: SuperReportsConvert
// Description
// Modified: 07/12/13
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($path)
C_LONGINT:C283($tempeSRWin)

QUERY:C277([UserReport:46]; [UserReport:46]creator:6="GTsr")
vi2:=Records in selection:C76([UserReport:46])
FIRST RECORD:C50([UserReport:46])

If (Test path name:C476(Storage:C1525.folder.jitF+"zzzReports")#0)
	CREATE FOLDER:C475(Storage:C1525.folder.jitF+"zzzReports")
End if 

For (vi1; 1; vi2)
	If ([UserReport:46]creator:6="GTsr")
		
		$path:=Storage:C1525.folder.jitF+String:C10([UserReport:46]idNum:17)+String:C10(DateTime_Enter)+".srp"
		$tempeSRWin:=SR New Offscreen Area
		//  vi8:=SR Set Area ($tempeSRWin;[UserReport]RescFork)
		vi8:=SR Save Report($tempeSRWin; $path)
		DOCUMENT TO BLOB:C525(vText1; [UserReport:46]reportBlob:27)
		SR DELETE OFFSCREEN AREA($tempeSRWin)
		SAVE RECORD:C53([UserReport:46])
		DELETE DOCUMENT:C159($path)
	End if 
	NEXT RECORD:C51([UserReport:46])
End for 
UNLOAD RECORD:C212([UserReport:46])

// SR_ConvertReportToXML 

//  OBJECT Get vertical alignment
