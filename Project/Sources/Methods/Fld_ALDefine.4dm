//%attributes = {"publishedWeb":true}
C_LONGINT:C283($error)
C_LONGINT:C283($1)
C_TEXT:C284($2; $3; $4; $5)
If (Count parameters:C259=5)
	$theFields:=$2
	$theTypes:=$3
	$theUniques:=$4
	$theFldNum:=$5
Else 
	$theFields:="theFields"
	$theTypes:="theTypes"
	$theUniques:="theUniques"
	$theFldNum:="theFldNum"
End if 
//
//array TEXT(theFields;$k)
//array TEXT(theTypes;$k)
//array TEXT(theUniques;$k)
//ARRAY LONGINT(theFldNum;$k)
//
ARRAY LONGINT:C221(aFieldLns; 0)
// NOTE, following are variables of the array names. Array names are listed above
// -- $error:=AL_SetArraysNam($1; 1; 4; $theFields; $theTypes; $theUniques; $theFldNum)
// -- AL_SetHeaders($1; 1; 4; "Field"; "Type"; "c"; "Num")

// -- AL_SetWidths($1; 1; 4; 118; 18; 14; 27)
//
//// -- AL_SetCallbacks ($1;"Ord_WFALCBEntry";"Ord_WFALCBExit")//
//


// -- AL_SetRowOpts($1; 1; 0; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 0; 0; 0; 0; <>vPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
//// -- AL_SetEnterable ($1;7;3;<>aNameID)
//name; column; mode; array

// -- AL_SetEntryOpts($1; 1; 1; 1; 1)
//Name; EntryMode; AllowReturn; DisplaySeconds;MoveWithArrow;MapEnterKey
// -- AL_SetSortOpts($1; 1; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks ($1;"";"")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort($1; 1)

//  // -- AL_SetAreaLongProperty ($1;ALP_Area_SelMultiple;$2)
//
// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
//

//  C_LONGINT($1)  //ALP area
//  If (Count parameters>1)
//   // -- AL_SetAreaLongProperty ($1;ALP_Area_SelMultiple;$2)

//  
//  C_LONGINT($2)  //allow multiple line selection
//   // -- AL_SetAreaLongProperty ($1;ALP_Area_SelNone;$3)

//  
//  C_LONGINT($3)  //allow no row selection
//   // -- AL_SetAreaLongProperty ($1;ALP_Area_DragLine;$4)

//  
//  C_LONGINT($5)  //accept drag from and to not ALP object
//   // -- AL_SetAreaLongProperty ($1;ALP_Area_DragAcceptLine;$5)

//  
//  C_LONGINT($6)  //maintain row(s) option(s) during drag
//   // -- AL_SetAreaLongProperty ($1;ALP_Area_MoveRowOptions;$6)

//  
//  C_LONGINT($7)  //disable row hightlighting
//   // -- AL_SetAreaLongProperty ($1;ALP_Area_SelNoHighlight;$7)
