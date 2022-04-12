
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/18/18, 11:28:13
// ----------------------------------------------------
// Method: [TechNote].Input.Variable20
// Description
// grgrgrgr  tranfer by from v40
//
// Parameters
// ----------------------------------------------------


Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(ailoText15; 10)
		ailoText15{1}:="Actions for external documents"
		ailoText15{2}:="Set folder dialog"
		ailoText15{3}:="Open current path"
		ailoText15{4}:="Open server path"
		ailoText15{5}:="Open local path"
		ailoText15{6}:="Set path to server path"
		ailoText15{7}:="Set path to local path"
		ailoText15{8}:="Open in outside editor"
		ailoText15{9}:="Save from outside editor"
		ailoText15{10}:="Save to jitHelp for web use"
		// ailoText15{11}:="DocPaths for Chapter pages/images"
		ailoText15:=1
		
		C_TEXT:C284(<>TextEditor; <>Browser)
		If (<>TextEditor="")
			<>TextEditor:=DefaultSetupsReturnValue("<>TextEditor"; Current machine:C483)
			If (<>TextEditor="noRecord")
				DSCreateRecord("<>TextEditor"; "BBEdit"; "Is text"; "Opening text documents in a text editor.")
				<>TextEditor:=DefaultSetupsReturnValue("<>TextEditor"; Current machine:C483)
			End if 
		End if 
		
		If (<>Browser="")
			<>Browser:=DefaultSetupsReturnValue("<>Browser"; Current machine:C483)
			If (<>Browser="noRecord")
				DSCreateRecord("<>Browser"; "Google Chrome"; "Is text"; "Opening text documents in a text editor.")
				<>Browser:=DefaultSetupsReturnValue("<>TextEditor"; Current machine:C483)
			End if 
		End if 
		
		
		
	: (Form event code:C388=On Data Change:K2:15)
		C_LONGINT:C283($viAction)
		$viAction:=ailoText15
		ailoText15:=1
		Case of 
			: ($viAction=2)
				vtTNPathSystem:=Select folder:C670("Select folder destination.")
				
			: ($viAction=3)  // current open
				CREATE FOLDER:C475(vtTNPathSystem; *)
				PathLaunchFolder(vtTNPathSystem)
				
			: ($viAction=4)  // server open
				PathLaunchFolder(<>jitHelpServer)
				
			: ($viAction=5)  // local open
				PathLaunchFolder(<>jitHelpLocal)
				
			: ($viAction=6)  // set Server path
				<>jitHelpFolder:=<>jitHelpServer
				$theChapterFolder:="Chap_"+String:C10([TechNote:58]Chapter:14; "000")
				vtTNPathSystem:=<>jitHelpFolder+"technotes"+<>FOLDERSEPARATOR+$theChapterFolder+<>FOLDERSEPARATOR+"images"+<>FOLDERSEPARATOR
				
			: ($viAction=7)  // set Local path
				<>jitHelpFolder:=<>jitHelpLocal
				$theChapterFolder:="Chap_"+String:C10([TechNote:58]Chapter:14; "000")
				vtTNPathSystem:=<>jitHelpFolder+"technotes"+<>FOLDERSEPARATOR+$theChapterFolder+<>FOLDERSEPARATOR+"images"+<>FOLDERSEPARATOR
				
			: ($viAction=8)  // open in outside editor
				
				C_LONGINT:C283(bSaveText; bOpenText)
				C_TEXT:C284(vtDraftPath)
				
				C_TEXT:C284($theText)
				[TechNote:58]BodyText:23:=TNCaptureWebArea
				$theText:=[TechNote:58]BodyText:23
				If ($theText#"")
					C_TEXT:C284($draftsFolder)
					$theChapterFolder:="Chap_"+String:C10([TechNote:58]Chapter:14; "000")
					$draftsFolder:=<>jitHelpFolder+"technotes"+<>FOLDERSEPARATOR+$theChapterFolder+<>FOLDERSEPARATOR+"drafts"+<>FOLDERSEPARATOR
					CREATE FOLDER:C475($draftsFolder; *)
					
					vtDraftPath:=$draftsFolder+[TechNote:58]Name:2+".txt"
					
					C_TEXT:C284($outputText)
					
					$outputText:=TNHTMLheaderFooter([TechNote:58]BodyText:23; "TechNoteTemplate"; "Admin"; 1; "_jit_TechNotes_Namejj")
					
					TEXT TO DOCUMENT:C1237(vtDraftPath; $outputText)
					ConsoleMessage("Document created: "+vtDraftPath)
					If (OK=1)
						OPEN URL:C673(vtDraftPath; <>TextEditor)
					End if 
				End if 
				
			: ($viAction=9)  // load from outside editor
				C_TEXT:C284($outputText; $textHead; $textFoot; $clipText)
				$clipText:="<!--ContentClip-->"
				
				$theChapterFolder:="Chap_"+String:C10([TechNote:58]Chapter:14; "000")
				$draftsFolder:=<>jitHelpFolder+"technotes"+<>FOLDERSEPARATOR+$theChapterFolder+<>FOLDERSEPARATOR+"drafts"+<>FOLDERSEPARATOR
				vtDraftPath:=$draftsFolder+[TechNote:58]Name:2+".txt"
				
				C_TEXT:C284($theText)
				C_LONGINT:C283($foundClip)
				If (vtDraftPath#"")
					If (Test path name:C476(vtDraftPath)=1)
						$theText:=Document to text:C1236(vtDraftPath; 3)
						CONFIRM:C162("Load external text file into Body?")
						If (OK=1)
							$foundClip:=Position:C15($clipText; $theText)
							If ($foundClip>0)
								$theText:=Substring:C12($theText; $foundClip+Length:C16($clipText)+1)  // clip <>vCR
								$foundClip:=Position:C15($clipText; $theText)
								If ($foundClip>0)
									$theText:=Substring:C12($theText; 1; $foundClip-2)  // clip <>vCR
								End if 
							End if 
							[TechNote:58]BodyText:23:=$theText
							TNToWebAreaBody
						End if 
					End if 
				End if 
				
			: ($viAction=10)  //  "Save to jitHelp for web use"
				TNSaveForWeb
				If (OK=1)
					OPEN URL:C673(vtDraftPath; <>Browser)
					// LAUNCH EXTERNAL PROCESS($draftsFolder)
				End if 
				
			: ($viAction=11)
				// grgrgrgr
				// FIXTHIS
		End case 
End case 