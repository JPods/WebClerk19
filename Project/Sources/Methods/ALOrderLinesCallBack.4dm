//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-07-07T00:00:00, 18:12:54
// ----------------------------------------------------
// Method: ALOrderLinesCallBack
// Description
// Modified: 07/07/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// 

//    0***AL Null event *** No action
//    1***AL Single click event *** Single-click (or up / down arrow keys)
//    2***AL Double click event *** Double-click
//    3***AL Empty Area Single click *** Single-click in an empty part of the area (without displayed data)
//    4***AL Empty Area Double click *** Double-click in an empty part of the area (without displayed data)
//    5***AL Single Control Click *** Control-click (or right mouse click)
//    6***AL Empty Area Control Click *** Control-click (or right mouse click) in an empty part of the area (without displayed data)
//    7***AL Vertical Scroll Event *** Vertical scroll
//    8***AL Row drop event *** Row(s) dropped to the area
//    9***AL Column drop event *** Column(s) dropped to the area
//    10***AL Cell drop event *** Cell(s) dropped to the area
//    11***AL Allow drop event *** ? Allow or disallow drop (during drag and drop from an external object) - respond in event callback with $0:=1 to allow drop or $0 = 0 to disallow
//    12***AL Hierarchy collapse event *** A hierarchy level was collapsed
//    13***AL Hierarchy expand event *** A hierarchy level was expanded
//    14***AL Object drop event *** Something was dropped from a non-AreaList Pro object (such as a 4D list or variable)
//    18***AL Mouse moved event *** ? Mouse moved (including over the empty column on the right)
//    101***AL Mouse entry unsel row event *** Entry by mouse action in a previously unselected row
//    -1***AL Sort button event *** Sort button
//    -2***AL Select all event *** Edit menu Select All
//    -3***AL Column resize event *** Column resized
//    -4***AL Column lock event *** Column lock changed
//    -5***AL Row drag event *** Row(s) dragged from the area
//    -6***AL Sort editor event *** Sort editor
//    -7***AL Column drag event *** Column(s) dragged from the area
//    -8***AL Cell drag event *** Cell(s) dragged from the area
//    -9***AL Object resize event *** Object and window resized
//    -10***AL Column click event *** User clicked on column header, automatic sort wont be executed
//    -11***AL Column control click event *** Control-click on column header
//    -12***AL Footer click event *** Click on column footer
KeyModifierCurrent
If ((OptKey=1) & (CmdKey=1))
	
End if 

C_LONGINT:C283($event; $selected; $area; tBlank; $mode)
$area:=eOrdList
//  CHOPPED  $event:=AL_GetAreaLongProperty($area; ALP_Area_AlpEvent)

//  CHOPPED  $mode:=AL_GetAreaLongProperty($area; ALP_Area_Compatibility)
tBlank:=$event

ConsoleMessage("Begin: "+String:C10($event)+"\r")
Case of 
		
	: ($event=AL Null event)  //    0***AL Null event *** No action
		
	: ($event=AL Single click event)  //    1***AL Single click event *** Single-click (or up / down arrow keys)
		// also pickup on on_hover
		
		
	: ($event=AL Double click event)  //    2***AL Double click event *** Double-click
		
		
		
		
		
	: ($event=AL Empty Area Single click)  //    3***AL Empty Area Single click *** Single-click in an empty part of the area (without displayed data)
		TRACE:C157
	: ($event=AL Empty Area Double click)  //    4***AL Empty Area Double click *** Double-click in an empty part of the area (without displayed data)
		TRACE:C157
	: ($event=AL Single Control Click)  //    5***AL Single Control Click *** Control-click (or right mouse click)
		TRACE:C157
	: ($event=AL Empty Area Control Click)  //    6***AL Empty Area Control Click *** Control-click (or right mouse click) in an empty part of the area (without displayed data)
		TRACE:C157
	: ($event=AL Vertical Scroll Event)  //    7***AL Vertical Scroll Event *** Vertical scroll
		TRACE:C157
	: ($event=AL Row drop event)  //    8***AL Row drop event *** Row(s) dropped to the area
		////  CHOPPED  $error:=AL_GetSelect (eOrdList;aRayLines)
		//  CHOPPED  $error:=AL_GetObjects($area; ALP_Object_Selection; aRayLines)  // get the rows selected by user
		
		
		TRACE:C157
	: ($event=AL Column drop event)  //    9***AL Column drop event *** Column(s) dropped to the area
		TRACE:C157
	: ($event=AL Cell drop event)  //    10***AL Cell drop event *** Cell(s) dropped to the area
		TRACE:C157
	: ($event=AL Allow drop event)  //    11***AL Allow drop event *** ? Allow or disallow drop (during drag and drop from an external object) - respond in event callback with $0:=1 to allow drop or $0 = 0 to disallow
		TRACE:C157
	: ($event=AL Hierarchy collapse event)  //    12***AL Hierarchy collapse event *** A hierarchy level was collapsed
		TRACE:C157
	: ($event=AL Hierarchy expand event)  //    13***AL Hierarchy expand event *** A hierarchy level was expanded
		TRACE:C157
	: ($event=AL Object drop event)  //    14***AL Object drop event *** Something was dropped from a non-AreaList Pro object (such as a 4D list or variable)
		TRACE:C157
	: ($event=AL Mouse moved event)  //    18***AL Mouse moved event *** ? Mouse moved (including over the empty column on the right)
		TRACE:C157
	: ($event=AL Mouse entry unsel row event)  //    101***AL Mouse entry unsel row event *** Entry by mouse action in a previously unselected row
		TRACE:C157
	: ($event=AL Sort button event)  //    -1***AL Sort button event *** Sort button
		//  CHOPPED  $sort:=AL_GetAreaLongProperty($area; ALP_Area_SortList)
		
		
	: ($event=AL Select all event)  //    -2***AL Select all event *** Edit menu Select All
		TRACE:C157
	: ($event=AL Column resize event)  //    -3***AL Column resize event *** Column resized
		TRACE:C157
	: ($event=AL Column lock event)  //    -4***AL Column lock event *** Column lock changed
		TRACE:C157
	: ($event=AL Row drag event)  //    -5***AL Row drag event *** Row(s) dragged from the area
		TRACE:C157
	: ($event=AL Sort editor event)  //    -6***AL Sort editor event *** Sort editor
		TRACE:C157
	: ($event=AL Column drag event)  //    -7***AL Column drag event *** Column(s) dragged from the area
		TRACE:C157
	: ($event=AL Cell drag event)  //    -8***AL Cell drag event *** Cell(s) dragged from the area
		TRACE:C157
	: ($event=AL Object resize event)  //    -9***AL Object resize event *** Object and window resized
		TRACE:C157
	: ($event=AL Column click event)  //    -10***AL Column click event *** User clicked on column header, automatic sort wont be executed
		TRACE:C157
	: ($event=AL Column control click event)  //    -11***AL Column control click event *** Control-click on column header
		TRACE:C157
	: ($event=AL Footer click event)  //    -12***AL Footer click event *** Click on column footer
End case 
tBlank:=0
//  $event:=// -- AL_SetAreaPtrProperty ($area;ALP_Area_AlpEvent;->tBlank)
// -- AL_SetAreaLongProperty($area; ALP_Area_AlpEvent; 0)

//  CHOPPED  $event:=AL_GetAreaLongProperty($area; ALP_Area_AlpEvent)

ConsoleMessage("end: "+String:C10($event)+"\r")

