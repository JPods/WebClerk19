//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/17/15, 13:17:01
// ----------------------------------------------------
// Method: HFS_CatToArray
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20150917_1048 absolute recursive path

If (False:C215)
	//02/10/03.prf
	//removed plugin FilePack
	TCStrong_prf_v144_FilePack
End if 

C_LONGINT:C283($0; $options)
C_TEXT:C284($1; $pathname; $2; $arrayname)
$pathname:=$1
$arrayname:=$2
If (Count parameters:C259>2)
	$options:=$3
Else 
	$options:=8  // ignore invisibles 
	// + 4    // Posix format pathnames
	// +2 // absolute pathnames
	// + 1    // all files and subfolders
End if 


C_POINTER:C301($arrayPtr)
$arrayPtr:=Get pointer:C304($arrayname)
DOCUMENT LIST:C474($pathname; $arrayPtr->; $options)  // ### jwm ### 20151015_0006 added parameter to pass options
//DOCUMENT LIST($pathname;$arrayPtr->;Absolute path+Ignore invisible+Recursive parsing)  // ### jwm ### 20150917_1048 absolute recursive path
$0:=0


