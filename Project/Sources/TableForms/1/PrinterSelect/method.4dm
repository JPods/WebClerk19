// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/14/07, 09:53:15
// ----------------------------------------------------
// Method: Form Method: iCallReports_9
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($formEvent; $curRecNum)
$formEvent:=Form event code:C388
$curRecNum:=Record number:C243([CallReport:34])

Case of 
	: ($formEvent=On Unload:K2:2)
		UNLOAD RECORD:C212(ptCurTable->)
		
	: ($formEvent=On Outside Call:K2:11)
		
		Prs_OutsideCall
		
	: ($formEvent=On Load:K2:1)  //|(booPreNext))//(Before)
		
		//ConsoleMessage ("TEST: On Load")
		
		
		//ConsoleMessage ("TEST: Before")
		ARRAY TEXT:C222(iLoaText1; 0)
		ARRAY TEXT:C222(iLoaText2; 0)
		ARRAY TEXT:C222(iLoaText3; 0)
		
		// -- $error:=AL_SetArraysNam(ePrinters; 1; 3; "iLoaText1"; "iLoaText2"; "iLoaText3")
		// -- AL_SetHeaders(ePrinters; 1; 3; "Name/Location"; "SystemName"; "Model(win)")
		// -- AL_SetWidths(ePrinters; 1; 3; 200; 200; 200)
		// -- AL_SetRowOpts(ePrinters; 1; 0; 0; 0; 1)
		//Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		// -- AL_SetColOpts(ePrinters; 1; 0; 1; 1; <>viPixel)
		//Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		// -- AL_SetEntryOpts(ePrinters; 1; 0; 0)
		//Name; EntryMode; AllowReturn; DisplaySeconds
		// -- AL_SetSortOpts(ePrinters; 0; 1; 1; ""; 1)
		//Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
		//// -- AL_SetCallbacks (ePrinters;"";"")
		//Name; GP at entry; Function true or false if keep changes
		// -- AL_SetMiscOpts(ePrinters; 0; 1; ""; 0)
		//Name; HideHeaders; AreaSelected; PostKey; ShowFooters
		// -- AL_SetHdrStyle(ePrinters; 0; "Geneva"; 9; 2)
		// -- AL_SetStyle(ePrinters; 0; "Geneva"; 12; 0)
		
		// -- AL_SetDividers(ePrinters; "Gray"; "Gray"; 0; ""; ""; 0)
		// -- AL_SetSort(ePrinters; 1; 1)
		
		
		
		//Parameter	Type		Description
		//namesArray	Text Array		Printer names
		//altNamesArray	Text Array		Windows: Printer locations
		//Mac OS: Custom printer names
		//modelsArray	Text Array		Printer models(Windows only)
		
		PRINTERS LIST:C789(iLoaText2; iLoaText1; iLoaText3)
		
		//  --  CHOPPED  AL_UpdateArrays(ePrinters; -2)
		
		//PRINTERS LIST($namesArray{;altNamesArray{;modelsArray}})
		C_TEXT:C284($thePrinters; $thePrinters1)
		$thePrinters:=Get current printer:C788
		C_LONGINT:C283($selectPrinter; $findWantedPrinter)
		
		
End case 


If (False:C215)
	Case of 
		: ($formEvent=On Clicked:K2:4)
			
		: ($formEvent=On Plug in Area:K2:16)
			
		: ($formEvent=On Load:K2:1)
			
		: ($formEvent=On Load Record:K2:38)
			//UNLOAD RECORD(ptCurTable->)
			READ WRITE:C146([Customer:2])
		: ($formEvent=On Unload:K2:2)
			
		: ($formEvent=On Getting Focus:K2:7)
			
		: ($formEvent=On Losing Focus:K2:8)
			
		: ($formEvent=On Outside Call:K2:11)
			
		: ($formEvent=On Drop:K2:12)
			
		: ($formEvent=On Activate:K2:9)
			RelatedRelease
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
			C_TEXT:C284($keystroke)
			$keystroke:=Get edited text:C655
			SET TIMER:C645(60*60*10)
		Else 
	End case 
End if 
