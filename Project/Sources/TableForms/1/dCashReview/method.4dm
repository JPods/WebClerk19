C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388

If (ptCurTable#(->[Control:1]))  //must be ahead of the next call
	//jsetDuringIncl (->[Control])
	//Cust_PageManage 
	//jrelateClrFiles (0)//rebuild the arrays
End if 

Case of 
	: ($formEvent=On Clicked:K2:4)
		
	: ($formEvent=On Plug in Area:K2:16)
		
	: ($formEvent=On Load:K2:1)
		
		//UNLOAD RECORD(ptCurTable->)
		
		dCashArrayManage(0; 0; 0; eCashLedger)
		
		
		//C_LONGINT(eCashLedger;$2)
		
		// -- $error:=AL_SetArraysNam(eCashLedger; 1; 14; "adCashSequence"; "adCashAvailable"; "adCashRunningBalance"; "adCashAmount"; "adCashNameID"; "adCashDate"; "adCashTerms"; "adCashApplyCustomer"; "adCashApplyTable"; "adCashApplyDoc"; "adCashRecieveCustomer"; "adCashReceiveTable"; "adCashReceiveDoc"; "adCashRecNum")
		
		// -- AL_SetHeaders(eCashLedger; 1; 14; "Seq"; "Available"; "Balance"; "Amount"; "nameID"; "Date"; "Term"; "ApplyCustomer"; "ApplyTable"; "ApplyDoc"; "RecieveCustomer"; "ReceiveTable"; "ReceiveDoc"; "RecNum")
		//If ($2=2)
		// -- AL_SetWidths(eCashLedger; 1; 14; 16; 58; 70; 59; 54; 76; 58; 58; 60; 60; 60; 60; 60; 60)  //update when filled
		//Else 
		//// -- AL_SetWidths (eCashLedger;1;14;16;58;70;59;54;76;58;58;60;60;60;60;60;60)
		//End if 
		//
		// -- AL_SetRowOpts(eCashLedger; 0; 1; 0; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts(eCashLedger; 1; 0; 1; 1; <>viPixel)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts(eCashLedger; 1; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts(eCashLedger; 0; 1; 1; ""; 0)
		//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
		//// -- AL_SetCallbacks (eCashLedger;"";"")
		//Name; GP at entry; Function true or false if keep changes
		//    // -- AL_SetSort (eCashLedger;2)
		// -- AL_SetFormat(eCashLedger; 1; <>tcFormatTt; 3; 2)
		// -- AL_SetFormat(eCashLedger; 2; <>tcFormatTt; 3; 2)
		// -- AL_SetFormat(eCashLedger; 3; <>tcFormatTt; 3; 2)
		//
		// -- AL_SetFormat(eCashLedger; 9; "0000-0000"; 3; 2)
		// -- AL_SetFormat(eCashLedger; 12; "0000-0000"; 3; 2)
		//
		// -- AL_SetHdrStyle(eCashLedger; 0; "Geneva"; 9; 2)
		// -- AL_SetStyle(eCashLedger; 0; "Geneva"; 12; 0)
		// -- AL_SetDividers(eCashLedger; "Gray"; "Gray"; 0; ""; ""; 0)
		// -- AL_SetMiscOpts(eCashLedger; 0; 1; ""; 0)
		//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
		
		
		
	: ($formEvent=On Load Record:K2:38)
		
	: ($formEvent=On Unload:K2:2)
		
	: ($formEvent=On Getting Focus:K2:7)
		
	: ($formEvent=On Losing Focus:K2:8)
		
	: ($formEvent=On Outside Call:K2:11)
		
	: ($formEvent=On Drop:K2:12)
		
	: ($formEvent=On Activate:K2:9)
		//RelatedRelease 
	: ($formEvent=On Deactivate:K2:10)
		
	: ($formEvent=On Display Detail:K2:22)
		
	: ($formEvent=On Close Detail:K2:24)
		
	: ($formEvent=On Close Box:K2:21)
		
	: ($formEvent=On Validate:K2:3)
		
	: ($formEvent=On Timer:K2:25)  //auto close windows after time passing
		
	: ($formEvent=On Resize:K2:27)  //auto close windows after time passing
	: ($formEvent=On Menu Selected:K2:14)
	: ($formEvent=On Before Keystroke:K2:6)
		
	: ($formEvent=On After Keystroke:K2:26)
		//C_TEXT($keystroke)
		//$keystroke:=Get edited text
		//SET TIMER(60*60*10)
	Else 
		
End case 