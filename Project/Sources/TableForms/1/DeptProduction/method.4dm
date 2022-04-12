C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
//If (False)
If (($formEvent#11) & ($formEvent#12))
	
	
End if 
Case of 
	: ($formEvent=On Clicked:K2:4)
		MenuReset(7)
		SET WINDOW TITLE:C213("Production Department - "+Storage:C1525.default.company)
		vHere:=0
	: ($formEvent=On Plug in Area:K2:16)
		
	: ($formEvent=On Load:K2:1)
		//iLoPagePopUpMenuBar (->[Customer])
		//jSetMenuNums (1;2;3)
		MenuReset(7)
		SET WINDOW TITLE:C213("Production Department - "+Storage:C1525.default.company)
		vHere:=0
		curTableNum:=Table:C252(->[Item:4])
	: ($formEvent=On Load Record:K2:38)
		//UNLOAD RECORD(ptCurTable->)
		READ WRITE:C146([Customer:2])
	: ($formEvent=On Unload:K2:2)
		
	: ($formEvent=On Getting Focus:K2:7)
		
	: ($formEvent=On Losing Focus:K2:8)
		
	: ($formEvent=On Outside Call:K2:11)
		If (<>vbDoQuit)  //must be first, prevent error with <>vlRecNum
			Quit_Processes
		End if 
	: ($formEvent=On Drop:K2:12)
		
	: ($formEvent=On Activate:K2:9)  //|($formEvent=On Deactivate))
		If (curTableNum<2)
			curTableNum:=Table:C252(->[Item:4])
		End if 
		If (vhere>0)
			vhere:=0
		End if 
	: ($formEvent=On Display Detail:K2:22)
		
	: ($formEvent=On Close Detail:K2:24)
		
	: ($formEvent=On Close Box:K2:21)
		FormEventOnCloseBox
		
	: ($formEvent=On Validate:K2:3)
	: ($formEvent=On Timer:K2:25)  //auto close windows after time passing
		
	: ($formEvent=On Resize:K2:27)  //auto close windows after time passing
	: ($formEvent=On Menu Selected:K2:14)
		MenuReset(7)
		SET WINDOW TITLE:C213("Production Department - "+Storage:C1525.default.company)
	: ($formEvent=On Before Keystroke:K2:6)
		
	: ($formEvent=On After Keystroke:K2:26)
		
	Else 
End case 
