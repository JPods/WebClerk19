//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-09-22T00:00:00, 16:27:29
// ----------------------------------------------------
// Method: DocumentToText
// Description
// Modified: 09/22/16
// 
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160929_1315 added $text variable

C_TEXT:C284($0; $1; $text)
C_TIME:C306($myDoc)
$myDoc:=Open document:C264($1; "*"; Read mode:K24:5)  // 
$0:=""
If (OK=1)
	CLOSE DOCUMENT:C267($myDoc)
	$Text:=Document to text:C1236(document)
	$0:=$text
End if 