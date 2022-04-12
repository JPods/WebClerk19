//%attributes = {}
// ### bj ### 20180918_2248


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/18/18, 22:48:16
// ----------------------------------------------------
// Method: TNToWebAreaTinymce
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1)


<>TechNoteOption:=0
Case of 
	: (<>TechNoteOption=0)  // internal
		tinyMCE_Content_t:=[TechNote:58]BodyText:23
		C_TEXT:C284($wa_htmlEditor_path_t)
		WA EXECUTE JAVASCRIPT FUNCTION:C1043(WebTech; "setContent"; *; tinyMCE_cleanCR(tinyMCE_Content_t))
		
		
		
		
	: (<>TechNoteOption=1)
		If ([TechNote:58]Name:2="TableOfContents")
			WebTech_URL:="file:///"+<>jitHelpFolder+"technotes/Contents.html"
		Else 
			$theText:="Chap_"+String:C10([TechNote:58]Chapter:14; "000")
			WebTech_URL:="file:///"+<>jitHelpFolder+"technotes/"+$theText+"/"+String:C10([TechNote:58]Chapter:14)+"_"+String:C10([TechNote:58]Section:15)+".html"
		End if 
		
		WA OPEN URL:C1020(WebTech; WebTech_URL)
		DELAY PROCESS:C323(Current process:C322; 10)
		
		
	: (<>TechNoteOption=4)  // open with edit abilities
		C_TEXT:C284(tinyMCE_Content_t)
		tinyMCE_Content_t:=[TechNote:58]BodyText:23
		C_TEXT:C284($wa_htmlEditor_path_t)
		$wa_htmlEditor_path_t:=Get 4D folder:C485(Current resources folder:K5:16)+"tinymce"+Folder separator:K24:12+"htmleditor.html"
		
		// check systems
		$wa_htmlEditor_path_t:=Convert path system to POSIX:C1106($wa_htmlEditor_path_t)
		
		
		WA OPEN URL:C1020(WebTech; "file:///"+$wa_htmlEditor_path_t)
		WA SET PREFERENCE:C1041(*; "WebTech"; WA enable Web inspector:K62:7; True:C214)
		
End case 
b1:=1
// REDUCE SELECTION([TechNote];0)