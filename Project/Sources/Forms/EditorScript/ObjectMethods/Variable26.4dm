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
var $pathname : Text
var $file_o : Object
$pathname:=Storage:C1525.folder.jitF+"wiki"+Folder separator:K24:12+"MarkdownSyntax1.md"
$file_o:=File:C1566($pathname)
If ($file_o.isFile())
	vTextSummary:=$file_o.getText()
Else 
	ALERT:C41("There is no 'wiki' folder in the application folder")
End if 