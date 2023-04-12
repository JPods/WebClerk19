//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-08-01T00:00:00, 22:50:59
// ----------------------------------------------------
// Method: TallyMasterRecordsToText
// Description
// Modified: 08/01/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

ConsoleLaunch

//Console_Log ("Launch")
C_TEXT:C284($1; $sendDirection)
C_TEXT:C284($2; $directionTable)
C_LONGINT:C283($countLoop)
If (Count parameters:C259=2)
	$sendDirection:=$1
	$directionTable:=$2
Else 
	$sendDirection:="TextIn"
	$directionTable:="TallyMaster"
	
	If (False:C215)
		
		$sendDirection:="TextIn"
		$directionTable:="TallyMaster"
		
		$sendDirection:="TextOut"
		$directionTable:="TallyMaster"
		
		$sendDirection:="TextIn"
		$directionTable:="TallyMaster"
		
		$sendDirection:="TextOut"
		$directionTable:="CronJobs"
		
		$sendDirection:="TextIn"
		$directionTable:="CronJobs"
	End if 
End if 

vtext2:=""
vText9:="Case of"+"\r"
vText11:="Case of"+"\r"+":($2="+Txt_Quoted("Script")+")"+"\r"
vText12:=":($2="+Txt_Quoted("Build")+")"+"\r"
vText13:=":($2="+Txt_Quoted("After")+")"+"\r"
vText14:=":($2="+Txt_Quoted("HeadAdder")+")"+"\r"
vText15:="End Case"+"\r"
vText16:="  // Script cleaned 20160802"+"\r"

Case of 
	: ($sendDirection="TextOut")
		Case of 
			: ($directionTable="TallyMaster")
				vi2:=Records in selection:C76([TallyMaster:60])
				FIRST RECORD:C50([TallyMaster:60])
				vtext2:=vText9
				For (vi1; 1; vi2)
					vtext1:=""
					[TallyMaster:60]script:9:=Tx_ConvertScripts([TallyMaster:60]script:9)
					[TallyMaster:60]build:6:=Tx_ConvertScripts([TallyMaster:60]build:6)
					[TallyMaster:60]after:7:=Tx_ConvertScripts([TallyMaster:60]after:7)
					[TallyMaster:60]template:29:=Tx_ConvertScripts([TallyMaster:60]template:29)
					SAVE RECORD:C53([TallyMaster:60])
					
					ConsoleLog("Text Out: TM"+String:C10([TallyMaster:60]idNum:4))  // ### jwm ### 20160802_1616
					
					vtext1:=vtext1+"\r"+"\r"+":($1="+String:C10([TallyMaster:60]idNum:4)+")"+"\r"
					vText10:="  // "+[TallyMaster:60]purpose:3+":_:"+[TallyMaster:60]name:8+":_:"+[TallyMaster:60]status:33
					vtext1:=vtext1+"\r"+vText10+"\r"
					vtext1:=vtext1+"ConsoleLog("+Txt_Quoted("TM"+String:C10([TallyMaster:60]idNum:4)+": "+[TallyMaster:60]status:33)+")"+"\r"+"\r"
					vtext1:=vtext1+"\r"+vText11+vText16+[TallyMaster:60]script:9+"\r"
					vtext1:=vtext1+"\r"+vText12+[TallyMaster:60]build:6+"\r"
					vtext1:=vtext1+"\r"+vText13+[TallyMaster:60]after:7+"\r"
					vtext1:=vtext1+"\r"+vText14+[TallyMaster:60]template:29+"\r"
					vtext1:=vtext1+"\r"+vText15
					NEXT RECORD:C51([TallyMaster:60])
					
					vtext2:=vtext2+"\r"+"\r"+vtext1
					//SET TEXT TO PASTEBOARD(vtext2)  // ### jwm ### 20160923_0922 not needed every pass through the loop
				End for 
				vtext2:=vtext2+"\r"+"\r"+"\r"+vText15
				SET TEXT TO PASTEBOARD:C523(vtext2)
				ALERT:C41("Copied Text to Pasteboard")
			: ($directionTable="CronJobs")
				vi2:=Records in selection:C76([CronJob:82])
				FIRST RECORD:C50([CronJob:82])
				vtext2:=vText9
				For (vi1; 1; vi2)
					vtext1:=""
					[CronJob:82]script:11:=Tx_ConvertScripts([CronJob:82]script:11)
					[CronJob:82]scriptAfter:25:=Tx_ConvertScripts([CronJob:82]scriptAfter:25)
					SAVE RECORD:C53([CronJob:82])
					
					vtext1:=vtext1+"\r"+"\r"+":($1="+String:C10([CronJob:82]idNum:1)+")"+"\r"
					vText10:="  // "+[CronJob:82]nameID:10+":_:"+[CronJob:82]machineName:22+":_:"+[CronJob:82]cronString:28
					vtext1:=vtext1+"\r"+vText10+"\r"
					vtext1:=vtext1+"ConsoleLog("+Txt_Quoted("CR"+String:C10([CronJob:82]idNum:1)+": "+[CronJob:82]nameID:10)+")"+"\r"+"\r"
					vtext1:=vtext1+"\r"+vText11+[CronJob:82]script:11+"\r"
					vtext1:=vtext1+"\r"+vText13+[CronJob:82]scriptAfter:25+"\r"
					vtext1:=vtext1+"\r"+vText15
					NEXT RECORD:C51([CronJob:82])
					
					vtext2:=vtext2+"\r"+"\r"+vtext1
					SET TEXT TO PASTEBOARD:C523(vtext2)
				End for 
				vtext2:=vtext2+"\r"+"\r"+"\r"+vText15
				SET TEXT TO PASTEBOARD:C523(vtext2)
				ALERT:C41("Copied Text to Pasteboard")
				
				
		End case 
	: ($sendDirection="TextIn")
		vText3:=""
		vtext2:=Get text from pasteboard:C524
		C_TEXT:C284($workingText; $recordText; $scriptText; $afterScript; $buildScript; $headerScript; $tagScript; $tagBuild; $tagAfter; $tagHead; $recordText; $stringRec)
		C_TEXT:C284($workingEnd; $scriptEnd; $buildEnd; $afterEnd; $headEnd)
		C_LONGINT:C283($pscript; $pBuild; $pAfter; $pHead; $tagScriptLength; $tagBuildLength; $tagAfterLength; $tagHeadLength)
		C_LONGINT:C283($countLoops; $endLoop)
		C_LONGINT:C283($tagScriptLength; $tagBuildLength; $tagAfterLength; $tagHeadLength; $precNum)
		C_LONGINT:C283($startClip; $endClip)
		C_TEXT:C284($theClip)
		
		$tagScript:="($2="+Txt_Quoted("Script")+")"
		$tagScriptLength:=Length:C16($tagScript)
		$tagBuild:="($2="+Txt_Quoted("Build")+")"
		$tagBuildLength:=Length:C16($tagBuild)
		$tagAfter:="($2="+Txt_Quoted("After")+")"
		$tagAfterLength:=Length:C16($tagAfter)
		$tagHead:="($2="+Txt_Quoted("HeadAdder")+")"
		$tagHeadLength:=Length:C16($tagHead)
		$workingText:=vtext2
		C_LONGINT:C283($p)
		$p:=Position:C15("($1="; $workingText)
		If ($p>0)
			//get the first blocks of text
			$workingText:=Substring:C12($workingText; $p+4)
			$p:=Position:C15("($1="; $workingText)
			If ($p>0)
				$recordText:=Substring:C12($workingText; 1; $p-2)
				$workingText:=Substring:C12($workingText; $p+4; Length:C16($workingText)-23)
				$workingEnd:=Substring:C12($workingText; Length:C16($workingText)-20)
			Else 
				$recordText:=$workingText
			End if 
			$precNum:=Position:C15(")"; $recordText)
			$stringRec:=Substring:C12($recordText; 1; $precNum-1)
			
			Repeat 
				$countLoop:=$countLoop+1
				
				$p:=Position:C15(")"; $recordText)
				$stringRec:=Substring:C12($recordText; 1; $p-1)
				
				Case of 
					: ($directionTable="TallyMaster")
						$pscript:=Position:C15($tagScript; $recordText)
						$pBuild:=Position:C15($tagBuild; $recordText)  // get the start of the next segment
						$pAfter:=Position:C15($tagAfter; $recordText)  // get the start of the next segment
						$pHead:=Position:C15($tagHead; $recordText)  // get the start of the next segment
						
						C_LONGINT:C283($startClip; $endClip)
						C_TEXT:C284($theClip)
						$startClip:=$pscript+$tagScriptLength+1
						$endClip:=$pBuild-$pscript-$tagScriptLength-6
						
						$scriptText:=Substring:C12($recordText; $startClip; $endClip)
						$scriptEnd:=Substring:C12($scriptText; Length:C16($scriptText)-30)
						// 
						$startClip:=$pBuild+$tagBuildLength+1
						$endClip:=$pAfter-$pBuild-$tagBuildLength-5
						$buildScript:=Substring:C12($recordText; $startClip; $endClip)
						$buildEnd:=Substring:C12($buildScript; Length:C16($buildScript)-30)
						//
						$startClip:=$pAfter+$tagAfterLength+1
						$endClip:=$pHead-$pAfter-$tagAfterLength-5
						$afterScript:=Substring:C12($recordText; $startClip; $endClip)
						$afterEnd:=Substring:C12($afterScript; Length:C16($afterScript)-30)
						
						$startClip:=$pHead+$tagHeadLength+1
						$endClip:=Length:C16($recordText)-$pHead-$tagHeadLength-17
						$headerScript:=Substring:C12($recordText; $startClip; $endClip)
						$headEnd:=Substring:C12($headerScript; Length:C16($headerScript)-30)
						
						QUERY:C277([TallyMaster:60]; [TallyMaster:60]idNum:4=Num:C11($stringRec))
						If (Records in selection:C76([TallyMaster:60])=1)
							[TallyMaster:60]script:9:=$scriptText
							[TallyMaster:60]build:6:=$buildScript
							[TallyMaster:60]after:7:=$afterScript
							[TallyMaster:60]template:29:=vText16+$headerScript
							// add some status
							SAVE RECORD:C53([TallyMaster:60])
							UNLOAD RECORD:C212([TallyMaster:60])
							ConsoleLog("Updates TM: "+$stringRec)
						End if 
						
						// vText3:=$scriptText+"\r"+"\r"+"\r"+"\r"+$buildScript+"\r"+"\r"+"\r"+"\r"+$afterScript+"\r"+"\r"+"\r"+"\r"+$headerScript
						// SET TEXT TO PASTEBOARD(vText3)
						
					: ($directionTable="CronJobs")
						$pscript:=Position:C15($tagScript; $recordText)
						$pBuild:=Position:C15($tagBuild; $recordText)
						$pAfter:=Position:C15($tagAfter; $recordText)
						$pHead:=Position:C15($tagHead; $recordText)
						
				End case 
				$recordText:=""
				$p:=Position:C15("($1="; $workingText)
				If ($p<1)
					// finish last record
					$recordText:=$workingText
					$workingText:=""
				Else 
					$recordText:=Substring:C12($workingText; 1; $p-2)
					$workingText:=Substring:C12($workingText; $p+4)
				End if 
			Until (($workingText="") & ($recordText=""))
		End if 
End case 
