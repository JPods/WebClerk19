//%attributes = {}


// Modified by: Bill James (2022-04-21T05:00:00Z)
// Method: Ui_DEMO_1
// Description 
// Parameters
// ----------------------------------------------------

var $data : Object

// Create and install a minimal menu bar
cs:C1710.menu.new().defaultMinimalMenuBar().setBar()

$data:=New object:C1471(\
"window"; Open form window:C675("HDI_WIDGET_CLASSES"; Plain form window:K39:10; Horizontally centered:K39:1; At the top:K39:5; *))

DIALOG:C40("HDI_WIDGET_CLASSES"; $data)

CLOSE WINDOW:C154($data.window)