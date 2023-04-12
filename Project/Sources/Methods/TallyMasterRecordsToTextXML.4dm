//%attributes = {}


// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/26/16, 13:02:58
// ----------------------------------------------------
// Method: TallyMasterRecordsToTextXML
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ----------------------------------------------------

ConsoleLog("Launch")
C_TEXT:C284($1; $sendDirection)
C_TEXT:C284($2; $directionTable)

C_LONGINT:C283($uniqueID)
C_TEXT:C284($action)
C_LONGINT:C283($pBegin; $pEnd)
C_TEXT:C284($workingText; $stringRec)
C_TEXT:C284($textFromClipBoard)
If (Count parameters:C259=2)
	$sendDirection:=$1
	$directionTable:=$2
Else 
	$sendDirection:="TextIn"
	$directionTable:="UserReports"
	
	If (False:C215)
		
		$sendDirection:="TextOut"
		$directionTable:="TallyMaster"
		
		$sendDirection:="TextIn"
		$directionTable:="TallyMaster"
		
		$sendDirection:="TextOut"
		$directionTable:="CronJobs"
		
		$sendDirection:="TextIn"
		$directionTable:="CronJobs"
		
		$sendDirection:="TextOut"
		$directionTable:="UserReports"
		
		$sendDirection:="TextIn"
		$directionTable:="UserReports"
	End if 
End if 

vtext2:=""
vText9:="Case of"+"\r"+"\r"+"// <Record Export "+$directionTable+"\r"+"\r"
vText10:=""
vText11:="Case of"+"\r"+":($2="+Txt_Quoted("Script")+")"+"\r"
vText12:=":($2="+Txt_Quoted("Build")+")"+"\r"
vText13:=":($2="+Txt_Quoted("After")+")"+"\r"
vText14:=":($2="+Txt_Quoted("HeadAdder")+")"+"\r"
vText15:="End Case"+"\r"


Case of 
	: ($directionTable="TallyMaster")
		If ($sendDirection="TextOut")
			//  QUERY([TallyMaster];[TallyMaster]Purpose="cronjob")
			If (Records in selection:C76([TallyMaster:60])=0)  // ### jwm ### 20160926_1348 use current selection
				ALL RECORDS:C47([TallyMaster:60])
			End if 
			vi2:=Records in selection:C76([TallyMaster:60])
			FIRST RECORD:C50([TallyMaster:60])
			vtext2:=vText9
			For (vi1; 1; vi2)
				ConsoleLog("Sending TM: "+String:C10([TallyMaster:60]idNum:4))
				vtext1:=""
				[TallyMaster:60]script:9:=Tx_ConvertScripts([TallyMaster:60]script:9)
				[TallyMaster:60]build:6:=Tx_ConvertScripts([TallyMaster:60]build:6)
				[TallyMaster:60]after:7:=Tx_ConvertScripts([TallyMaster:60]after:7)
				[TallyMaster:60]template:29:=Tx_ConvertScripts([TallyMaster:60]template:29)
				SAVE RECORD:C53([TallyMaster:60])
				
				vtext1:=vtext1+"\r"+"\r"+":($1="+String:C10([TallyMaster:60]idNum:4)+")"+"\r"
				vtext1:=vtext1+"// <RecordExport>"+"\r"
				vtext1:=vtext1+"// <Table>TallyMasters</Table>"+"\r"
				vtext1:=vtext1+"// <UniqueID>"+String:C10([TallyMaster:60]idNum:4)+"</UniqueID>"+"\r"
				vtext1:=vtext1+"// Purpose:"+[TallyMaster:60]purpose:3+"\r"
				vtext1:=vtext1+"// Name: "+[TallyMaster:60]name:8+"\r"
				vtext1:=vtext1+"// Status: "+[TallyMaster:60]status:33+"\r"
				vtext1:=vtext1+"\r"+"//  ###############  <action>Import</action>  ###############"+"\r"
				If ([TallyMaster:60]script:9="")
					//[TallyMaster]Script:="//empty"
				End if 
				If ([TallyMaster:60]build:6="")
					//[TallyMaster]Build:="//empty"
				End if 
				If ([TallyMaster:60]after:7="")
					//[TallyMaster]After:="//empty"
				End if 
				If ([TallyMaster:60]template:29="")
					//[TallyMaster]Template:="//empty"
				End if 
				vtext1:=vtext1+"\r"+vText11+"\r"+"// <script>\r"+[TallyMaster:60]script:9+"\r  // </script>"+"\r"
				vtext1:=vtext1+"\r"+vText12+"\r"+"// <build>\r"+[TallyMaster:60]build:6+"\r  // </build>"+"\r"
				vtext1:=vtext1+"\r"+vText13+"\r"+"// <after>\r"+[TallyMaster:60]after:7+"\r  // </after>"+"\r"
				vtext1:=vtext1+"\r"+vText14+"\r"+"// <template>\r"+[TallyMaster:60]template:29+"\r  // </template>"+"\r"
				vtext1:=vtext1+"\r"+"\r"+"End Case"+"\r"+"\r"
				vtext1:=vtext1+"// </RecordExport>"
				vtext1:=vtext1+"\r"+"\r"+"\r"
				NEXT RECORD:C51([TallyMaster:60])
				vtext2:=vtext2+"\r"+"\r"+vtext1
				SET TEXT TO PASTEBOARD:C523(vtext2)
			End for 
			UNLOAD RECORD:C212([TallyMaster:60])
			vtext2:=vtext2+"\r"+"\r"+"\r"+vText15
			SET TEXT TO PASTEBOARD:C523(vtext2)
			ALERT:C41("Exported Scripts Copied to Pasteboard")
		Else 
			$textFromClipBoard:=Get text from pasteboard:C524
			vText3:=""
			$pBegin:=Length:C16($textFromClipBoard)  // process if there is text
			If ($pBegin>0)
				$pEnd:=Position:C15("</recordExport>"; $textFromClipBoard)
				While ($pEnd>0)
					$pEnd:=Position:C15("</recordExport>"; $textFromClipBoard)
					If ($pEnd>0)
						$workingText:=Tx_ClipBetween($textFromClipBoard; "<RecordExport>"; "</RecordExport>")
						$textFromClipBoard:=Substring:C12($textFromClipBoard; $pEnd+16)  // clip past CR
						If (Length:C16($workingText)>0)
							$action:=Tx_ClipBetween($workingText; "<action>"; "</action>")
							If ($action="Import")
								$stringRec:=Tx_ClipBetween($workingText; "<UniqueID"; "</UniqueID>")
								$uniqueID:=Num:C11($stringRec)
								$script:=Tx_ClipBetween($workingText; "// <script>\r"; "\r  // </script>")
								$build:=Tx_ClipBetween($workingText; "// <build>\r"; "\r  // </build>")
								$after:=Tx_ClipBetween($workingText; "// <after>\r"; "\r  // </after>")
								$header:=Tx_ClipBetween($workingText; "// <template>\r"; "\r  // </template>")
								QUERY:C277([TallyMaster:60]; [TallyMaster:60]idNum:4=$uniqueID)
								If (Records in selection:C76([TallyMaster:60])=1)
									[TallyMaster:60]script:9:=$script
									[TallyMaster:60]build:6:=$build
									[TallyMaster:60]after:7:=$after
									[TallyMaster:60]template:29:=$header
									[TallyMaster:60]dateRevision:32:=Current date:C33
									SAVE RECORD:C53([TallyMaster:60])
									UNLOAD RECORD:C212([TallyMaster:60])
									ConsoleLog("Updates TM: "+$stringRec)
								End if 
							End if 
						End if 
					End if 
					
				End while 
			End if 
			ConsoleLog("Import Complete")
			ALERT:C41("Import Complete")
		End if 
	: ($directionTable="UserReports")
		If ($sendDirection="TextOut")
			vText11:="Case of"+"\r"+":($2="+Txt_Quoted("ScriptBegin")+")"+"\r"
			vText12:=":($2="+Txt_Quoted("ScriptEnd")+")"+"\r"
			vText13:=":($2="+Txt_Quoted("ScriptExecute")+")"+"\r"
			vText14:=":($2="+Txt_Quoted("ScriptLoop")+")"+"\r"
			
			QUERY:C277([UserReport:46]; [UserReport:46]scriptBegin:5#"")
			vi2:=Records in selection:C76([UserReport:46])
			FIRST RECORD:C50([UserReport:46])
			vtext2:=vText9
			For (vi1; 1; vi2)
				ConsoleLog("Sending UserReport: "+String:C10([UserReport:46]idNum:17))
				vtext1:=""
				[UserReport:46]scriptBegin:5:=Tx_ConvertScripts([UserReport:46]scriptBegin:5)
				[UserReport:46]scriptEnd:38:=Tx_ConvertScripts([UserReport:46]scriptEnd:38)
				[UserReport:46]scriptLoop:34:=Tx_ConvertScripts([UserReport:46]scriptLoop:34)
				SAVE RECORD:C53([UserReport:46])
				
				vtext1:=vtext1+"\r"+"\r"+":($1="+String:C10([UserReport:46]idNum:17)+")"+"\r"
				vtext1:=vtext1+"// <RecordExport>"+"\r"
				vtext1:=vtext1+"// <Table>UserReports</Table>"+"\r"
				vtext1:=vtext1+"// <UniqueID>"+String:C10([UserReport:46]idNum:17)+"</UniqueID>"+"\r"
				vtext1:=vtext1+"// Name: "+[UserReport:46]name:2+"\r"
				vtext1:=vtext1+"// Status: "+[UserReport:46]status:33+"\r"
				vtext1:=vtext1+"\r"+"//  ###############  <action>Import</action>  ###############"+"\r"
				vtext1:=vtext1+"\r"+vText11+"\r"+"// <ScriptBegin>\r"+[UserReport:46]scriptBegin:5+"\r  // </ScriptBegin>"+"\r"
				vtext1:=vtext1+"\r"+vText12+"\r"+"// <ScriptEnd>\r"+[UserReport:46]scriptEnd:38+"\r  // </ScriptEnd>"+"\r"
				vtext1:=vtext1+"\r"+vText14+"\r"+"// <ScriptLoop>\r"+[UserReport:46]scriptLoop:34+"\r  // </ScriptLoop>"+"\r"
				vtext1:=vtext1+"\r"+"\r"+"End Case"+"\r"+"\r"
				vtext1:=vtext1+"// </RecordExport>"
				NEXT RECORD:C51([UserReport:46])
				vtext2:=vtext2+"\r"+"\r"+vtext1
			End for 
			UNLOAD RECORD:C212([UserReport:46])
			vtext2:=vtext2+"\r"+"\r"+"\r"+vText15
			SET TEXT TO PASTEBOARD:C523(vtext2)
			ALERT:C41("Exported Scripts Copied to Pasteboard")
			
		Else 
			C_TEXT:C284($script; $after; $build; $header)
			$textFromClipBoard:=Get text from pasteboard:C524
			
			$pBegin:=Length:C16($textFromClipBoard)  // process if there is text
			If ($pBegin>0)
				$pEnd:=Position:C15("</recordExport>"; $textFromClipBoard)
				While ($pEnd>0)
					$pEnd:=Position:C15("</recordExport>"; $textFromClipBoard)
					If ($pEnd>0)
						$workingText:=Tx_ClipBetween($textFromClipBoard; "<RecordExport>"; "</RecordExport>")
						$textFromClipBoard:=Substring:C12($textFromClipBoard; $pEnd+16)  // clip past CR
						If (Length:C16($workingText)>0)
							$action:=Tx_ClipBetween($workingText; "<action>"; "</action>")
							If ($action="Import")
								$stringRec:=Tx_ClipBetween($workingText; "<UniqueID"; "</UniqueID>")
								$uniqueID:=Num:C11($stringRec)
								$script:=Tx_ClipBetween($workingText; "// <ScriptBegin>\r"; "\r  // </ScriptBegin>")
								$build:=Tx_ClipBetween($workingText; "// <ScriptEnd>\r"; "\r  // </ScriptEnd>")
								$header:=Tx_ClipBetween($workingText; "// <ScriptLoop>\r"; "\r  // </ScriptLoop>")
								
								QUERY:C277([UserReport:46]; [UserReport:46]idNum:17=$uniqueID)
								If (Records in selection:C76([UserReport:46])=1)
									[UserReport:46]scriptBegin:5:=$script
									[UserReport:46]scriptEnd:38:=$build
									[UserReport:46]scriptLoop:34:=$header
									[UserReport:46]dtLastSync:39:=DateTime_DTTo
									SAVE RECORD:C53([UserReport:46])
									UNLOAD RECORD:C212([UserReport:46])
									ConsoleLog("Updates UserReport: "+$stringRec)
								End if 
							End if 
						End if 
					End if 
				End while 
				ConsoleLog("Import Complete")
				ALERT:C41("Import Complete")
			End if 
		End if 
	: ($directionTable="CronJobs")
		If ($sendDirection="TextOut")
			vi2:=Records in selection:C76([CronJob:82])
			FIRST RECORD:C50([CronJob:82])
			vtext2:=vText9
			For (vi1; 1; vi2)
				ConsoleLog("Sending TM: "+String:C10([CronJob:82]idNum:1))
				vtext1:=""
				[CronJob:82]script:11:=Tx_ConvertScripts([CronJob:82]script:11)
				[CronJob:82]scriptAfter:25:=Tx_ConvertScripts([CronJob:82]scriptAfter:25)
				SAVE RECORD:C53([CronJob:82])
				
				vtext1:=vtext1+"\r"+"\r"+":($1="+String:C10([CronJob:82]idNum:1)+")"+"\r"
				vtext1:=vtext1+"// <RecordExport>"+"\r"
				vtext1:=vtext1+"// <Table>CronJobs</Table>"+"\r"
				vtext1:=vtext1+"// <UniqueID>"+String:C10([CronJob:82]idNum:1)+"</UniqueID>"+"\r"
				vtext1:=vtext1+"// Name: "+[CronJob:82]eventName:15+"\r"
				vtext1:=vtext1+"// Status: "+[CronJob:82]comment:23+"\r"
				vtext1:=vtext1+"\r"+"//  ###############  <action>Import</action>  ###############"+"\r"
				vtext1:=vtext1+"\r"+vText11+"\r"+"// <Script>\r"+[CronJob:82]script:11+"\r  // </Script>"+"\r"
				vtext1:=vtext1+"\r"+vText12+"\r"+"// <ScriptAfter>\r"+[CronJob:82]scriptAfter:25+"\r  // </ScriptAfter>"+"\r"
				//vtext1:=vtext1+"\r"+vText12+"\r"+"// <ScriptTemplate>"+[CronJob]+"// </ScriptTemplate>"+"\r"
				vtext1:=vtext1+"\r"+"\r"+"End Case"+"\r"+"\r"
				NEXT RECORD:C51([CronJob:82])
				vtext2:=vtext2+"\r"+"\r"+vtext1
			End for 
			UNLOAD RECORD:C212([CronJob:82])
			vtext2:=vtext2+"\r"+"End Case"
			SET TEXT TO PASTEBOARD:C523(vtext2)
			ALERT:C41("Exported Scripts Copied to Pasteboard")
		Else 
			C_TEXT:C284($script; $after; $build; $header)
			$textFromClipBoard:=Get text from pasteboard:C524
			
			$pBegin:=Length:C16($textFromClipBoard)  // process if there is text
			If ($pBegin>0)
				$pEnd:=Position:C15("</recordExport>"; $textFromClipBoard)
				While ($pEnd>0)
					$pEnd:=Position:C15("</recordExport>"; $textFromClipBoard)
					If ($pEnd>0)
						$workingText:=Tx_ClipBetween($textFromClipBoard; "<RecordExport>"; "</RecordExport>")
						$textFromClipBoard:=Substring:C12($textFromClipBoard; $pEnd+16)  // clip past CR
						If (Length:C16($workingText)>0)
							$action:=Tx_ClipBetween($workingText; "<action>"; "</action>")
							If ($action="Import")
								$stringRec:=Tx_ClipBetween($workingText; "<UniqueID"; "</UniqueID>")
								$uniqueID:=Num:C11($stringRec)
								$script:=Tx_ClipBetween($workingText; "// <Script>\r"; "\r  // </Script>")
								$build:=Tx_ClipBetween($workingText; "// <ScriptAfter>\r"; "\r  // </ScriptAfter>")
								//$header:=Tx_ClipBetween ($workingText;"// <ScriptTemplate>\r";"\r// </ScriptTemplate>")
								
								QUERY:C277([CronJob:82]; [CronJob:82]idNum:1=$uniqueID)
								If (Records in selection:C76([CronJob:82])=1)
									[CronJob:82]script:11:=$script
									[CronJob:82]scriptAfter:25:=$build
									//[CronJob]Template:=$header
									//[CronJob]DateRevision:=Current date
									SAVE RECORD:C53([CronJob:82])
									UNLOAD RECORD:C212([CronJob:82])
									ConsoleLog("Updates CronJobs: "+$stringRec)
								End if 
							End if 
						End if 
					End if 
				End while 
				ConsoleLog("Import Complete")
				ALERT:C41("Import Complete")
			End if 
		End if 
End case 
