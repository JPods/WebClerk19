

Case of 
	: (Form event code:C388=On End URL Loading:K2:47)
		
		tinyMCE_Content_t:=[QQQObjective:145]Logistics:25
		tinyMCE_Content_t:=PathsRelativeReplace(tinyMCE_Content_t)
		WA EXECUTE JAVASCRIPT FUNCTION:C1043(myWebArea; "setContent"; *; tinyMCE_cleanCR(tinyMCE_Content_t))
		
	: (Form event code:C388=On Load:K2:1)
		C_TEXT:C284($wa_htmlEditor_path_t)
		$wa_htmlEditor_path_t:=Get 4D folder:C485(Current resources folder:K5:16)+"tinymce"+Folder separator:K24:12+"htmleditor.html"
		$wa_htmlEditor_path_t:=Convert path system to POSIX:C1106($wa_htmlEditor_path_t)
		WA OPEN URL:C1020(myWebArea; "file:///"+$wa_htmlEditor_path_t)
		
		
		/// tinyMCE_editContent (->[htmlpage]htmlContent)
End case 


