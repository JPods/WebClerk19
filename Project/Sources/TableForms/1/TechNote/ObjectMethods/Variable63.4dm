
//Script: eTNList   //Monday, November 2, 1998  add double option click
C_LONGINT:C283($error; $i; $sizeSelect)
C_LONGINT:C283($areaList; $event)

//  CHOPPED  $event:=AL_GetAreaLongProperty(Self->; ALP_Area_AlpEvent)
Case of 
	: (Form event code:C388=On Load:K2:1)
		TechNoteAreaListDefine
		
	: (Form event code:C388#Null event:K17:1)
		If ((ALProEvt=1) | (ALProEvt=2))
			KeyModifierCurrent
			ARRAY LONGINT:C221(aTNRecSel; 0)
			//  CHOPPED  $error:=AL_GetSelect(eTNList; aTNRecSel)
			GOTO RECORD:C242([TechNote:58]; aTNRec{aTNRecSel{1}})
			TN_LastVisitArray(0)  //
			
			
			TNToWebAreaBody("WebArea")
			
			
			If (False:C215)
				<>TechNoteOption:=1
				Case of 
					: (<>TechNoteOption=1)
						C_TEXT:C284($theText; $theURL)
						$theText:="Chap_"+String:C10([TechNote:58]chapter:14; "000")
						$theURL:="file:///"+<>jitHelpFolder+"technotes/"+$theText+"/"+String:C10([TechNote:58]chapter:14)+"_"+String:C10([TechNote:58]section:15)+".html"
						WA OPEN URL:C1020(WebTech; $theURL)
						DELAY PROCESS:C323(Current process:C322; 60)
						//  --  CHOPPED  AL_UpdateArrays(eTNList; -2)
					: (<>TechNoteOption=4)
						C_TEXT:C284(tinyMCE_Content_t)
						tinyMCE_Content_t:=[TechNote:58]bodyText:23
						C_TEXT:C284($wa_htmlEditor_path_t)
						$wa_htmlEditor_path_t:=Get 4D folder:C485(Current resources folder:K5:16)+"tinymce"+Folder separator:K24:12+"htmleditor.html"
						$wa_htmlEditor_path_t:=Convert path system to POSIX:C1106($wa_htmlEditor_path_t)
						WA OPEN URL:C1020(WebTech; "file:///"+$wa_htmlEditor_path_t)
						DELAY PROCESS:C323(Current process:C322; 60)
						//  --  CHOPPED  AL_UpdateArrays(eTNList; -2)
				End case 
			End if 
			
			If ((OptKey=1) & (ALProEvt=2))
				DB_ShowCurrentSelection(->[TechNote:58]; ""; 1; "")
			End if 
			myOK:=0
		End if 
		ALProEvt:=0
End case 