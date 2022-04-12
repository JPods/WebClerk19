//%attributes = {"publishedWeb":true}
//Procedure: Rq_ALDefineOrd
C_LONGINT:C283($error)
C_LONGINT:C283($1; $2)

// -- $error:=AL_SetArraysNam($1; 1; 13; "aOPricePt"; "aOItemNum"; "aODescpt"; "aOQtyOrder"; "aODscntUP"; "aOExtPrice"; "aODateReq"; "aoDateShipOn"; "aoDateShipped"; "aoProdBy"; "aOLineNum"; "aOSerialRc"; "aOLocation")
// -- AL_SetHeaders($1; 1; 13; "Dc"; "Item"; "Descp"; "Qty"; "Unit"; "Ext"; "Need"; "ShipOn"; "Shipped"; "ProdBy"; "LineNum"; "Order"; "LineRec")

// -- AL_SetWidths($1; 1; 13; 12; 50; 68; 51; 27; 54; 40; 39; 48; 43; 54; 72; 72)
//
// -- AL_SetCallbacks($1; ""; "")  //
//
// -- AL_SetRowOpts($1; 1; 0; 1; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 0; <>viPixel)  //;<>viPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel

//// -- AL_SetEnterable ($1;6;3;<>aActivities)
// -- AL_SetEnterable($1; 10; 3; <>aNameID)
//name; column; mode; array

// -- AL_SetEntryOpts($1; 6; 1; 1; 1)
//Name; EntryMode; AllowReturn; DisplaySeconds;MoveWithArrow;MapEnterKey
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks ($1;"";"")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort($1; 1)
// -- AL_SetFormat($1; 4; "###,###,###.###"; 0; 2)
// -- AL_SetFormat($1; 12; "0000-0000"; 2; 2)
//
//// -- AL_SetFormat ($1;3;"0000-0000";2;2)
//// -- AL_SetFormat ($1;8;"1";2;2)
//// -- AL_SetFormat ($1;9;"&/5";3;2)
//// -- AL_SetFormat ($1;10;"###,###,###.###";0;2)
//// -- AL_SetFormat ($1;15;"1";2;2)
//// -- AL_SetFormat ($1;16;"&/5";3;2)
//
// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
//