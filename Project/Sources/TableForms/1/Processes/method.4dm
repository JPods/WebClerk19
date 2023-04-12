// ### jwm ### 20171212_1436 increased width to 125 and reorganized buttons

C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
Case of 
	: ($formevent=On Close Box:K2:21)
		CANCEL:C270
	: ($formEvent=On Timer:K2:25)
		Process_ListActive
		REDRAW WINDOW:C456  //([Control];"Processes")
		SET TIMER:C645(60*60)  // every minute
		
	: ($formEvent=On Load:K2:1)
		SET TIMER:C645(60)
		b12:=<>viDebugMode
		vHere:=1
		iloText1:=""
		//$error:=// -- AL_SetArraysNam (ePrcssList;1;2;"aPrsName";"arPrsNum")
		//// -- AL_SetHeaders (ePrcssList;1;2;"Process";"Num")
		//// -- AL_SetWidths (ePrcssList;1;2;100;35)
		////
		//// -- AL_SetRowOpts (ePrcssList;1;0;0;0;1)
		////Name; Multi; AllowNoSelect; DragLine; AcceptDrag; MoveWithData
		//// -- AL_SetColOpts (ePrcssList;0;0;0;0;1)
		////Name; AllowResize; ResizeDuring; AllowColLock; HideLastCol; Pixel
		//// -- AL_SetEntryOpts (ePrcssList;1;0;0)
		////Name; EntryMode; AllowReturn; DisplaySeconds
		//// -- AL_SetSortOpts (ePrcssList;0;1;1;"";1)
		////Name; SortInDuring; AllowSortEditor; Prompt; ShowSortOrder
		//// -- AL_SetCallbacks (ePrcssList;"";"")
		////Name; GP at entry; Function true or false if keep changes       
		////
		//// -- AL_SetHdrStyle (ePrcssList;0;"Geneva";9;2)
		//// -- AL_SetStyle (ePrcssList;0;"Geneva";12;0)
		//// -- AL_SetDividers (ePrcssList;"Gray";"Gray";0;"";"";0)
		////  --  CHOPPED  AL_UpdateArrays (ePrcssList;-2)
		C_LONGINT:C283($w)
		$w:=Find in array:C230(<>aPrsNameWeb; "WC_@")
		If ($w>0)
			OBJECT SET ENABLED:C1123(b8; True:C214)
			OBJECT SET ENABLED:C1123(b7; False:C215)
			OBJECT SET RGB COLORS:C628(*; "iloText1"; Black:K11:16; Yellow:K11:2)
			
		Else 
			OBJECT SET ENABLED:C1123(b8; False:C215)
			OBJECT SET ENABLED:C1123(b7; True:C214)
			OBJECT SET RGB COLORS:C628(*; "iloText1"; Black:K11:16; White:K11:1)
		End if 
	: ($formEvent=On Outside Call:K2:11)
		DELAY PROCESS:C323(Current process:C322; 30)  // Give the closing process time to close
		If ((<>vbDoQuit) | (<>vlQuitOne=Current process:C322))  //must be first, prevent error with <>vlRecNum
			Quit_Processes
			<>vlQuitOne:=-1
		Else 
			Process_ListActive
			REDRAW WINDOW:C456  //([Control];"Processes")
		End if 
End case 