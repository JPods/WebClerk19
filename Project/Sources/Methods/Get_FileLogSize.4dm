//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-12-06T00:00:00, 14:48:39
// ----------------------------------------------------
// Method: Get_FileLogSize
// Description
// Modified: 12/06/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($0; <>skipDocumentSize)
C_TEXT:C284($1; $document)
MESSAGES OFF:C175

$document:=$1
// jMessageWindow ($document;2)
// ????? FixThis  Error on PC
If (<>skipDocumentSize=1)
	// made a mistake thinking this was necessary because 
	// I was using the variable "document" but it was empty
	// this alternative is no longer needed. Leaving it just cause
	$0:=800000
Else 
	If (Test path name:C476($document)=1)
		$0:=Get document size:C479($document)
	Else 
		$0:=800000
	End if 
End if 