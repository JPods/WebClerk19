//%attributes = {}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/25/18, 00:50:45
// ----------------------------------------------------
// Method: TNSaveForWeb
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(bSaveText; bOpenText)
C_TEXT:C284(vtDraftPath)

C_TEXT:C284($theText)
[TechNote:58]bodyText:23:=TNCaptureWebArea
$theText:=[TechNote:58]bodyText:23
If ($theText#"")
	C_TEXT:C284($draftsFolder)
	$theChapterFolder:="Chap_"+String:C10([TechNote:58]chapter:14; "000")
	$draftsFolder:=<>jitHelpFolder+"technotes"+Folder separator:K24:12+$theChapterFolder+Folder separator:K24:12
	CREATE FOLDER:C475($draftsFolder; *)
	
	vtDraftPath:=$draftsFolder+String:C10([TechNote:58]chapter:14; "000")+"-"+String:C10([TechNote:58]section:15; "000")+"-"+[TechNote:58]name:2+".html"
	
	C_TEXT:C284($outputText)
	
	$outputText:=TNHTMLheaderFooter([TechNote:58]bodyText:23; "TechNoteTemplate"; "Admin"; 1; "_jit_TechNotes_Namejj")
	
	TEXT TO DOCUMENT:C1237(vtDraftPath; $outputText)
	ConsoleLog("Document created: "+vtDraftPath)
	
End if 
