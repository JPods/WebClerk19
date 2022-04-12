C_LONGINT:C283($error)
//If (Is macOS)
//
//  CHOPPED  AL_RemoveArrays(eForeCast; 1; 11)
//
FC_RetrvLocal
//

// -- $error:=AL_SetArraysNam(eForeCast; 1; 8; "aFCItem"; "aFCDesc"; "aFCActionDt"; "aFCBomCnt"; "aFCRunQty"; "aFCRunQty"; "aFCTallyYTD"; "aFCTallyLess1Year")
// -- $error:=AL_SetArraysNam(eForeCast; 9; 8; "aFCTallyLess2Year"; "aFCBomLevel"; "aFCParent"; "aFCTypeTran"; "aFCDocID"; "aFCWho"; "aFCtypeID"; "aFCRecNum")
// -- AL_SetHeaders(eForeCast; 1; 14; "Item Num"; "Description"; "Date"; "Qty Chng"; "Forcast Qty OH"; "Qty OH"; "Tally YTD"; "Tally YTD-1"; "Tally YTD-2"; "Level"; "Doc Item"; "Type"; "Doc ID"; "Who"; "typeID")

C_LONGINT:C283(DateColSize; TallyColSize)
If (<>vbShowTallyInForcast)
	DateColSize:=3
	TallyColSize:=60
Else 
	DateColSize:=54
	TallyColSize:=3
End if 
// -- AL_SetWidths(eForeCast; 1; 14; 61; 5; DateColSize; 56; 56; 56; TallyColSize; TallyColSize; TallyColSize; 66; 52; 19; 58; 120; 60)

// -- AL_SetWidths(eForeCast; 1; 10; 61; 5; 54; 56; 56; 66; 52; 19; 58; 120)
// -- AL_SetHdrStyle(eForeCast; 0; "Geneva"; 9; 2)
// -- AL_SetStyle(eForeCast; 0; "Geneva"; 12; 0)
// -- AL_SetDividers(eForeCast; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetSort(eForeCast; 1; 3; 8)
// -- AL_SetFormat(eForeCast; 9; "0000-0000")
// -- AL_SetFormat(eForeCast; 4; "###,###.###")
// -- AL_SetFormat(eForeCast; 5; "###,###.###")

// -- AL_SetRowOpts(eForeCast; 1; 1; 0; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts(eForeCast; 1; 0; 1; 1; 0)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
// -- AL_SetEntryOpts(eForeCast; 1; 0; 0)
//Name; EntryMode; AllowReturn; DisplaySeconds
// -- AL_SetSortOpts(eForeCast; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
// -- AL_SetCallbacks(eForeCast; ""; "")
//Name; GP at entry; Function true or false if keep changes    
//Else 
//jAlertMessage (18000)
//End if 