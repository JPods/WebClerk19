//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/11/18, 08:14:45
// ----------------------------------------------------
// Method: APOffSetALDefine
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $areaList)
$areaList:=$1
// -- $error:=AL_SetArraysNam($areaList; 1; 6; "aCredUnPaid"; "aCredDscAmt"; "aCredTot"; "aCredDays"; "aCredIvc"; "aCredRec")
// -- AL_SetHeaders($areaList; 1; 6; "Unpaid Amt"; "Discnt Amt"; "Total"; "Days"; "Invoice"; "Rec")

// -- AL_SetWidths($areaList; 1; 6; 80; 80; 80; 50; 80; 60)

// -- AL_SetDividers($areaList; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetFormat($areaList; 1; <>tcFormatTt; 3; 2)
// -- AL_SetFormat($areaList; 2; <>tcFormatTt; 3; 2)
// -- AL_SetFormat($areaList; 3; <>tcFormatTt; 3; 2)
// -- AL_SetFormat($areaList; 5; "0000-0000"; 3; 2)

// -- AL_SetHdrStyle($areaList; 0; "Geneva"; 9; 2)
// -- AL_SetStyle($areaList; 0; "Geneva"; 12; 0)



//
// // -- AL_SetRowOpts ($areaList;1;1;1;0;1)
AlpSetRowsOpts($areaList; 1; 1; 6; 0; 0)  // 1;1)  //accept drag

//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($areaList; 1; 0; 1; 1; <>viPixel)  //  Hide one column
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts($areaList; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts($areaList; 0; 1; 1; ""; 1)

//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks ($areaList;"";"")
//Name; GP at entry; Function true or false if keep changes
//    // -- AL_SetSort ($areaList;7)

// -- AL_SetSort($areaList; 5)  // Invoice
//// -- AL_SetColLock ($areaList;2)  //Lock after Alt Item Num
// -- AL_SetMiscOpts($areaList; 0; 1; "\\"; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters


//  --  CHOPPED  AL_UpdateArrays($areaList; -2)