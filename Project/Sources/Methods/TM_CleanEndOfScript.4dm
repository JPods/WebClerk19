//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 10/04/16, 22:06:36
// ----------------------------------------------------
// Method: TM_CleanEndOfScript
// Description
// 
//
// Parameters
// ----------------------------------------------------


ConsoleLaunch
ALL RECORDS:C47([TallyMaster:60])
// REDUCE SELECTION([TallyMaster];3)

FIRST RECORD:C50([TallyMaster:60])
vi2:=Records in selection:C76([TallyMaster:60])
For (vi1; 1; vi2)
	ConsoleMessage(String:C10([TallyMaster:60]idNum:4)+" "+[TallyMaster:60]name:8+" "+[TallyMaster:60]purpose:3)
	
	// Script
	vText:=[TallyMaster:60]script:9
	vText:=Replace string:C233(vText; Storage:C1525.char.crlf; "\r")
	vText:=Replace string:C233(vText; "\n"; "\r")
	viLength:=Length:C16(vText)
	If (viLength>0)
		viContinue:=1
		While (viContinue=1)
			Case of 
				: (viLength=1)
					If (vText[[viLength]]="\r")
						vText:=""
						[TallyMaster:60]script:9:=vText
						
					End if 
					viContinue:=0
					SAVE RECORD:C53([TallyMaster:60])
				: (viLength>1)
					If (vText[[viLength]]="\r")
						vText:=Substring:C12(vText; 1; viLength-1)
					Else 
						vicontinue:=0
					End if 
			End case 
			viLength:=Length:C16(vText)
			
		End while 
		If (viLength>0)
			vText:=vText+"\r"
			[TallyMaster:60]script:9:=vText
		End if 
		SAVE RECORD:C53([TallyMaster:60])
	End if 
	
	// Build
	vText:=[TallyMaster:60]build:6
	vText:=Replace string:C233(vText; Storage:C1525.char.crlf; "\r")
	vText:=Replace string:C233(vText; "\n"; "\r")
	viLength:=Length:C16(vText)
	If (viLength>0)
		viContinue:=1
		While (viContinue=1)
			Case of 
				: (viLength=1)
					If (vText[[viLength]]="\r")
						vText:=""
						[TallyMaster:60]build:6:=vText
						
					End if 
					viContinue:=0
					SAVE RECORD:C53([TallyMaster:60])
				: (viLength>1)
					If (vText[[viLength]]="\r")
						vText:=Substring:C12(vText; 1; viLength-1)
					Else 
						vicontinue:=0
					End if 
			End case 
			viLength:=Length:C16(vText)
			
		End while 
		If (viLength>0)
			vText:=vText+"\r"
			[TallyMaster:60]build:6:=vText
		End if 
		SAVE RECORD:C53([TallyMaster:60])
	End if 
	
	NEXT RECORD:C51([TallyMaster:60])
End for 

