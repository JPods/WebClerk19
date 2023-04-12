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



// HOWTO:FileObject

var $file_o : Object
C_TEXT:C284($pathname)
$pathname:=Storage:C1525.folder.jitF+"wiki"+Folder separator:K24:12+"MarkdownSyntax1.md"
$file_o:=File:C1566($pathname)
If ($file_o.isFile())
	vTextSummary:=$file_o.getText()
	//C_TIME($myDoc)
	//$myDoc:=Open document($pathname)
	//RECEIVE PACKET($myDoc; vTextSummary; 10000000)
	//CLOSE DOCUMENT($myDoc)
Else 
	ALERT:C41("There is no 'wiki' folder in the application folder")
End if 