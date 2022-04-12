//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-22T00:00:00, 19:00:31
// ----------------------------------------------------
// Method: ConsoleLaunch
// Description
// Modified: 12/22/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($found)
If (Application type:C494#4D Server:K5:6)  // ### jwm ### 20190227_1734
	If (Count parameters:C259>0)
		C_TEXT:C284($1)
		Process_InitLocal
		C_LONGINT:C283($consoleWidth; $consoleHeight)
		$consoleWidth:=Num:C11(DefaultSetupsReturnValue("consoleWidth"))
		If ($consoleWidth<100)
			If ($consoleWidth=0)
				var $rec_ent : Object
				$rec_ent:=ds:C1482.DefaultSetup.query("variableName =  consoleWidth").first()
				If ($rec_ent=Null:C1517)
					DefaultSetupsCreate("consoleWidth"; "420"; "Is longInt"; ""; ""; "Override the width of the Console window, min 420")
				End if 
			End if 
			$consoleWidth:=420
		End if 
		$consoleHeight:=Num:C11(DefaultSetupsReturnValue("consoleHeight"))
		If ($consoleHeight<40)
			$consoleHeight:=84
		End if 
		var $obWindows : Object
		$obWindows:=WindowCountToShow
		//  Palette form window
		// Plain form window
		// Movable form dialog box
		$win_l:=Open form window:C675([Control:1]; "Console"; Plain form window:K39:10+On the right:K39:3; Screen width:C187-400; 53+$obWindows.topOffset)
		DIALOG:C40([Control:1]; "Console")
		CLOSE WINDOW:C154($win_l)
		
		
	Else 
		C_LONGINT:C283($found)
		$found:=Prs_CheckRunnin("Console")
		//
		If ($found>0)
			If (Frontmost process:C327#<>aPrsNum{$found})
				BRING TO FRONT:C326(<>aPrsNum{$found})
			End if 
		Else 
			If (Storage:C1525.process.console=Null:C1517)
				//Storage_Setup("console")
			End if 
			var $process : Integer
			$process:=New process:C317("ConsoleLaunch"; 0; "Console"; "launch")
			Use (Storage:C1525)
				Use (Storage:C1525.process)
					Storage:C1525.process.console:=$process
				End use 
			End use 
			//DELAY PROCESS(Current process; 360)
			///ConsoleMessage("Start: "+String(Current date)+": "+String(Current time))
		End if 
	End if 
End if 