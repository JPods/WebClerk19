
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2018-06-27T00:00:00, 00:00:57
// ----------------------------------------------------
// Method: [Customer].Input1.Button4
// Description
// Modified: 06/27/18
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($fileName; $thePath)
ARRAY TEXT:C222($atSelected; 0)

$fileName:=Select document:C905(vtTNPathSystem; "*"; "Select a path to clipboard"; 0; $atSelected)  // several files may be selected
If (OK=1)
	$thePath:=pathToBrowser(document)  // full path
	SET TEXT TO PASTEBOARD:C523($thePath)
End if 
// LAUNCH EXTERNAL PROCESS($atSelected{1})
