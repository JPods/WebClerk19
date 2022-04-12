//%attributes = {}

// Modified by: Bill James (2021-12-10T06:00:00Z)
// Method: DialogListChoices
// Description 
// Parameters
// ----------------------------------------------------

var $obWindows : Object
$obWindows:=WindowCountToShow
$win_l:=Open form window:C675([Control:1]; "diaListChoice"; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
DIALOG:C40([Control:1]; "diaListChoice")
CLOSE WINDOW:C154