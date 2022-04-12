//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/01/18, 19:42:58
// ----------------------------------------------------
// Method: PathSystemVolumn
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($thePath; $0)
ARRAY TEXT:C222($aPath; 0)
$thePath:=System folder:C487
TextToArray($thePath; ->$aPath; Folder separator:K24:12)
$0:=$aPath{1}+Folder separator:K24:12
