//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-10T00:00:00, 10:28:26
// ----------------------------------------------------
// Method: Get_FileName
// Description
// Modified: 12/10/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


// ### jwm ### 20151209_1639 get path without opening the document prevents permission errors
// initialize variables
C_TEXT:C284($fileName)
$fileName:=""
ARRAY TEXT:C222($path; 0)
$fileName:=Select document:C905(""; "*"; "Select a File"; 0; $path)  // several files may be selected
If (Size of array:C274($path)>0)
	$0:=$path{1}  // get the first element of the array of selected files
Else 
	$0:=""
End if 
// clear variables
$fileName:=""
ARRAY TEXT:C222($path; 0)