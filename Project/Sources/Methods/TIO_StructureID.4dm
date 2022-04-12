//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/21/16, 11:27:13
// ----------------------------------------------------
// Method: TIO_StructureID
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160921_1114 protect against deleted tables

C_LONGINT:C283($i; $k)
$k:=Get last table number:C254
ARRAY TEXT:C222(<>aTIOTableNames; $k)  //create array of files
ARRAY LONGINT:C221(<>aTIOTableNums; $k)
For ($i; 1; $k)  //Loop for files  
	// ### jwm ### 20160921_1114 protect against deleted tables
	If (Is table number valid:C999($i))
		<>aTIOTableNames{$i}:=Table name:C256($i)
		<>aTIOTableNums{$i}:=$i
	End if 
End for 
SORT ARRAY:C229(<>aTIOTableNames; <>aTIOTableNums)