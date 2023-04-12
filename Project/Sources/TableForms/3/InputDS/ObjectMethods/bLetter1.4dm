ptPrintTable:=(->[Customer:2])
//$win_l:=Open window(10; 40; 820; 734; 8; "Letters: "+Table name(ptPrintTable))
C_TEXT:C284($form_t)
$form_t:="Letter"
C_OBJECT:C1216($obWindows)
$obWindows:=WindowCountToShow
$win_l:=Open form window:C675($form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)

DIALOG:C40($form_t)  // ; Modal dialog)

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