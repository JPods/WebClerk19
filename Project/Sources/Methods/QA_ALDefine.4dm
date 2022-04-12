//%attributes = {"publishedWeb":true}
//Procedure: Ws_ALDefine
C_LONGINT:C283($error)
C_LONGINT:C283($1)
If (($1>0) & (Before:C29))
	//;
	// -- $error:=AL_SetArraysNam($1; 1; 15; "aQaGroup"; "aQaAnsweredBy"; "aQaSeq"; "aQaQuest"; "aQaAnswr"; "aQaAnswDt"; "aQaAnswKey"; "aQaQuestKey"; "aQaAskedBy"; "aQaAnswrRec"; "aQaUniqueID"; "aQaTableNum"; "aQataskID"; "aQaAcctKey"; "aQaDocID")
	// -- AL_SetHeaders($1; 1; 15; "Grp"; "Col"; "Seq"; "Question"; "Answer"; "Date"; "AnswerKey"; "QuestKey"; "Asked By"; "Rec"; "idNum"; "TableNum"; "taskID"; "TableKey"; "DocID")
	// -- AL_SetWidths($1; 1; 15; 30; 20; 20; 120; 140; 54; 30; 30; 30; 30; 30; 30; 30; 60; 90)
	//
	// -- AL_SetRowOpts($1; 1; 0; 1; 0; 1)
	//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
	// -- AL_SetColOpts($1; 1; 0; 1; 0; <>viPixel)
	//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
	//// -- AL_SetEntryOpts ($1;1;0;0)
	////Name; EntryMode; AllowReturn; DisplaySeconds
	// -- AL_SetEntryOpts($1; 6; 1; 1; 1)
	//Name; EntryMode; AllowReturn; DisplaySeconds;MoveWithArrow;MapEnterKey
	//// -- AL_SetEnterable ($1;2;3;<>aAnswers)
	// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
	//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
	// -- AL_SetCallbacks($1; ""; "QA_Exit")
	//Name; GP at entry; Function true or false if keep changes
	// -- AL_SetSort($1; 1; 3)
	//
	//// -- AL_SetCallbacks ($1;"Ord_WFALCBEntry";"")
	//// -- AL_SetEnterable ($1;5;3;<>aAnswers)
	// -- AL_SetHdrStyle($1; 0; "Geneva"; 10; 2)
	// -- AL_SetStyle($1; 0; "Geneva"; 10; 0)
	// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
	// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
	//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
	//
End if 