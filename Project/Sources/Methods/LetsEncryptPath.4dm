//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/01/18, 19:04:16
// ----------------------------------------------------
// Method: LetsEncryptPath
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($thePath; $0)
ARRAY TEXT:C222($aPath; 0)
$thePath:=System folder:C487
TextToArray($thePath; ->$aPath; Folder separator:K24:12)

$thePath:=$aPath{1}+Folder separator:K24:12+"private"+Folder separator:K24:12+"etc"+Folder separator:K24:12+"letsencrypt"+Folder separator:K24:12
If (Test path name:C476($thePath)#0)
	$thePath:=$aPath{1}+Folder separator:K24:12+"private"+Folder separator:K24:12+"etc"+Folder separator:K24:12
End if 

$0:=$thePath