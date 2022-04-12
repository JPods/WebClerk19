//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/28/16, 17:29:56
// ----------------------------------------------------
// Method: TallyMasterRecordsToTextSingle
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160929_1406 removed header
// ### jwm ### 20160929_1627 added consolemessage

C_TEXT:C284($1; $direction)

If (Count parameters:C259=1)
	$direction:=$1
Else 
	$direction:="IN"
End if 


C_LONGINT:C283(vHere)
C_POINTER:C301(ptcurTable)
Case of 
	: ($direction="Out")
		If (Records in selection:C76([TallyMaster:60])=0)
			ALL RECORDS:C47([TallyMaster:60])
		End if 
		C_TEXT:C284($theFolder; $nameText; $firstLine)
		C_LONGINT:C283($folderNew; $adder; $pCR)
		C_LONGINT:C283($recCnt; $recInc)
		C_TIME:C306($myDoc)
		$folderNew:=-4
		$adder:=0
		ConsoleLaunch
		// Storage.folder.jitDocs:=Storage.folder.jitF+"jitDocs"+Folder separator
		$theFolder:=FolderNameUnique_Utility(Storage:C1525.folder.jitDocs; "TMScripts")
		If ($theFolder#"")
			$recCnt:=Records in selection:C76([TallyMaster:60])
			FIRST RECORD:C50([TallyMaster:60])
			For ($recInc; 1; $recCnt)
				ConsoleMessage("Sending TM: "+String:C10([TallyMaster:60]idNum:4))
				//ExportScriptWithHeader ($theFolder;String([TallyMaster]UniqueID)+"_Script.txt";[TallyMaster]Name;[TallyMaster]Script)
				//ExportScriptWithHeader ($theFolder;String([TallyMaster]UniqueID)+"_Build.txt";[TallyMaster]Name;[TallyMaster]Build)
				//ExportScriptWithHeader ($theFolder;String([TallyMaster]UniqueID)+"_After.txt";[TallyMaster]Name;[TallyMaster]After)
				//ExportScriptWithHeader ($theFolder;String([TallyMaster]UniqueID)+"_HeadAdder.txt";[TallyMaster]Name;[TallyMaster]HeadAdder)
				// ### jwm ### 20160929_1319 removed header from script
				ExportScriptWithHeader($theFolder; String:C10([TallyMaster:60]idNum:4)+"_Script.txt"; ""; [TallyMaster:60]script:9)
				ExportScriptWithHeader($theFolder; String:C10([TallyMaster:60]idNum:4)+"_Build.txt"; ""; [TallyMaster:60]build:6)
				ExportScriptWithHeader($theFolder; String:C10([TallyMaster:60]idNum:4)+"_After.txt"; ""; [TallyMaster:60]after:7)
				ExportScriptWithHeader($theFolder; String:C10([TallyMaster:60]idNum:4)+"_HeadAdder.txt"; ""; [TallyMaster:60]template:29)
				
				NEXT RECORD:C51([TallyMaster:60])
			End for 
			If (Not:C34((vHere>1) & (ptcurTable=(->[TallyMaster:60]))))
				UNLOAD RECORD:C212([TallyMaster:60])
			End if 
		End if 
	: ($direction="In")
		C_TEXT:C284($pathname; $uniqueString)
		C_LONGINT:C283($p; $uniqueID)
		ARRAY TEXT:C222($arrayDocuments; 0)
		myDoc:=Open document:C264("")
		If (OK=1)
			CLOSE DOCUMENT:C267(myDoc)
			$pathname:=HFS_ParentName(document)
			ARRAY TEXT:C222($aListDocuments; 0)
			DOCUMENT LIST:C474($pathname; $arrayDocuments)
			$recCnt:=Size of array:C274($arrayDocuments)
			For ($recInc; 1; $recCnt)
				$p:=Position:C15("_"; $arrayDocuments{$recInc})
				If ($p>0)
					$uniqueID:=Num:C11(Substring:C12($arrayDocuments{$recInc}; 1; $p-1))
					QUERY:C277([TallyMaster:60]; [TallyMaster:60]idNum:4=$uniqueID)
					If (Records in selection:C76([TallyMaster:60])=1)
						ConsoleMessage("Importing TM: "+String:C10([TallyMaster:60]idNum:4))  // ### jwm ### 20160929_1627
						Case of 
							: (Position:C15("Script"; $arrayDocuments{$recInc})>0)
								[TallyMaster:60]script:9:=DocumentToText($pathname+$arrayDocuments{$recInc})
							: (Position:C15("_Build"; $arrayDocuments{$recInc})>0)
								[TallyMaster:60]build:6:=DocumentToText($pathname+$arrayDocuments{$recInc})
							: (Position:C15("_After"; $arrayDocuments{$recInc})>0)
								[TallyMaster:60]after:7:=DocumentToText($pathname+$arrayDocuments{$recInc})
							: (Position:C15("HeadAdder"; $arrayDocuments{$recInc})>0)
								[TallyMaster:60]template:29:=DocumentToText($pathname+$arrayDocuments{$recInc})
						End case 
						SAVE RECORD:C53([TallyMaster:60])
					End if 
				End if 
			End for 
		End if 
		UNLOAD RECORD:C212([TallyMaster:60])
	Else 
		ALERT:C41("Parameters must be equal to 'In' or 'Out'")
End case 

