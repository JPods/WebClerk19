C_LONGINT:C283($formEvent)
C_LONGINT:C283(error)
$formEvent:=Form event code:C388
//If (False)
If (($formEvent#11) & ($formEvent#12))
	
	
End if 
If (vhere>0)
	//vhere:=0
End if 
Case of 
	: ($formEvent=On Clicked:K2:4)  //4
		MenuReset(1)
		SET WINDOW TITLE:C213("Sales Department - "+Storage:C1525.default.company)
		vHere:=0
	: ($formEvent=On Plug in Area:K2:16)  //19
		
	: ($formEvent=On Load:K2:1)
		//iLoPagePopUpMenuBar (->[Customer])
		//jSetMenuNums (1;2;3)
		MenuReset(1)
		SET WINDOW TITLE:C213("Sales Department - "+Storage:C1525.default.company)
		vHere:=0
		ptCurTable:=->[Customer:2]
	: ($formEvent=On Load Record:K2:38)  //40
		//UNLOAD RECORD(ptCurTable->)
		READ WRITE:C146([Customer:2])
		If (curTableNum<2)
			curTableNum:=Table:C252(->[Customer:2])
		End if 
	: ($formEvent=On Unload:K2:2)  //24
		
	: ($formEvent=On Getting Focus:K2:7)
		vHere:=0  //15
	: ($formEvent=On Losing Focus:K2:8)  //14
		
	: ($formEvent=On Outside Call:K2:11)  //10
		C_TEXT:C284(vDebugMessage)
		If (vDebugMessage="relaunch@")
			CANCEL:C270
			<>ptCurTable:=ptCurTable
			<>prcControl:=1
			<>processSales:=New process:C317("Dept_Sales"; <>tcPrsMemory; "Sales Dept")
		End if 
		If (<>vbDoQuit)  //must be first, prevent error with <>vlRecNum
			Quit_Processes
		End if 
	: ($formEvent=On Drop:K2:12)  //16
		
	: ($formEvent=On Activate:K2:9)  //11  //|($formEvent=On Deactivate))
		If (curTableNum<2)
			curTableNum:=Table:C252(->[Customer:2])
		End if 
		If (vhere>0)
			vhere:=0
		End if 
	: ($formEvent=On Display Detail:K2:22)  //8
		
	: ($formEvent=On Close Detail:K2:24)  //26
		
	: ($formEvent=On Close Box:K2:21)  //22
		FormEventOnCloseBox
	: ($formEvent=On Validate:K2:3)
	: ($formEvent=On Timer:K2:25)  //27   auto close windows after time passing
		
	: ($formEvent=On Resize:K2:27)  //29    auto close windows after time passing
	: ($formEvent=On Menu Selected:K2:14)  //18
		If ((CmdKey=0) | (OptKey=0) | (ShftKey=0) | (error#0))
			MenuReset(1)
			SET WINDOW TITLE:C213("Sales Department - "+Storage:C1525.default.company)
		End if 
	: ($formEvent=On Before Keystroke:K2:6)  //17
		
	: ($formEvent=On After Keystroke:K2:26)  //28
		
		
	Else 
End case 
