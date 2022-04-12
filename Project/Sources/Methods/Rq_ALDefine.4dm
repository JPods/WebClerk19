//%attributes = {"publishedWeb":true}
//Procedure: Rq_ALDefine
C_LONGINT:C283($error)
C_LONGINT:C283($1)

// -- $error:=AL_SetArraysNam($1; 1; 13; "aRqRecNum"; "aRqItem"; "aRqItemDesc"; "aRqItemPar"; "aRqItemDPar"; "aRqQty"; "aRqCost"; "aRqActDate"; "aRqNeed"; "aRqAction"; "aRqStatus"; "aRqNameID"; "aRqLeadTime")
// -- $error:=AL_SetArraysNam($1; 14; 13; "aRqVendor"; "aRqVendorID"; "aRqVendorIt"; "aRqCustomer"; "aRqCustID"; "aRqOrdNum"; "aRqOrdLn"; "aRqPONum"; "aRqPoLn"; "aRqPpNum"; "aRqPpLn"; "aRqUniqueID"; "aRqGroupID")
// -- AL_SetHeaders($1; 1; 13; "RecNum"; "Item"; "Descp"; "ItemPar"; "ParDesc"; "Qty"; "Cost"; "ActDate"; "Need"; "Action"; "Status"; "nameID"; "LeadTime")
// -- AL_SetHeaders($1; 14; 13; "Vendor"; "VendID"; "VendItm"; "Cust"; "CustID"; "OrdNum"; "OrdLn"; "PONum"; "PoLn"; "PpNum"; "PpLn"; "idNum"; "GroupID")

// -- AL_SetWidths($1; 1; 13; 12; 68; 51; 27; 3; 40; 39; 48; 43; 50; 50)

// -- AL_SetWidths($1; 14; 13; 50; 35; 68; 68; 68; 68; 20; 68; 20; 68; 20; 68; 68)
//
// -- AL_SetCallbacks($1; "Ord_WFALCBEntry"; "Rq_AlExit")  //
//
// -- AL_SetRowOpts($1; 1; 0; 1; 0; 1)
//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
// -- AL_SetColOpts($1; 1; 0; 1; 0; <>viPixel)  //;<>viPixel)
//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel

//// -- AL_SetEnterable ($1;6;3;<>aActivities)
// -- AL_SetEnterable($1; 12; 3; <>aNameID)
//name; column; mode; array

// -- AL_SetEntryOpts($1; 6; 1; 1; 1)
//Name; EntryMode; AllowReturn; DisplaySeconds;MoveWithArrow;MapEnterKey
// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
//// -- AL_SetCallbacks ($1;"";"")
//Name; GP at entry; Function true or false if keep changes
// -- AL_SetSort($1; 8; 9)
// -- AL_SetFormat($1; 6; "###,###,###.###"; 0; 2)
// -- AL_SetFormat($1; 19; "0000-0000"; 2; 2)
// -- AL_SetFormat($1; 21; "0000-0000"; 2; 2)
// -- AL_SetFormat($1; 23; "0000-0000"; 2; 2)
// -- AL_SetFormat($1; 26; "0000-0000"; 2; 2)
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