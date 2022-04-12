//%attributes = {"publishedWeb":true}
//LT_ALDefineLoadTags
C_LONGINT:C283($1; $2; $thisTemplate)
If (Count parameters:C259>1)
	$thisTemplate:=$2
Else 
	$thisTemplate:=0
End if 

//    
Case of 
	: ($thisTemplate=0)
		// -- $error:=AL_SetArraysNam(eLoadTags; 1; 9; "aLtLoadTagID"; "aLtTagStatus"; "aLttrackID"; "aLtWeightExt"; "aLtTagWidth"; "aLtTagHeight"; "aLtTagDepth"; "aLtCarrier"; "aLtTagRecordID")
		
		// -- AL_SetHeaders(eLoadList; 1; 9; "Tag"; "Qty"; "UnitWt"; "ItemNum"; "Description"; "Hazard"; "DocID"; "LineID"; "RecNum")
		// -- AL_SetWidths(eLoadList; 1; 9; 32; 40; 60; 75; 221; 70; 73; 52; 70)
		
		
		
		
End case 
//
// -- AL_SetRowOpts(eLoadList; 1; 0; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts(eLoadList; 1; 0; 1; 0; 0)
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
// -- AL_SetHdrStyle(eLoadList; 0; "Geneva"; 9; 0)
// -- AL_SetStyle(eLoadList; 0; "Geneva"; 12; 0)
// -- AL_SetDividers(eLoadList; "Gray"; "Gray"; 0; ""; ""; 0)
//
// -- AL_SetScroll(eLoadList; 1; 1)
// -- AL_SetSelect(eLoadList; aLiLoadItemSelect)