// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-07-20T00:00:00, 00:53:59
// ----------------------------------------------------
// Method: [Control].SummaryText.Variable26
// Description
// Modified: 07/20/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------




C_LONGINT:C283($result)
C_TEXT:C284($pathname)
$pathname:=<>JITF+"wiki"+<>FOLDERSEPARATOR+"MarkdownSyntax1.md"
$result:=Test path name:C476($pathname)
If ($result#1)
	ALERT:C41("There is no 'wiki' folder in the application folder")
Else 
	C_TIME:C306($myDoc)
	$myDoc:=Open document:C264($pathname)
	RECEIVE PACKET:C104($myDoc; vTextSummary; 10000000)
	CLOSE DOCUMENT:C267($myDoc)
End if 