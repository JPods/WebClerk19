//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/24/06, 14:11:16
// ----------------------------------------------------
// Method: Sch_ChoiceLists
// Description
// 
//
// Parameters
// ----------------------------------------------------
ARRAY TEXT:C222(aDistinctItemTypes; 0)

// Modified by: Bill James (2015-12-16T00:00:00 Convert_2_v14)
C_LONGINT:C283($num)
KeyWordByAlpha(Table:C252(->[Item:4]); "WOItems"; True:C214)

DISTINCT VALUES:C339([Item:4]type:26; aDistinctItemTypes)
INSERT IN ARRAY:C227(aDistinctItemTypes; 1; 1)
aDistinctItemTypes{1}:="ItemTypes"
aDistinctItemTypes:=1
REDUCE SELECTION:C351([Item:4]; 0)
ARRAY LONGINT:C221(aLsSrRec; 0)
ARRAY TEXT:C222(aLsItemDesc; 0)

ARRAY LONGINT:C221(aItemLines; 0)

// -- $error:=AL_SetArraysNam(eItemListWO; 1; 2; "aLsItemDesc"; "aLsSrRec")
//
// -- AL_SetHeaders(eItemListWO; 1; 2; "ItemDescription"; "RecordNum")
// -- AL_SetWidths(eItemListWO; 1; 2; 90; 90)
// -- AL_SetRowOpts(eItemListWO; 1; 1; 1; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
//$columnCnt:=Num(Error#0)*8
// -- AL_SetColOpts(eItemListWO; 1; 0; 1; 2; <>viPixel)  //$columnCnt;0)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts(eItemListWO; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts(eItemListWO; 1; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks (eItemListWO;"";"")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort(eItemListWO; 1)  //Seq
//// -- AL_SetColLock (eItemListWO;2)//Lock after Alt Item Num
// -- AL_SetMiscOpts(eItemListWO; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
// -- AL_SetDividers(eItemListWO; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetStyle(eItemListWO; 0; "Geneva"; 12; 0)
// -- AL_SetHdrStyle(eItemListWO; 0; "Geneva"; 9; 0)




//$error:=// -- AL_SetArraysNam (eNameID;1;1;"<>aNameID")
//
//// -- AL_SetHeaders (eNameID;1;1;"nameID")
//// -- AL_SetWidths (eNameID;1;1;30)
//// -- AL_SetRowOpts (eNameID;1;1;1;0;1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
//$columnCnt:=Num(Error#0)*8
//// -- AL_SetColOpts (eNameID;1;0;1;2;<>viPixel)//$columnCnt;0)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
//// -- AL_SetEntryOpts (eNameID;1;0;0)
//Name; EntryMode; AllowReturn; DisplaySeconds
//// -- AL_SetSortOpts (eNameID;0;1;1;"";1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks (eNameID;"";"")
//Name; GP at entry; Function true or false if keep changes
//// -- AL_SetSort (eNameID;2)//Seq
//// -- AL_SetColLock (eNameID;2)//Lock after Alt Item Num
//// -- AL_SetMiscOpts (eNameID;0;1;"";0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
//// -- AL_SetDividers (eNameID;"Gray";"Gray";0;"";"";0)
//// -- AL_SetStyle (eNameID;0;"Geneva";12;0)
//// -- AL_SetHdrStyle (eNameID;0;"Geneva";9;0)
//

//// -- AL_SetDrgDst (eNameID;1;"1";"2";"3";"4";"5";"6";"7";"8";"9";"10")
//// -- AL_SetDrgOpts (eNameID;0;10;0;1)


// -- $error:=AL_SetArraysNam(eWorkOrderTypes; 1; 1; "<>aWoTypes")
//
// -- AL_SetHeaders(eWorkOrderTypes; 1; 1; "WorkOrderTypes")
// -- AL_SetWidths(eWorkOrderTypes; 1; 1; 30)
// -- AL_SetRowOpts(eWorkOrderTypes; 1; 1; 1; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
//$columnCnt:=Num(Error#0)*8
// -- AL_SetColOpts(eWorkOrderTypes; 1; 0; 1; 2; <>viPixel)  //$columnCnt;0)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts(eWorkOrderTypes; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts(eWorkOrderTypes; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
// -- AL_SetCallbacks(eWorkOrderTypes; ""; "")
//Name; GP at entry; Function true or false if keep changes
//// -- AL_SetSort (eWorkOrderTypes;2)//Seq
// -- AL_SetColLock(eWorkOrderTypes; 2)  //Lock after Alt Item Num
// -- AL_SetMiscOpts(eWorkOrderTypes; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
// -- AL_SetDividers(eWorkOrderTypes; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetStyle(eWorkOrderTypes; 0; "Geneva"; 12; 0)
// -- AL_SetHdrStyle(eWorkOrderTypes; 0; "Geneva"; 9; 0)
//

// -- AL_SetDrgDst(eWorkOrderTypes; 1; "1"; "2"; "3"; "4"; "5"; "6"; "7"; "8"; "9"; "10")
// -- AL_SetDrgOpts(eWorkOrderTypes; 0; 10; 0; 1)





// -- $error:=AL_SetArraysNam(eCrewConfigs; 1; 1; "<>aCrewConfigs")
//
// -- AL_SetHeaders(eCrewConfigs; 1; 1; "Crews")
// -- AL_SetWidths(eCrewConfigs; 1; 1; 30)
// -- AL_SetRowOpts(eCrewConfigs; 1; 1; 1; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
//$columnCnt:=Num(Error#0)*8
// -- AL_SetColOpts(eCrewConfigs; 1; 0; 1; 2; <>viPixel)  //$columnCnt;0)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts(eCrewConfigs; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts(eCrewConfigs; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
// -- AL_SetCallbacks(eCrewConfigs; ""; "")
//Name; GP at entry; Function true or false if keep changes
//// -- AL_SetSort (eCrewConfigs;2)//Seq
// -- AL_SetColLock(eCrewConfigs; 2)  //Lock after Alt Item Num
// -- AL_SetMiscOpts(eCrewConfigs; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
// -- AL_SetDividers(eCrewConfigs; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetStyle(eCrewConfigs; 0; "Geneva"; 12; 0)
// -- AL_SetHdrStyle(eCrewConfigs; 0; "Geneva"; 9; 0)
//

// -- AL_SetDrgDst(eCrewConfigs; 1; "1"; "2"; "3"; "4"; "5"; "6"; "7"; "8"; "9"; "10")
// -- AL_SetDrgOpts(eCrewConfigs; 0; 10; 0; 1)
