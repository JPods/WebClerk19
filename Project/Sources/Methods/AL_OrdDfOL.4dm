//%attributes = {"publishedWeb":true}
//Procedure: AL_OrdDfOL
C_LONGINT:C283($1; $2)

var $working_t : Text
var $lines_c; $polished_c; $values_c : Collection
var $column_o; $final_o : Object
var $p : Integer
$final_o:=New object:C1471("LB_NameThis"; New object:C1471("type"; "listbox"; \
"left"; 88; \
"top"; 459; \
"width"; 1298; \
"height"; 363; \
"alternateFill"; "#FFFAE6"; \
"movableRows"; False:C215; \
"listboxType"; "collection"; \
"dataSource"; "LB_NameThis_sel"; \
"currentItemSource"; "Form;C1466.LB_NameThis_cur"; \
"currentItemPositionSource"; "Form;C1466.LB_NameThis_pos"; \
"selectedItemsSource"; "Form;C1466.LB_NameThis_sel"; \
"method"; ""; \
"events"; New collection:C1472("onClick"; "onHeaderClick"; "onDataChange"; "onSelectionChange"); \
"columns"; New collection:C1472))


var $inc; $cnt; $stdWidth : Integer
var $arrays_c; $widths_c; $names_c : Collection
var $stdName : Text


// MustFixQQQZZZ: Bill James (2022-01-09T06:00:00Z)

$lines_c:=New collection:C1472
$polished_c:=New collection:C1472
$lines_c:=New collection:C1472
$lines_c:=Split string:C1554(Get text from pasteboard:C524; "\r")
For each ($working_t; lines_c)
	
	$p:=Position:C15("AL_Set"; $working_t)
	$working_t:=Replace string:C233($working_t; "; "; "")
	$working_t:=Replace string:C233($working_t; "\""; "")
	$arrays_c:=New collection:C1472
	$widths_c:=New collection:C1472
	$names_c:=New collection:C1472
	Case of 
		: (Position:C15("AL_SetArrayNam"; $working_t)>0)
			$arrays_c:=Split string:C1554(Substring:C12($working_t; $p+10); ";")
		: (Position:C15("AL_SetWidths"; $working_t)>0)
			$widths_c:=Split string:C1554(Substring:C12($working_t; $p+10); ";")
		: (Position:C15("AL_SetHeaders"; $working_t)>0)
			$names_c:=Split string:C1554(Substring:C12($working_t; $p+10); ";")
		Else 
	End case 
End for each 

$cnt:=$arrays_c.length-1
For ($inc; 3; $cnt)  // account for the zeroth element
	If ($names_c[$inc]=Null:C1517)
		$stdName:="NA"+String:C10($inc+1)
	Else 
		$stdName:=$names_c[$inc]
	End if 
	If ($widths_c[$inc]=Null:C1517)
		$stdWidth:=70
	Else 
		$stdWidth:=$widths_c[$inc]
	End if 
	
	$column_o:=New object:C1471("header"; New object:C1471("name"; "header_LB_NameThis_"+$arrays_c[$inc]; "text"; $stdName); \
		"footer"; New object:C1471("name"; "Footer_LB_NameThis_"+$arrays_c[$inc]))
	
End for 


If ($2=2)
	// -- $error:=AL_InsArraysNam($1; 1; 15; "aNeedDates"; "aNeedTimes"; "aOpenOrders"; "ataskID"; "aOrdStatus"; "aOrdNames"; "aOrdCompany"; "aOrdAddress1"; "aOrdLevel"; "aOrdShipVia"; "aCustCtrl"; "aCustPO"; "aOrdAmt"; "aComDates"; "aOrdRecs")
Else 
	//   // -- $error:=AL_SetArraysNam($1; 1; 15; "aNeedDates"; "aNeedTimes"; "aOpenOrders"; "ataskID"; "aOrdStatus"; "aOrdNames"; "aOrdCompany"; "aOrdAddress1"; "aOrdLevel"; "aOrdShipVia"; "aCustCtrl"; "aCustPO"; "aOrdAmt"; "aComDates"; "aOrdRecs")
End if 
// -- AL_SetHeaders($1; 1; 15; "Need Date"; "Need Time"; "Ord Num"; "taskID"; "Status"; "Responsible"; "Customer"; "Address"; "Type Sale"; "Ship Via"; "Ship To"; "Cust PO"; "Amount"; "Inv Comp"; "RecNum")
// -- AL_SetWidths($1; 1; 15; 66; 62; 74; 20; 71; 63; 57; 120; 30; 49; 80; 70; 80; 80; 66)
// // -- AL_SetWidths ($1;1;15;54;54;60;60;71;63;57;57;57;49;48;62;54;54;54)
//
// -- AL_SetRowOpts($1; 1; 0; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 1; <>viPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts($1; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
// -- AL_SetCallbacks($1; ""; "")
//Name; GP at entry; Function true or false if keep changes    
// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
//
// -- AL_SetFormat($1; 3; "0000-0000"; 2; 2)
// -- AL_SetFormat($1; 2; "&/5"; 3; 0)
// -- AL_SetFormat($1; 1; "1"; 2; 2)  //date
//
// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetSort($1; 1; 2)
//