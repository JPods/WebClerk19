//%attributes = {}

// Modified by: Bill James (2022-01-26T06:00:00Z)
// Method: Print_Letter
// Description 
// Parameters
// ----------------------------------------------------


var $1; $new_o; process_o : Object
var $form_t : Text
var $obWindows : Object
Case of 
	: (Count parameters:C259=1)
		process_o:=$1
		$form_t:="Letter"
		$obWindows:=WindowCountToShow
		$win_l:=Open form window:C675($form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
		DIALOG:C40($form_t; process_o)  // ; Modal dialog)
	Else 
		$new_o:=process_o
		$new_o.processParent:=Current process:C322
		$win_l:=New process:C317("Print_Letter"; 0; "Letter for "+process_o.dataClassName; $new_o)
End case 
//   Modal form dialog boxLongint1
//  Movable form dialog boxLongint5
//  Plain form windowLongint8
//  Pop up form windowLongint32
//  Sheet form windowLongint33
//  Toolbar form windowLongint35
//  Palette form windowLongint1984
//  Form has no menu barLongint2048
//  Form has full screen mode MacLongint65536
//  Controller form window