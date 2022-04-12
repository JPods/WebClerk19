//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: LT_ALDefineLoadItems
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($1; $theArea)
C_TEXT:C284($fontName; $2)
C_LONGINT:C283($3; $4; $fontSize; $styleLayout)

If (Count parameters:C259<4)
	$theArea:=eLoadList
	$fontName:="Geneva"
	$fontSize:=9
	$styleLayout:=0
Else 
	$theArea:=$1
	$fontName:=$2
	$fontSize:=$3
	$styleLayout:=$4
End if 
Case of 
	: ($styleLayout=2)
		// -- $error:=AL_SetArraysNam(eLoadList; 1; 13; "aLiExtendedWt"; "aLiQty"; "aLiItemNum"; "aLiHazardClass"; "aLiItemDescription"; "aLiUnitWt"; "aLiItemNumAlt"; "aLiTagGroup"; "aLiDocID"; "aLiLineID"; "aLiRecordNum"; "aLiTableType"; "aLiUniqueID")
		// -- AL_SetHeaders(eLoadList; 1; 13; "ExtWt"; "Qty"; "ItemNum"; "Hazard"; "Description"; "Wt"; "AltItem"; "Tag"; "DocID"; "LineID"; "RecNum"; "Table"; "RecID")
		// -- AL_SetWidths(eLoadList; 1; 13; 73; 73; 140; 3; 140; 40; 40; 73; 73; 70; 70; 70; 70)
		//
		// -- AL_SetRowOpts(eLoadList; 1; 0; 0; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts(eLoadList; 1; 0; 1; 0; <>viPixel)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts(eLoadList; 0; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts(eLoadList; 0; 1; 1; ""; 1)
		//Name; SortInDuring; UserSort; AllowSortEditor; Prompt; ShowSortOrder
		// -- AL_SetCallbacks(eLoadList; ""; "")
		//Name; GP at entry; Function true or false if keep changes
		//// -- AL_SetSort (eLoadList;3;1)    
		//// -- AL_SetFormat (eLoadList;1;"";3;0)
		//// -- AL_SetFormat (eLoadList;2;"";3;2)
		//// -- AL_SetFormat (eLoadList;6;"";3;0)
		//
		// -- AL_SetHdrStyle(eLoadList; 0; "Arial"; 14; 0)
		// -- AL_SetStyle(eLoadList; 0; "Arial"; 14; 0)
		// -- AL_SetDividers(eLoadList; "Gray"; "Gray"; 0; ""; ""; 0)
		//
		// -- AL_SetScroll(eLoadList; 1; 1)
		// -- AL_SetSelect(eLoadList; aLiLoadItemSelect)
		
		// -- AL_SetFormat($theArea; 1; vsWtFormat; 0; 0)  //Pack
		// -- AL_SetFormat($theArea; 2; vsCountFormat; 0; 0)  //BLQ
		
	Else 
		// -- $error:=AL_SetArraysNam(eLoadList; 1; 10; "aLiTagGroup"; "aLiQty"; "aLiUnitWt"; "aLiItemNum"; "aLiItemDescription"; "aLiHazardClass"; "aLiDocID"; "aLiLineID"; "aLiRecordNum"; "aLiTableType")
		// -- AL_SetHeaders(eLoadList; 1; 10; "Tag"; "Qty"; "UnitWt"; "ItemNum"; "Description"; "Hazard"; "DocID"; "LineID"; "RecNum"; "Table")
		// -- AL_SetWidths(eLoadList; 1; 10; 32; 40; 60; 75; 221; 70; 73; 52; 70; 10)
		//
		// -- AL_SetRowOpts(eLoadList; 1; 0; 0; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts(eLoadList; 1; 0; 1; 0; <>viPixel)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts(eLoadList; 0; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts(eLoadList; 0; 1; 1; ""; 1)
		//Name; SortInDuring; UserSort; AllowSortEditor; Prompt; ShowSortOrder
		// -- AL_SetCallbacks(eLoadList; ""; "")
		//Name; GP at entry; Function true or false if keep changes
		//// -- AL_SetSort (eLoadList;3;1)    
		//// -- AL_SetFormat (eLoadList;1;"";3;0)
		//// -- AL_SetFormat (eLoadList;2;"";3;2)
		//// -- AL_SetFormat (eLoadList;6;"";3;0)
		//
		// -- AL_SetHdrStyle(eLoadList; 0; "Arial"; 14; 0)
		// -- AL_SetStyle(eLoadList; 0; "Arial"; 14; 0)
		// -- AL_SetDividers(eLoadList; "Gray"; "Gray"; 0; ""; ""; 0)
		//
		// -- AL_SetScroll(eLoadList; 1; 1)
		// -- AL_SetSelect(eLoadList; aLiLoadItemSelect)
End case 