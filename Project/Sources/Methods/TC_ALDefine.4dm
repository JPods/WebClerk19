//%attributes = {"publishedWeb":true}
//Procedure: TC_ALDefine
C_LONGINT:C283($error; $1; $2)
Case of 
	: ($2=1)  //
		// -- $error:=AL_SetArraysNam($1; 1; 9; "aTCSignedIN"; "aTCNameID"; "aTCActivity"; "aTCCause"; "aTCDateIn"; "aTCTimeIn"; "aTCTimeOut"; "aTCLapsed"; "aTCPerCent")
		// -- $error:=AL_SetArraysNam($1; 10; 7; "aTCHourWage"; "aTCExtWage"; "aTCOrdNum"; "aTCOrdLn"; "aTCDateOut"; "aTCComment"; "aTCTimeRecs")
		// -- AL_SetHeaders($1; 1; 9; "x"; "Name"; "Activity"; "Cause"; "DateIn"; "In"; "Out"; "Lapse"; "%")
		// Modified by: Bill James (2017-08-21T00:00:00 - missing specialCharacter to x)
		// -- AL_SetHeaders($1; 10; 7; "Wage"; "Ext"; "S/O"; "OrdLn"; "DateOut"; "Comment"; "Recs")
		// -- AL_SetWidths($1; 1; 9; 12; 65; 65; 9; 73; 70; 70; 54; 22)
		// -- AL_SetWidths($1; 10; 7; 34; 44; 58; 14; 73; 350; 60)
		//
		// -- AL_SetRowOpts($1; 1; 1; 0; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts($1; 1; 0; 1; 0; 0)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts($1; 0; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
		//Name; SortInDuring; UserSort; AllowSortEditor; Prompt; ShowSortOrder
		C_BOOLEAN:C305(<>Quote)
		<>Quote:=False:C215
		// -- AL_SetCallbacks($1; "Ord_WFALCBEntry"; "TC_ALExit")
		//Name; GP at entry; Function true or false if keep changes
		// -- AL_SetSort($1; 2; 5; 6)
		//    
		// -- AL_SetFormat($1; 12; "0000-0000"; 3; 0)
		// -- AL_SetFormat($1; 6; "&/5"; 3; 0)  //Time In
		// -- AL_SetFormat($1; 7; "&/5"; 3; 0)  //Time Out
		// -- AL_SetFormat($1; 8; "&/2"; 3; 0)  //Lapse
		// -- AL_SetFormat($1; 5; "1"; 0; 0)  //date
		// -- AL_SetFormat($1; 14; "1"; 0; 0)  //date
		//
		// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 0)
		// -- AL_SetHdrStyle($1; 11; "Geneva"; 9; 2)
		// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
		// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
		// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
		//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
		// If (Is macOS)
		// -- AL_SetEnterable($1; 2; 3; <>aNameID)
		// -- AL_SetEnterable($1; 3; 3; <>aActivities)
		//name; column; mode; array
		// -- AL_SetEnterable($1; 6; 3)
		// -- AL_SetEnterable($1; 7; 3)
		// -- AL_SetEnterable($1; 5; 3)
		// -- AL_SetEnterable($1; 8; 3)  //lapse
		// -- AL_SetEnterable($1; 14; 3)
		//   End if 
		// -- AL_SetEntryOpts($1; 6; 1; 0; 1)
		//Name; EntryMode; AllowReturn; DisplaySeconds;MoveWithArrow;MapEnterKey
		
	: ($2=2)
		C_LONGINT:C283($error; $1; $2)
		// -- AL_SetWidths($1; 1; 9; 12; 43; 43; 9; 73; 70; 70; 36; 22)
		// -- AL_SetWidths($1; 10; 7; 3; 36; 59; 3; 73; 350; 60)
		//
	: ($2=5)
		// -- $error:=AL_SetArraysNam($1; 1; 9; "aTCSignedIN"; "aTCNameID"; "aTCTimeIn"; "aTCTimeOut"; "aTCLapsed"; "aTCPerCent"; "aTCOrdNum"; "aTCOrdLn"; "aTCActivity")
		// -- $error:=AL_SetArraysNam($1; 10; 7; "aTCCause"; "aTCComment"; "aTCDateIn"; "aTCDateOut"; "aTCHourWage"; "aTCExtWage"; "aTCTimeRecs")
		// -- AL_SetHeaders($1; 1; 9; ""; "Name"; "T/In"; "T/Out"; "Lapse"; "%"; "S/O"; "Ln"; "Activity")
		// -- AL_SetHeaders($1; 10; 7; "Cause"; "Comment"; "Date In"; "Date Out"; "Rate"; "Total"; "Rec Num")
		// -- AL_SetWidths($1; 1; 9; 12; 76; 59; 41; 54; 52; 52; 34; 35; 40)
		// -- AL_SetWidths($1; 10; 7; 12; 76; 59; 41; 54; 52; 52; 34; 35; 40)
		// -- AL_SetRowOpts($1; 1; 1; 0; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts($1; 1; 0; 1; 1; 0)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts($1; 0; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts($1; 0; 1; 1; ""; 1)
		//Name; SortInDuring; UserSort; AllowSortEditor; Prompt; ShowSortOrder
		// -- AL_SetCallbacks($1; "Ord_WFALCBEntry"; "Ord_WFALCBExit")
		//Name; GP at entry; Function true or false if keep changes
		// -- AL_SetSort($1; 2; 5; 6)
		//
		// -- AL_SetFormat($1; 3; "0000-0000"; 3; 0)
		// -- AL_SetFormat($1; 3; "&/5"; 3; 0)
		// -- AL_SetFormat($1; 4; "&/5"; 3; 0)
		// -- AL_SetFormat($1; 5; "&/2"; 3; 0)
		// -- AL_SetFormat($1; 12; "1"; 0; 0)  //date
		// -- AL_SetFormat($1; 13; "1"; 0; 0)  //date
		//
		// -- AL_SetHdrStyle($1; 0; "Geneva"; 9; 2)
		// -- AL_SetStyle($1; 0; "Geneva"; 12; 0)
		// -- AL_SetDividers($1; "Gray"; "Gray"; 0; ""; ""; 0)
		// -- AL_SetMiscOpts($1; 0; 1; ""; 0)
		//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
		
	: ($2=8)  //eSignInOut;8 Sign in and out window
		TC_ALDefine8($1)
End case 