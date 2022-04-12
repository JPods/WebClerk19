//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2021-12-10T06:00:00Z)
// Method: File_Select
// Description 
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)
vDiaCom:=$1
var $obWindows : Object
$obWindows:=WindowCountToShow
$win_l:=Open form window:C675([Control:1]; "File_SetDia"; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
DIALOG:C40([Control:1]; "File_SetDia")
CLOSE WINDOW:C154
vDiaCom:=""
vi1:=0