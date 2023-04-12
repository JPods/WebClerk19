//%attributes = {}

// Modified by: James Prince (2022-05-06T05:00:00Z)
// Method: FileSelect
// https://discuss.4d.com/t/4d-file-and-4d-folder-falls-short-of-being-complete-what-is-best-practice-for-integrating-with-open-document/22819/25
// Description 
// Parameters
// ----------------------------------------------------
// HOWTO: Open a file object


#DECLARE($fileType : Text)->$file : 4D:C1709.File
$fileType:=Choose:C955(Count parameters:C259>=1; $fileType; "*")

var $docRef
$docRef:=Open document:C264(""; $fileType; Get pathname:K24:6)

If (OK=1)
	$file:=File:C1566(Document; fk platform path:K87:2)
	CLOSE DOCUMENT:C267($docRef)
Else 
	$file:=Null:C1517
End if 